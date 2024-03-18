{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
  };


  outputs = { self, nixpkgs, nixpkgs-stable,  ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      pkgs = import nixpkgs{
	  	inherit system;

		config = {
		  allowUnfree = true;
		};
      };

      pkgs-stable = import nixpkgs-stable{
	  	inherit system;

		config = {
		  allowUnfree = true;
		};
      };

      username = "god";
      name = "Louis";
    in {
      nixosConfigurations = {
        myNixos = lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit username;
            inherit name;
            inherit pkgs-stable;
          };
          modules = [ ./nixos/configuration.nix ];
        };
      };
	};
}
