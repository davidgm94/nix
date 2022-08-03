{
    description = "David Gonzalez Martin's nix configuration";

    inputs =
    {
        nixpkgs.url = "nixpkgs/nixos-22.05";
	nixos-wsl.url = "github:nix-community/nixos-wsl/main";
    };

    outputs = { self, nixpkgs, nixos-wsl, ... } @attrs: 
    let
        wsl2_x86_64_gui_hostname = "wsl2-x86-gui";
        laptop_x86_64_linux_hostname = "linux-x86-laptop";
	user = "david";
    in
    {
	nixosConfigurations.${wsl2_x86_64_gui_hostname} = nixpkgs.lib.nixosSystem {
	    system = "x86_64-linux";
	    specialArgs = attrs;
	    modules = [
		./${wsl2_x86_64_gui_hostname}/configuration.nix
		nixos-wsl.nixosModules.wsl {
		wsl = {
		    enable = true;
		    automountPath = "/mnt";
		    defaultUser = "${user}";
		    startMenuLaunchers = true;
		    wslConf.network.hostname = "${wsl2_x86_64_gui_hostname}";
		    };
		}
	    ];
	};

	nixosConfigurations.${laptop_x86_64_linux_hostname} = nixpkgs.lib.nixosSystem {
	    system = "x86_64-linux";
	    specialArgs = attrs;
	    modules = [
		./${laptop_x86_64_linux_hostname}/configuration.nix
	    ];
	};
    };
}
