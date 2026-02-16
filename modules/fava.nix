{ config, pkgs, ... }:

{
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
}
