{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-new-stable.url = "nixpkgs/c716603a63aca44";
    unstable.url = "nixpkgs/b30f97d8c32d";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    firefox-addons.url = gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons;
    nix-search-cli.url = "github:peterldowns/nix-search-cli";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-new-stable,
    unstable,
    home-manager,
    nix-doom-emacs,
    firefox-addons,
    nix-search-cli,
  }: let
    # Values you should modify
    username = "theo"; # $USER
    system = "x86_64-linux"; # x86_64-linux, aarch64-multiplatform, etc.
    #username = "ubuntu";
    #system = "aarch64-linux";

    stateVersion = "23.11"; # See https://nixos.org/manual/nixpkgs/stable for most recent

    pkgs-home-manager = import nixpkgs-new-stable {
      inherit system;

      config = {
        allowUnfree = true;
      };
      overlays = [
        (final: prev: {unstable = unstable.legacyPackages.${prev.system};})
        (
          final: prev: {
            copilot_el_src = prev.fetchFromGitHub {
              owner = "zerolfx";
              repo = "copilot.el";
              rev = "5858091d8be354caaa28614a89e98cce9d234fa7";
              sha256 = "sha256-eBvSQLaH0vW2u99g1H2OKpuF0YKChFIIcf8zQDHiGQQ=";
            };
          }
        )
      ];
    };
    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };

    homeDirPrefix =
      if pkgs.stdenv.hostPlatform.isDarwin
      then "/Users"
      else "/home";
    homeDirectory = "/${homeDirPrefix}/${username}";

    home = import ./home.nix {
      inherit
        homeDirectory
        pkgs-home-manager
        stateVersion
        system
        username
        nix-doom-emacs
        firefox-addons
        nix-search-cli
        ;
      lite = false; # Set to true to exclude heavy packages
    };
  in {
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgs-home-manager;
      modules = [
        home
      ];
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations.lutfisk = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [./configuration.nix];
    };
  };
}
