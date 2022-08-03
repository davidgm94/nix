{
    description = "David Gonzalez Martin's nix configuration";

    inputs =
    {
        nixpkgs.url = "nixpkgs/nixos-22.05";
	nixos-wsl.url = "github:nix-community/nixos-wsl/main";
	homeManager = {
		url = "github:nix-community/home-manager/release-22.05";
      		inputs.nixpkgs.follows = "nixpkgs";
    	};
    };

    outputs = { self, nixpkgs, nixos-wsl, homeManager, ... } @attrs: 
    let
	user = "david";
    in
    {
        nixosConfigurations.wsl2-x86-gui = nixpkgs.lib.nixosSystem {
	    system = "x86_64-linux";
	    specialArgs = attrs;
	    modules = [
		./system/common.nix
		./system/common_linux.nix
		nixos-wsl.nixosModules.wsl {
		  wsl = {
		    enable = true;
		    automountPath = "/mnt";
		    defaultUser = "${user}";
		    startMenuLaunchers = true;
		    wslConf.network.hostname = "wsl2-x86-gui";
		    };
		}
	    ];
	};

	nixosConfigurations.linux-x86-laptop = nixpkgs.lib.nixosSystem {
	    system = "x86_64-linux";
	    specialArgs = attrs;
	    modules = [
	        ./system/common.nix
		./system/common_linux.nix
		./system/linux-x86-laptop/configuration.nix
	    ];
	};
    };
}
