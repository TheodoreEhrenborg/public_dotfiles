{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-tripe.url = "nixpkgs/fa56d7d6de78f5a7f997b0ea2bc6efd5868ad9e8"; # 25.11 from 2026 Feb 17
    nixpkgs-hm.url = "nixpkgs/5ac14523b6ae"; # June 2025
    nixpkgs-hm-unstable.url = "nixpkgs/aca2499b7917"; # 2025-08-29
    nixpkgs-hm-unstable-lite.url = "nixpkgs/2343bbb58f99"; # Feb 12 2026
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
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

    nixosConfigurations.tripe = nixpkgs-tripe.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [./tripe/configuration.nix];
    };
  };
}
