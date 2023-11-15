{
  inputs,
  lib,
  self,
  ...
}: {
  imports = [
    inputs.devshell.flakeModule
    inputs.pre-commit-hooks-nix.flakeModule
    ./formatter.nix
    ./pre-commit.nix
    ./shell.nix
  ];
  flake = {
    githubActions = inputs.nix-github-actions.lib.mkGithubMatrix {
      checks = lib.getAttrs ["x86_64-linux"] self.checks;
    };
  };
}
