{
  perSystem = {
    pkgs,
    config,
    ...
  }: {
    devshells.default = {
      name = "lido";
      packages = with pkgs; [kubernetes-helm];
      devshell.startup = {
        pre-commit.text = config.pre-commit.installationScript;
      };
    };
  };
}
