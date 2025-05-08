# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-cedafc89-45b8-4107-a73c-6a9b05a10507".device = "/dev/disk/by-uuid/cedafc89-45b8-4107-a73c-6a9b05a10507";
  boot.initrd.luks.devices."luks-cedafc89-45b8-4107-a73c-6a9b05a10507".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "lutfisk"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Automatically set time zone
  services.automatic-timezoned.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.theo = {
    isNormalUser = true;
    description = "Theodore Ehrenborg";
    extraGroups = ["networkmanager" "wheel" "video" "docker"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.usbmuxd.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    obs-studio
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    #cowsay
    # xorg.xbacklight
    mosh
    libimobiledevice
    ifuse
    # openvpn
    zoom-us
    teams-for-linux
    #pinentry-curses
    vulkan-tools
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers
    libGL
    libGLU
  ];
  programs.light.enable = true;

  systemd.user.timers.screen-time = {
    description = "Reminder to look away from screen Timer";
    timerConfig = {
      OnCalendar = "*:0/20:0";
    };
    wantedBy = ["timers.target"];
  };

  systemd.user.services.screen-time = {
    description = "Reminder to look away from screen";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.libnotify}/bin/notify-send -t 20000 202020 -u low";
    };
  };

  systemd.user.timers.morning-alarm = {
    description = "Morning Alarm Timer";
    timerConfig = {
      OnCalendar = "Mon-Sat 08:00";
      AccuracySec = "1s";
    };
    wantedBy = ["timers.target"];
  };

  systemd.user.services.morning-alarm = {
    description = "Morning Alarm";
    serviceConfig = {
      Type = "oneshot";
      Environment = "PATH=${pkgs.acpi}/bin:${pkgs.alsa-utils}/bin:${pkgs.sox}/bin:$PATH";
      ExecStart = "/home/theo/projects/alarm/target/debug/alarm";
    };
  };

  systemd.user.services.battery-checker = {
    description = "Battery status monitor";
    serviceConfig = {
      Type = "simple";
      Environment = "PATH=${pkgs.acpi}/bin:${pkgs.libnotify}/bin:$PATH";
      ExecStart = "/home/theo/projects/battery_checker/target/debug/battery_checker";
      Restart = "on-failure";
    };
    wantedBy = ["default.target"];
    after = ["graphical-session.target"];
  };

  systemd.user.services.xautolock = {
    description = "XAutolock service";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.xautolock}/bin/xautolock -time 5 -locker \"${pkgs.i3lock}/bin/i3lock\" -notify 5 -notifier \"${pkgs.libnotify}/bin/notify-send 'Locking in 5' -t 5000\"";
      Restart = "on-failure";
    };
    wantedBy = ["default.target"];
    after = ["graphical-session.target"];
  };

  # Git auto-commit timer
  systemd.user.timers.git-autocommit = {
    description = "Timer for automatic Git commits";
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "1min";
      AccuracySec = "1s";
    };
    wantedBy = ["timers.target"];
  };

  # Git auto-commit service
  systemd.user.services.git-autocommit = {
    description = "Automatic Git commit service";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "git-autocommit" ''
        echo "HOME is $HOME"
        # For org-roam
        cd $HOME/org/roam || exit 1
        ${pkgs.findutils}/bin/find . -name "*.org" -o -name "*.org_archive" | xargs ${pkgs.git}/bin/git add || true
        ${pkgs.git}/bin/git commit -m "Automatic minutely commit" || true

        # For password-store
        cd $HOME/.password-store || exit 1
        ${pkgs.git}/bin/git add * || true
        ${pkgs.git}/bin/git commit -m "Automatic minutely commit" || true

        # For ledger
        cd $HOME/ledger || exit 1
        ${pkgs.git}/bin/git add * || true
        ${pkgs.git}/bin/git commit -m "Automatic minutely commit" || true
      ''}";
    };
  };

  # Git auto-push timer - runs less frequently to handle internet issues
  systemd.user.timers.git-autopush = {
    description = "Timer for automatic Git pushes";
    timerConfig = {
      OnBootSec = "5min";
      OnUnitActiveSec = "5min"; # Run every 5 minutes
      AccuracySec = "1s";
    };
    wantedBy = ["timers.target"];
  };

  # Git auto-push service
  systemd.user.services.git-autopush = {
    description = "Automatic Git push service";
    serviceConfig = {
      Type = "oneshot";
      TimeoutSec = "30s"; # Timeout after 30 seconds to prevent hanging
      Environment = "PATH=${pkgs.openssh}/bin:$PATH";
      ExecStart = "${pkgs.writeShellScript "git-autopush" ''
        # For org-roam
        cd $HOME/org/roam || exit 1
        ${pkgs.git}/bin/git push || true

        # For password-store
        cd $HOME/.password-store || exit 1
        ${pkgs.git}/bin/git push || true

        # For ledger
        cd $HOME/ledger || exit 1
        ${pkgs.git}/bin/git push || true
      ''}";
    };
  };

  # EC2 instance checker timer
  systemd.user.timers.ec2-checker = {
    description = "Timer for checking EC2 instances";
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "1h";
      AccuracySec = "1s";
    };
    wantedBy = ["timers.target"];
  };

  # EC2 instance checker service
  systemd.user.services.ec2-checker = {
    description = "Check for running EC2 instances";
    serviceConfig = {
      Type = "oneshot";
      Environment = "PATH=${pkgs.awscli2}/bin:${pkgs.jq}/bin:${pkgs.libnotify}/bin:$PATH";
      ExecStart = "${pkgs.writeShellScript "check-ec2" ''
        # Get instance info in JSON format
        instances=$(aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name]' --output json)

        # Count running instances using jq
        running_count=$(echo "$instances" | jq -r 'flatten(1) | map(select(.[1] == "running")) | length')
        echo "$running_count"

        if [ "$running_count" -gt 0 ]; then
          notify-send -t 0 "EC2 Alert" "$running_count instance(s) currently running"
        fi
      ''}";
    };
  };

  systemd.user.services.fava = {
    description = "Fava Beancount service";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.fava}/bin/fava %h/ledger/transactions.beancount";
      Restart = "on-failure";
    };
    wantedBy = ["default.target"];
    after = ["graphical-session.target"];
  };

  systemd.user.services.camera-checker = {
    description = "Camera checker";
    serviceConfig = {
      Type = "simple";
      Environment = "PATH=${pkgs.which}/bin:${pkgs.lsof}/bin:${pkgs.libnotify}/bin:$PATH";
      ExecStart = "/home/theo/projects/camera_watcher/target/debug/camera_watcher";
      Restart = "on-failure";
    };
    wantedBy = ["default.target"];
    after = ["graphical-session.target"];
  };

  systemd.services.resume-script = {
    description = "Resume script";
    after = ["suspend.target" "hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target"];
    wantedBy = ["suspend.target" "hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.writeShellScript "resume-script" ''
        if [ -d "$HOME/projects/LibreChat" ]; then
          cd "$HOME/projects/LibreChat"
          /run/current-system/sw/bin/docker compose restart
        fi
      ''}";
      User = "theo";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  users.users."theo".openssh.authorizedKeys.keys = [
    # iphone:
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIALa987H4dmEOjWUZPmyr7f9C8idT3jyXGzE4p6F60kU"
    # ipad:
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF6tJDZZH05hF5GD623Xwuk27G374ZDGyhTJ8lYlTmpd"
  ];
  programs.mosh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  # for i3
  environment.pathsToLink = ["/libexec"];

  services.xserver = {
    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:escape";
    };
    # install i3
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3lock
        i3status
      ];
    };
  };
  services.libinput.touchpad.tapping = false;
  services.displayManager = {
    defaultSession = "none+i3";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    # trace: warning: xdg-desktop-portal 1.17 reworked how portal implementations are loaded, you
    # should either set `xdg.portal.config` or `xdg.portal.configPackages`
    # to specify which portal backend to use for the requested interface.

    # https://github.com/flatpak/xdg-desktop-portal/blob/1.18.1/doc/portals.conf.rst.in

    # If you simply want to keep the behaviour in < 1.17, which uses the first
    # portal implementation found in lexicographical order, use the following:
    config.common.default = "*";
  };
  services.flatpak.enable = true;

  services.atd.enable = true;

  # For nvidia
  # Make sure opengl is enabled
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      libGL
      libGLU
    ];
  };

  # Tell Xorg to use the nvidia driver (also valid for Wayland)
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    #   # Modesetting is needed for most Wayland compositors
    #   modesetting.enable = true;

    #   # Use the open source version of the kernel module
    #   # Only available on driver 515.43.04+
    open = false;

    #   # Enable the nvidia settings menu
    #   nvidiaSettings = true;

    #   # Optionally, you may need to select the appropriate driver version for your specific GPU.
    #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  boot.blacklistedKernelModules = ["i915"];

  nix.settings.experimental-features = "nix-command flakes";

  programs.gnupg.agent = {
    enable = true;
    #    pinentryFlavor = "curses";
  };

  security.sudo.extraRules = [
    {
      groups = ["wheel"];
      commands = ["${pkgs.light}/bin/light"];
    }
  ];
  #services.pcscd.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  virtualisation.docker.enable = true;
  hardware.nvidia-container-toolkit.enable = true;

  services.printing.enable = true;
  # Canon drivers
  services.printing.drivers = [pkgs.cnijfilter2];

  programs.steam = {
    enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
