{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/3d8f0f3f72a6"; # 2026-05-24
    nixpkgs-tripe.url = "nixpkgs/3d8f0f3f72a6"; # 2026-05-24
    nixpkgs-hm.url = "nixpkgs/3d8f0f3f72a6"; # 2026-05-24
    nixpkgs-hm-unstable.url = "nixpkgs/3d8f0f3f72a6"; # 2026-05-24
    nixpkgs-hm-unstable-lite.url = "nixpkgs/3d8f0f3f72a6"; # 2026-05-24
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons.url = gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons;
    nix-search-cli.url = "github:peterldowns/nix-search-cli";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-tripe,
    nixpkgs-hm,
    nixpkgs-hm-unstable,
    nixpkgs-hm-unstable-lite,
    home-manager,
    firefox-addons,
    nix-search-cli,
  }: let
    # Values you should modify
    username = "theo"; # $USER
    system = "x86_64-linux"; # x86_64-linux, aarch64-multiplatform, etc.
    #username = "ubuntu";
    #system = "aarch64-linux";

    stateVersion = "23.11"; # See https://nixos.org/manual/nixpkgs/stable for most recent

    pkgs-home-manager = import nixpkgs-hm {
      inherit system;

      config = {
        allowUnfree = true;
      };
      overlays = [
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
    pkgs-hm-unstable = import nixpkgs-hm-unstable {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };
    pkgs-hm-unstable-lite = import nixpkgs-hm-unstable-lite {
      inherit system;

      config = {
        allowUnfree = true;
      };
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
        pkgs-hm-unstable
        pkgs-hm-unstable-lite
        stateVersion
        system
        username
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

    nixosConfigurations.tripe = nixpkgs-tripe.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [./tripe/configuration.nix];
    };
  };
}
