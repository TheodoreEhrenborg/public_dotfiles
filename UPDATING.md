# When I say update the packages

This means update these 3:

    nixpkgs-hm.url 
    nixpkgs-hm-unstable.url 
    nixpkgs-hm-unstable-lite.url 

Go to https://github.com/nixos/nixpkgs and pick a commit that's at least a week old (to avoid supply-chain attacks) but no older. 

Once you have a hash, also google "nixpkgs security issues" and "nixos security issues" to make sure there haven't been any security issues recently. If so, abort.

Update these 3 hashes. Run `home-manager switch --flake ~/dotfiles`. If there are any issues, resolve them and remember to tell me about them. Then jj commit.

Do not pipe the output into tail. Feel free to pipe to a file to spare your context. It may be necessary to see the errors/warnings. This holds double for updating the OS, since the build command often prints warnings about upcoming breaking changes and then doesn't ever print them again

# When I say update the OS

This means update these 2:

    nixpkgs.url 
    nixpkgs-tripe.url 
    
Likewise pick a hash and update, following the security practices above

Then run nixos-rebuild build --flake ~/dotfiles#tripe, fix issues (there will almost certainly be changes needed for compatibility), repeat, commit.

The OS doesn't switch until someone runs sudo nixos-rebuild switch --flake ~/dotfiles#tripe, but leave that to me
