{
    description = "David Gonzalez Martin's nix configuration";

    inputs =
    {
        nixpkgs.url = "nixpkgs/nixos-22.05";
	nixos-wsl.url = "github:nix-community/nixos-wsl/main";
	home-manager = {
		url = "github:nix-community/home-manager/release-22.05";
      		inputs.nixpkgs.follows = "nixpkgs";
    	};
    };

    outputs = { self, nixpkgs, nixos-wsl, home-manager, ... } @attrs: 
    let
	user = "david";
	# TODO: MacOS
	system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        wsl2-x86-gui = nixpkgs.lib.nixosSystem {
	    system = system;
	    specialArgs = attrs;
	    modules = [
		./nix/system/common.nix
		./nix/system/common_linux.nix
		home-manager.nixosModules.home-manager
		{
		    home-manager.useGlobalPkgs = true;
		    home-manager.useUserPackages = true;
		    home-manager.users.${user} = import ./nix/user/home.nix;
		}
		nixos-wsl.nixosModules.wsl {
		  wsl = {
		    enable = true;
		    automountPath = "/mnt";
		    defaultUser = user;
		    startMenuLaunchers = true;
		    wslConf.network.hostname = "wsl2-x86-gui";
		    };
		}
	    ];
	};

	linux-x86-laptop = nixpkgs.lib.nixosSystem {
	    system = system;
	    specialArgs = attrs;
	    modules = [
	        ./nix/system/common.nix
		./nix/system/common_linux.nix
		./nix/system/linux-x86-laptop/configuration.nix
		home-manager.nixosModules.home-manager
		{
		    home-manager.useGlobalPkgs = true;
		    home-manager.useUserPackages = true;
		    home-manager.users.${user} = import ./nix/user/home.nix;
		}
	    ];
	};

	};
    };
}
