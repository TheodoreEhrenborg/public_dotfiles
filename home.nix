{
  homeDirectory,
  pkgs-home-manager,
  stateVersion,
  system,
  username,
  nix-doom-emacs,
  firefox-addons,
  nix-search-cli,
  lite,
  public ? true,
}: let
  packages = import ./packages.nix {inherit pkgs-home-manager system nix-search-cli lite;};
in {
  home = {
    inherit homeDirectory packages stateVersion username;
    shellAliases = {
      reload-home-manager-config = "home-manager switch --flake ${builtins.toString ./.}";
    };
    file =
      {
        ".config/zellij/config.kdl".source = ./zellij_config.kdl;
        ".config/alacritty/alacritty.toml".source = ./alacritty.toml;
        ".config/zathura/zathurarc".source = ./zathurarc;
        "reorder.bash".source = ./reorder.bash;
        "copy.bash".source = ./scripts/copy_remote.bash;
        ".config/fish/functions/fish_prompt.fish".source = ./fish_prompt.fish;
        ".doom.d".source = ./doom.d;
        ".vimrc".source = ./vimrc;
        ".visidatarc".source = ./visidatarc;
        # Else visidata complains about the folder not existing:
        ".visidata/.keep".text = "";
        ".wezterm.lua".source = ./wezterm.lua;
        ".julia/config/startup.jl".source = ./julia/config/startup.jl;
        #sessionVariables.EMACS_PATH_COPILOT = "${pkgs-home-manager.copilot_el_src}";
      }
      // (
        if !public
        then {
          ".config/i3/config".source = ./i3_config;
          ".config/i3/i3_swap.bash".source = ./i3_swap.bash;
          ".config/i3status/config".source = ./i3status_config;
          ".config/fish/fish_variables".source = ./fish_variables;
          ".config/restic/restic_ignore".source = ./restic_ignore;
          ".config/fish/config.fish" = {
            text =
              (builtins.readFile ./config.fish)
              + ''
                set -gx EMACS_PATH_COPILOT ${pkgs-home-manager.copilot_el_src};
              '';
          };
          "docs/my-abbreviations.el".source = ./my-abbreviations.el;
        }
        else {}
      );
  };

  nixpkgs = {
    config = {
      inherit system;
      allowUnfree = true;
      allowUnsupportedSystem = true;
      experimental-features = "nix-command flakes";
    };
  };

  imports = [nix-doom-emacs.hmModule];
  programs = import ./programs.nix {inherit pkgs-home-manager firefox-addons lite;};
}
