{
  description = "Devops ETH2 Project";

  inputs = {nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";};

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    google-env = pkgs.google-cloud-sdk.withExtraComponents [pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin];
    python-env =
      pkgs.python3.withPackages
      (p: with p; [yamlfix plumbum black python-lsp-server jmespath pyopenssl google-cloud-storage]);
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        awscli2
        ansible
        ansible-lint
        bash
        google-env
        k9s
        kubectl
        kubectx
        kubernetes-helm
        kubie
        nixfmt
        packer
        python-env
        shellcheck
        terraform
        terragrunt
        yaml-language-server
        yamllint
      ];
      shellHook = ''
        export DEVOPS_ETH2=`pwd`
        export USE_GKE_GCLOUD_AUTH_PLUGIN=True
        export KUBECONFIG=`pwd`/infra/.secrets/kubernetes/config
        export CLOUDSDK_CONFIG=`pwd`/infra/.secrets/gcloud
        export GOOGLE_APPLICATION_CREDENTIALS=`pwd`/infra/.secrets/gcloud/application_default_credentials.json
        export AWS_CONFIG_FILE=`pwd`/infra/.secrets/aws/config
        export AWS_SHARED_CREDENTIALS_FILE=`pwd`/infra/.secrets/aws/credentials
      '';
    };
  };
}
