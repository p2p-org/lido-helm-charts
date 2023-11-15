{inputs, ...}: {
  imports = [
    inputs.devshell.flakeModule
    inputs.pre-commit-hooks-nix.flakeModule
    ./formatter.nix
    ./pre-commit.nix
    ./shell.nix
  ];
}
