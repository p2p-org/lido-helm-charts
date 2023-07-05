{
  perSystem = {
    devshells.default = {
      name = "etherno";
      env = [
        {
          name = "AWS_CONFIG_FILE";
          eval = "$PRJ_ROOT/.secrets/aws/config";
        }
        {
          name = "AWS_SHARED_CREDENTIALS_FILE";
          eval = "$PRJ_ROOT/.secrets/aws/credentials";
        }
        {
          name = "CLOUDSDK_CONFIG";
          eval = "$PRJ_ROOT/.secrets/gcloud";
        }
        {
          name = "GOOGLE_APPLICATION_CREDENTIALS";
          eval = "$PRJ_ROOT/.secrets/gcloud/application_default_credentials.json";
        }
        {
          name = "USE_GKE_GCLOUD_AUTH_PLUGIN";
          value = "true";
        }
        {
          name = "KUBECONFIG";
          eval = "$PRJ_ROOT/.secrets/kubernetes/config";
        }
      ];
    };
  };
}
