{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";



  };


  outputs = { self, nixpkgs, nixpkgs-unstable }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      pkgs = import nixpkgs{
	  	inherit system;

		config = {
		  allowUnfree = true;
		};
      };

      pkgs-unstable = import nixpkgs-unstable{
	  	inherit system;

		config = {
		  allowUnfree = true;
		};
      };


      username = "louis";
      name = "Louis";
    in {
      nixosConfigurations = {
        myNixos = lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit username;
            inherit name;
            inherit pkgs-unstable;
          };
          modules = [
	    ./nixos/configuration.nix

	  ];
        };
      };
    };
}
