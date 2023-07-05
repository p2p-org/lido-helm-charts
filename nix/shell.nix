{
  perSystem = {
    pkgs,
    inputs',
    config,
    ...
  }: let
    inherit (inputs'.ethereum-nix.packages) ethdo;
    inherit (inputs'.colmena.packages) colmena;
    google-env = pkgs.google-cloud-sdk.withExtraComponents [pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin];
  in {
    devshells.default = {
      name = "etherno";
      packages = with pkgs; [
        terraform
        terragrunt
        awscli2
        kubectl
        kubernetes-helm
        krew
        kubectx
        k9s
        yaml-language-server
        shellcheck
        statix
        ethdo
        colmena
        google-env
      ];
      devshell.startup = {
        pre-commit.text = config.pre-commit.installationScript;
      };
    };
  };
}
