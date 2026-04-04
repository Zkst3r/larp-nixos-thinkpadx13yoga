{
  description = "My config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    niri.url = "github:YaLTeR/niri";    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let
      mkSystem = hostname: system: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs hostname; };
        modules = [
          ./hosts/${hostname}/configuration.nix
          
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs hostname; };
            home-manager.users.kster = import ./modules/home.nix;
          }
        ];
      };
    in {
      nixosConfigurations = {
        desktop = mkSystem "desktop" "x86_64-linux";
        laptop  = mkSystem "laptop"  "x86_64-linux";
      };
    };
}
