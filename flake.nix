{
  description = "A very basic flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; 
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =  inputs @ {
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-stable,
    home-manager,
    ... }:
  let
    system = "x86_64-linux";
    
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };


    overlay-unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config = { allowUnfree = true; };
      };
    };

    overlay-stable = final: prev: {
      stable = import nixpkgs-stable {
        inherit system;
        config = { allowUnfree = true; };
      };
    };

    lib = nixpkgs.lib;
    
  in {

    homeConfigurations = {
      noah = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable overlay-stable ]; })
          ./nixos-homemanager/users/noah/home.nix
          {
            home = {
              username = "noah";
              homeDirectory = "/home/noah";
              stateVersion = "22.05";
            };
          }
        ];
      };
    };
    
    nixosConfigurations = {
      nix = lib.nixosSystem {
        inherit system;
        
        modules = [
          # Overlays-module makes "pkgs.unstable" available in home.nix
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable overlay-stable ]; })
          ./nixos-system/configuration.nix
        ];
      };
    };

  };
}
