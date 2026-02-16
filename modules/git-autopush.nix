{ config, pkgs, ... }:

{
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
}
