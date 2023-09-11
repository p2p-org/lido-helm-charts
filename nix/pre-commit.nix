{inputs, ...}: {
  imports = [
    inputs.pre-commit-hooks-nix.flakeModule
  ];

  perSystem = {
    pre-commit.settings = {
      hooks = {
        alejandra.enable = true;
        statix.enable = true;
        terraform-format.enable = true;
        deadnix.enable = true;
        prettier.enable = true;
      };
    };
  };
}
