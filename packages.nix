{
  pkgs-home-manager,
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
      rev = "c9eec98424e24c619006aac5b38148eeee168d19";
      sha256 = "sha256-PAOHELG15SVArba0pDbyJ66HLMRB+A4oCYZSaEIGWRM=";
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
      unstable.ruff
      mypy
      du-dust
      qrencode
      fd
      ripgrep
      restic
      unstable.rustup # Org babel needs cargo installed with rustup
      fish
      tldr
      hyperfine
      py-spy
      feh
      moreutils
      (hiPrio parallel) # GNU parallel. moreutils has a different version
      unstable.zoxide
      yt-dlp
      ffmpeg
      (sox.override {
        enableLame = true;
      })
      iotop
      pv
      zstd
      jq
      unstable.mpv # Stable seems to be broken
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
      beancount
      ledger
      fava
      tree # /snap/bin/tree didn't work on ash:/data
      vim # Not installed by default on NixOS
      acpi # Not installed by default on NixOS
      alacritty # For NixOS
      st # For Ubuntu
      #    firefox
      xclip
      pass
      kdeconnect
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
      unstable.mdbook # Use more recent version to get smart punctuation
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
      unstable.aider-chat
    ]
    ++ (
      if !lite
      then [
        anki
        zotero
      ]
      else []
    );
in
  myPackages
