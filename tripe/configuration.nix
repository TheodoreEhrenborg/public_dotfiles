# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../modules/git-autopush.nix
      ../modules/fava.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # This didn't fix the issue where I had to move the mouse to see updates to terminal/emacs,
  # but I guess it can't hurt
  boot.kernelPackages = pkgs.linuxPackages_6_18;
  # This fixed that issue
  boot.kernelParams = [ "amdgpu.dcdebugmask=0x10" "amdgpu.gttsize=25600" "ttm.pages_limit=7077888" ];

  # See https://github.com/ARitz-Cracker/nixos/blob/af162805a25f39460b702bfa2af467386faf637f/components/hardware_workarounds/mt7925e.nix
  # and https://zbowling.github.io/mt7925/
  boot.kernelPatches = [
      {
        name = "0001-wifi-mt76-mt7925-fix-potential-deadlock-in-mt7925_ro.patch";
        patch = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/zbowling/mt7925/a00b48b86fc230437e88a798719b27631df18e9a/kernels/6.18/0001-wifi-mt76-mt7925-fix-potential-deadlock-in-mt7925_ro.patch";
          sha256 = "sha256-gKXixC+7avlJKO0fdp0QV9sNS5gOtD9OW9gdRHLwRnI=";
        };
      }
      {
        name = "0002-wifi-mt76-fix-list-corruption-in-mt76_wcid_cleanup.patch";
        patch = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/zbowling/mt7925/a00b48b86fc230437e88a798719b27631df18e9a/kernels/6.18/0002-wifi-mt76-fix-list-corruption-in-mt76_wcid_cleanup.patch";
          sha256 = "sha256-i5ZnuWqds9MoZSMPnNsC7s1amR3Kc5nSvYax7WRbwSA=";
        };
      }
      {
        name = "0003-wifi-mt76-mt792x-fix-NULL-pointer-and-firmware-reloa.patch";
        patch = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/zbowling/mt7925/a00b48b86fc230437e88a798719b27631df18e9a/kernels/6.18/0003-wifi-mt76-mt792x-fix-NULL-pointer-and-firmware-reloa.patch";
          sha256 = "sha256-oid8kSIWYqahkhV4myy6sP+jMI1SMHyRDrKLdZ7FVCg=";
        };
      }
      {
        name = "0004-wifi-mt76-mt7921-add-mutex-protection-in-critical-pa.patch";
        patch = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/zbowling/mt7925/a00b48b86fc230437e88a798719b27631df18e9a/kernels/6.18/0004-wifi-mt76-mt7921-add-mutex-protection-in-critical-pa.patch";
          sha256 = "sha256-iRRqJ0E06Df0rUz3pyxXeMPzeRn89L2qZxdCI66gsG0=";
        };
      }
      {
        name = "0005-wifi-mt76-mt7925-add-comprehensive-NULL-pointer-prot.patch";
        patch = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/zbowling/mt7925/a00b48b86fc230437e88a798719b27631df18e9a/kernels/6.18/0005-wifi-mt76-mt7925-add-comprehensive-NULL-pointer-prot.patch";
          sha256 = "sha256-BfO4HEeWxGNXx7efPaFFcbAGkcMQCbN0nAzUhrlxrB8=";
        };
      }
      {
        name = "0006-wifi-mt76-mt7925-add-mutex-protection-in-critical-pa.patch";
        patch = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/zbowling/mt7925/a00b48b86fc230437e88a798719b27631df18e9a/kernels/6.18/0006-wifi-mt76-mt7925-add-mutex-protection-in-critical-pa.patch";
          sha256 = "sha256-cUlQoyUrRZUuRXpkLV7gcvQWgWTjC9WmXuvujWhFPtU=";
        };
      }
      {
        name = "0007-wifi-mt76-mt7925-add-MCU-command-error-handling.patch";
        patch = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/zbowling/mt7925/a00b48b86fc230437e88a798719b27631df18e9a/kernels/6.18/0007-wifi-mt76-mt7925-add-MCU-command-error-handling.patch";
          sha256 = "sha256-08/86bLgmXH3BYw4VgwK0L3hwB130feR8qeKtawGgXU=";
        };
      }
      {
        name = "0008-wifi-mt76-mt7925-add-lockdep-assertions-for-mutex-ve.patch";
        patch = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/zbowling/mt7925/a00b48b86fc230437e88a798719b27631df18e9a/kernels/6.18/0008-wifi-mt76-mt7925-add-lockdep-assertions-for-mutex-ve.patch";
          sha256 = "sha256-kJSCoYNqkeUVwGuyaUzcEHGMYxIaZSF4kK8kzJSYYJQ=";
        };
      }
      {
        name = "0009-wifi-mt76-mt7925-fix-MLO-roaming-and-ROC-setup-issue.patch";
        patch = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/zbowling/mt7925/a00b48b86fc230437e88a798719b27631df18e9a/kernels/6.18/0009-wifi-mt76-mt7925-fix-MLO-roaming-and-ROC-setup-issue.patch";
          sha256 = "sha256-+pHxkdw8iFDUfQYILdvFGW++uL5j53j1/S0Emw4qLe4=";
        };
      }
      {
        name = "0010-wifi-mt76-mt7925-fix-BA-session-teardown-during-beac.patch";
        patch = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/zbowling/mt7925/a00b48b86fc230437e88a798719b27631df18e9a/kernels/6.18/0010-wifi-mt76-mt7925-fix-BA-session-teardown-during-beac.patch";
          sha256 = "sha256-QJJgewPxRTqaMvhRTQ5tXFe6sNx7eVtBu7k+rWSnVk4=";
        };
      }
      {
        name = "0011-wifi-mt76-mt7925-fix-ROC-deadlocks-and-race-conditio.patch";
        patch = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/zbowling/mt7925/a00b48b86fc230437e88a798719b27631df18e9a/kernels/6.18/0011-wifi-mt76-mt7925-fix-ROC-deadlocks-and-race-conditio.patch";
          sha256 = "sha256-8bRFyCCZ3AZuWkwDTGfeS8U/3o0pCRRX/PeY2nx4OCo=";
        };
      }
      {
        name = "0012-wifi-mt76-mt7925-fix-double-wcid-initialization-race.patch";
        patch = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/zbowling/mt7925/a00b48b86fc230437e88a798719b27631df18e9a/kernels/6.18/0012-wifi-mt76-mt7925-fix-double-wcid-initialization-race.patch";
          sha256 = "sha256-Ro4zxZ162iPNi20Kkwk5qWrqqpx7XuUfC+O+EFg78dY=";
        };
      }
    ];

  boot.initrd.luks.devices."luks-94672f5b-1f26-4f8e-8904-75caf56c62ab".device = "/dev/disk/by-uuid/94672f5b-1f26-4f8e-8904-75caf56c62ab";
  networking.hostName = "tripe"; # Define your hostname.
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

  # Define a user account. Don't forget to set a password with 'passwd'.
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
    mosh
    libimobiledevice
    ifuse
    zoom-us
    anki
    teams-for-linux
    distrobox
  ];
  programs.light.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
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
    # lutfisk
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4IgPSH5Kkxy80bIHMjAEN6XovrP2NG/4ccZs8j8Ebdpe3rsE6CmLWohtbKGX6i8yJwQ5jCrrmKmnfx6feOkYaiUY2WLXQQR3hZ4j6GfN52LFzIXnwU84vf0YGSGbhWkrYFRHI16ccYn2IZhSTdxgHvgOehflr2VW7I60y6F8rNNJyfoYHTB/H0zQsoBlLcCLMrEbb5/KpOTIy6B+mn/5+fe74a9YNNJWnslqWI7AHMMzWx8UNzE+3kAY8zuApFe9FXnZNwL05N4l+Y8IzWMaZd7PGg6AUt2BLjx6bGJg8Ob3GogY/nMHxw05xMvYhD4lOz+jqjSUFJ6zQ9C3gWO2OwcIAiXS4kr/LIqwPIRNDxqFUFtU6CWMpUIJ323Yok0nMNwIylMoESFRwOqIFdt66kZyNCGRRAYEJKhp8j9Uqm9P3EncJDFvaw7X4hOYIk1hGWVFfOIfeKAYkIc9F7Qn6x45pYNiFaIj1nn4gamlCGYroAlzrRMLnmHN7YIynrw0= theo@lutfisk"
  ];
  programs.mosh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

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
    config.common.default = "*";
  };
  services.flatpak.enable = true;

  services.atd.enable = true;

  # # Make sure opengl is enabled
  # hardware.graphics = {
  #   enable = true;
  #   enable32Bit = true;
  # };

  nix.settings.experimental-features = "nix-command flakes";

  programs.gnupg.agent = {
    enable = true;
  };

  security.sudo.extraRules = [
    {
      groups = ["wheel"];
      commands = ["${pkgs.light}/bin/light"];
    }
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  virtualisation.docker.enable = true;

  services.printing.enable = true;
  # Canon drivers
  services.printing.drivers = [pkgs.cnijfilter2];

  # Avahi for network printer discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  programs.steam = {
    enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  programs.nix-ld.enable = true;

  # To use cachix
  nix.settings.trusted-users = [ "root" "theo" ];

  services.tailscale.enable = true;


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
      ExecStart = "${pkgs.writeShellScript "dim-lights" ''
              # Check if we're at 0, 20, or 40 minutes past the hour
              # If not, this was triggered post-hoc (e.g., lid just opened)
              current_minute=$(${pkgs.coreutils}/bin/date +%M)
              # Remove leading zero for comparison
              current_minute=$((10#$current_minute))

              if [ $current_minute -ne 0 ] && [ $current_minute -ne 20 ] && [ $current_minute -ne 40 ]; then
                echo Not a scheduled time, so just exit
                exit 0
              fi

              current=$(${pkgs.light}/bin/light -G)
              target=$(echo "$current * 0.1" | ${pkgs.bc}/bin/bc)
              echo Beginning dimming
              ${pkgs.light}/bin/light -S "$target"

              # `sleep 20` won't run while the laptop is closed,
              # so the laptop would often be dim on lid raise

              start_time=$(${pkgs.coreutils}/bin/date +%s)
              end_time=$((start_time + 20))

              while [ $(${pkgs.coreutils}/bin/date +%s) -lt $end_time ]; do
                sleep 0.5
              done

              ${pkgs.light}/bin/light -S "$current"
              echo Done with dimming
      ''}";
    };
  };



  # Vast.ai instance checker timer
  systemd.user.timers.vastai-checker = {
    description = "Timer for checking Vast.ai instances";
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "2h";
      AccuracySec = "1s";
    };
    wantedBy = ["timers.target"];
  };

  # Battery discharge monitor timer
  systemd.user.timers.battery-discharge-monitor = {
    description = "Timer for monitoring battery discharge rate";
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "1min";
      AccuracySec = "1s";
    };
    wantedBy = ["timers.target"];
  };

  # Vast.ai instance checker service
  systemd.user.services.vastai-checker = {
    description = "Check for running Vast.ai instances";
    serviceConfig = {
      Type = "oneshot";
      Environment = "PATH=${pkgs.gnugrep}/bin:${pkgs.coreutils}/bin:${pkgs.uv}/bin:${pkgs.libnotify}/bin:$PATH";
      ExecStart = "${pkgs.writeShellScript "check-vastai" ''
        uvx vastai show instances
        running_count=$(uvx vastai show instances 2>/dev/null | grep theodore | grep -c "running")
        if [ "$running_count" -gt 0 ]; then
          notify-send -t 0 "Vast.ai Alert" "$running_count instance(s) currently running"
        fi
      ''}";
    };
  };

  # Battery discharge monitor service
  systemd.user.services.battery-discharge-monitor = {
    description = "Monitor battery discharge rate";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.acpi}/bin/acpi -b";
    };
  };

  # WiFi network checker timer
  systemd.user.timers.wifi-checker = {
    description = "Timer for checking WiFi network";
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "1min";
      AccuracySec = "1s";
    };
    wantedBy = ["timers.target"];
  };

  # WiFi network checker service
  systemd.user.services.wifi-checker = {
    description = "Check WiFi network and notify if on wrong network";
    serviceConfig = {
      Type = "oneshot";
      Environment = "PATH=${pkgs.gnugrep}/bin:${pkgs.coreutils}/bin:${pkgs.networkmanager}/bin:${pkgs.libnotify}/bin:$PATH";
      ExecStart = "${pkgs.writeShellScript "check-wifi" ''
        set -e
        current_ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d':' -f2)
        echo $current_ssid
        if [ "$current_ssid" = "ALHN-6CF4_EXT" ] || [ "$current_ssid" = "ALHN-6CF4" ]; then
          notify-send -t 10000 "Wrong WiFi Network?" "You're not on ALHN-6CF4_EXT001"
        fi
      ''}";
    };
  };


  systemd.user.timers.git-autocommit-roam = {
    description = "Timer for automatic Git roam commits";
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "1min";
      AccuracySec = "1s";
    };
    wantedBy = ["timers.target"];
  };

  systemd.user.services.git-autocommit-roam = {
    description = "Automatic Git roam commit service";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "git-autocommit" ''
        echo "HOME is $HOME"

        cd $HOME/org/roam || exit 1
        ${pkgs.git}/bin/git add . || true
        ${pkgs.git}/bin/git commit -m "Automatic minutely commit" || true
      ''}";
    };
  };


  systemd.user.timers.git-autocommit-ledger = {
    description = "Timer for automatic Git ledger commits";
    timerConfig = {
      OnCalendar = "*-*-* 02:00:00";
      AccuracySec = "1s";
    };
    wantedBy = ["timers.target"];
  };

  systemd.user.services.git-autocommit-ledger = {
    description = "Automatic Git ledger commit service";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "git-autocommit" ''
        echo "HOME is $HOME"

        cd $HOME/ledger || exit 1
        ${pkgs.git}/bin/git add . || true
        ${pkgs.git}/bin/git commit -m "Automatic daily commit" || true
      ''}";
    };
  };


  systemd.user.services.battery-checker =
    let battery-checker-pkg = pkgs.rustPlatform.buildRustPackage rec {
      pname = "battery_checker";
      version = "0.1.2";
      src = pkgs.fetchFromGitHub {
        owner = "TheodoreEhrenborg";
        repo = "battery_checker";
        rev = "655a361ed1ef6129e945f1f1ce124d5785c68ad0";
        sha256 = "sha256-OpHoGajjPo2jFytOcGlosL/3+O4vGe/UTw+TcBbgPH0=";
      };

      cargoLock = {
        lockFile = src + "/Cargo.lock";
      };
    };
   in
    {
      description = "Battery status monitor";
      serviceConfig = {
        Type = "simple";
        Environment = "PATH=${pkgs.acpi}/bin:${pkgs.libnotify}/bin:$PATH";
        ExecStart = "${battery-checker-pkg}/bin/battery_checker --critical-threshold 35 --warning-threshold 40 --upper-threshold 80";
        Restart = "on-failure";
      };
      wantedBy = ["default.target"];
      after = ["graphical-session.target"];
    };

  # Framework charge limit service
  systemd.services.framework-charge-limit = {
    description = "Set Framework battery charge limit";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.framework-tool}/bin/framework_tool --charge-limit 75";
    };
    wantedBy = ["multi-user.target"];
  };


  # Restic backup timer
  systemd.user.timers.restic-backup = {
    description = "Timer for restic backup to sherekhan";
    timerConfig = {
      OnCalendar = "*-*-* 19:00:00";
      Persistent = true;
      AccuracySec = "1s";
    };
    wantedBy = ["timers.target"];
  };

  # Restic backup service
  systemd.user.services.restic-backup = {
    description = "Restic backup to sherekhan";
    serviceConfig = {
      Type = "oneshot";
      Environment = "PATH=${pkgs.restic}/bin:$PATH";
      Nice = 19;
      ExecStart = "${pkgs.writeShellScript "restic-backup" ''
        set -e

        # Source credentials
        export B2_ACCOUNT_ID=$(${pkgs.coreutils}/bin/cat $HOME/.backblaze/sherekhanKeyID)
        export B2_ACCOUNT_KEY=$(${pkgs.coreutils}/bin/cat $HOME/.backblaze/sherekhanKeySecret)
        export RESTIC_PASSWORD_FILE=$HOME/.backblaze/sherekhanResticPassword

        # Run backup
        restic -r b2:sherekhan:restic-repo-sherekhan2 --verbose backup $HOME/ --exclude-file $HOME/.config/restic/restic_ignore
      ''}";
    };
  };
}
