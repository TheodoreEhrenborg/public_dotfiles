# Based on https://github.com/siraben/dotfiles/blob/master/home-manager/.config/nixpkgs/python-packages.nix
{pkgs-home-manager}:
pkgs-home-manager.python3.withPackages (p:
    with p; [
      ipython
      jupyter
      vulture
      jupytext
      ipykernel
      jupyter_core
      notebook
      openai
      #(
      #    buildPythonPackage rec {
      #      pname = "TTS";
      #      version = "0.11.1";
      #      src = fetchPypi {
      #        inherit pname version;
      #        sha256 = "1ccmvsbacvg4mhxaw97128d5z7dawya01ymydjbfw4i3wnpja3a3";
      #      };
      #      doCheck = false;
      #      propagatedBuildInputs = [
      #         #Specify dependencies
      #        pkgs-home-manager.python39Packages.packaging
      #        pkgs-home-manager.python39Packages.numpy
      #        pkgs-home-manager.python39Packages.cython
      #        # Needs cython==0.29.28, which this one isn't
      #        pkgs-home-manager.python39Packages.g2pkk
      #        pkgs-home-manager.python39Packages.soundfile
      #        pkgs-home-manager.python39Packages.pysbd
      #      ];
      #    }
      #  )
    ])
