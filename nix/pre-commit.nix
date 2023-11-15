{inputs, ...}: {
  imports = [
    inputs.pre-commit-hooks-nix.flakeModule
  ];

  perSystem = {
    pre-commit.settings = {
      excludes = ["flake.lock"];
      hooks = {
        alejandra.enable = true;
        statix.enable = true;
        deadnix.enable = true;
        prettier.enable = true;
      };
    };
  };
}
