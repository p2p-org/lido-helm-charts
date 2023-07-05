{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
    inputs.devshell.flakeModule
    inputs.pre-commit-hooks-nix.flakeModule
    ./env.nix
    ./formatter.nix
    ./pre-commit.nix
    ./shell.nix
    ./tools.nix
  ];
}
