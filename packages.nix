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
      fortune
      cowsay
      julia
      ruff
      mypy
      du-dust
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
      (hiPrio parallel) # GNU parallel. moreutils has a different version
      zoxide
      yt-dlp
      ffmpeg
      (sox.override {
        enableLame = true;
      })
      iotop
      pv
      zstd
      jq
      mpv
      pandoc
      poppler_utils # For pdftotext
      ispell
      gcal
      fzf
      htop
      bat
      librsvg
      nodejs # For copilot.el
      pre-commit
      black # Else pre-commit complains
      w3m
      beancount_2
      ledger
      fava
      tree # /snap/bin/tree didn't work on ash:/data
      vim-full # Not installed by default on NixOS
      acpi # Not installed by default on NixOS
      alacritty # For NixOS
      st # For Ubuntu
      #    firefox
      xclip
      pass
      plasma5Packages.kdeconnect-kde
      xautolock
      libnotify # to send notifications for upcoming screen lock
      dunst # daemon that displays the notifications
      i3status
      psmisc # for killall
      zathura
      scrot # screenshots
      zellij
      elan
      file
      github-cli
      visidata
      wget
      unzip
      rlwrap
      viu
      awscli2
      chafa
      wezterm
      lsix
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
      sl
      ollama
      difftastic
      hwatch
      shfmt
      iftop
      pavucontrol
      lsof # for camera checker
      pyright
      zbar
      mermaid-cli
      arandr
      ishango
      aider-chat
      pkgs-hm-unstable-lite.claude-code
      pkgs-hm-unstable-lite.framework-tool-tui
      pkgs-hm-unstable.ungoogled-chromium
      uv
      dafny
      cmake
      gnumake
      libtool
      pkgs-hm-unstable.nushell
      pkgs-hm-unstable.carapace
      pkgs-hm-unstable.starship
      ngrok
      bacon
      zip
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
