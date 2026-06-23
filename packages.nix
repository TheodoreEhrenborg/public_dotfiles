{
  pkgs-home-manager,
  pkgs-hm-unstable,
  pkgs-hm-unstable-lite,
  system,
  nix-search-cli,
  lite,
}: let
  ishango = pkgs-home-manager.rustPlatform.buildRustPackage rec {
    pname = "ishango";
    version = "0.1";
    src = pkgs-home-manager.fetchFromGitHub {
      owner = "TheodoreEhrenborg";
      repo = "ishango";
      rev = "bdee6a5495e8f7471d62e5efee04db81b304f688";
      sha256 = "sha256-g2J2gKmmditEiS6w0zwaGWVsMZoswBYOSaOa84Pv+O0=";
    };

    cargoLock = {
      lockFile = src + "/Cargo.lock";
    };
  };
  myPackages = with pkgs-home-manager;
    [
      (import ./python-packages.nix {pkgs-home-manager = pkgs-home-manager;})
      ruff
      dust
      qrencode
      fd
      ripgrep
      restic
      rustup # Org babel needs cargo installed with rustup
      fish
      tldr
      hyperfine
      py-spy
      feh
      moreutils
      (pkgs-home-manager.lib.hiPrio parallel) # GNU parallel. moreutils has a different version
      zoxide
      iotop
      pv
      zstd
      jq
      mpv
      pandoc
      poppler-utils # For pdftotext
      ispell
      fzf
      htop
      bat
      beancount_2
      fava
      tree # /snap/bin/tree didn't work on ash:/data
      vim-full # Not installed by default on NixOS
      acpi # Not installed by default on NixOS
      st # For Ubuntu
      xclip
      pass
      xautolock
      libnotify # to send notifications for upcoming screen lock
      dunst # daemon that displays the notifications
      i3status
      psmisc # for killall
      zathura
      scrot # screenshots
      elan
      file
      github-cli
      visidata
      wget
      unzip
      rlwrap
      awscli2
      chafa
      ghostscript
      gnupg
      sqlite # for emacs
      gcc # for emacs
      rsync # because otherwise different Ubuntus have different versions
      evcxr
      mdbook
      mdbook-admonish
      nix-search-cli.packages.${system}.default
      rust-script
      timer
      shellcheck
      difftastic
      hwatch
      iftop
      pavucontrol
      lsof # for camera checker
      pyright
      zbar
      arandr
      ishango
      pkgs-hm-unstable.ungoogled-chromium
      pkgs-hm-unstable-lite.claude-code
      pkgs-hm-unstable-lite.framework-tool-tui
      uv
      dafny
      cmake
      gnumake
      libtool
      pkgs-hm-unstable.ngrok
      bacon
      zip
      bubblewrap
      starlark-rust
      janet
      jpm
      bun
      imagemagick
    ]
    ++ (
      if !lite
      then [
        zotero
      ]
      else []
    );
in
  myPackages
