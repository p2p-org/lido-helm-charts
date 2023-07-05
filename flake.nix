{
  description = "Etherno IaC Project";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://colmena.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
    ];
  };
  inputs = {
    # Nix stuff
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # flake-parts
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    pre-commit-hooks-nix = {
      url = "github:hercules-ci/pre-commit-hooks.nix/flakeModule";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Utils
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    statix = {
      url = "github:nerdypepper/statix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Deploy
    colmena.url = "github:zhaofengli/colmena";

    # Secrets
    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Packages
    ethereum-nix.url = "github:nix-community/ethereum.nix";
  };

  outputs = inputs @ {
    nixpkgs,
    flake-parts,
    ...
  }: let
    lib = nixpkgs.lib.extend (final: _: import ./nix/lib final);
  in
    flake-parts.lib.mkFlake {
      inherit inputs;
      # make custom lib available to parent functions
      specialArgs = {inherit lib;};
    }
    {
      imports = [
        # make custom lib available to all `perSystem` functions
        {_module.args.lib = lib;}
        ./nix
        ./nixos
      ];
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
    };
}
