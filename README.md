<p align="center">
    <img width="400px" height=auto src="https://raw.githubusercontent.com/p2p-org/eigenlayer-operator/main/logo.png" />
</p>

<p align="center">
    <a href="https://x.com/P2Pvalidator"><img src="https://badgen.net/badge/twitter/@P2Pvalidator/1DA1F2?icon&label" /></a>
    <a href="https://github.com/p2p-org/lido-helm-charts"><img src="https://badgen.net/github/stars/p2p-org/avs-helm-charts?icon=github" /></a>
    <a href="https://github.com/p2p-org/lido-helm-charts"><img src="https://badgen.net/github/forks/p2p-org/avs-helm-charts?icon=github" /></a>
</p>

# P2P Helm Charts for [Lido](https://github.com/lidofinance) Services

This repository offers a selection of carefully curated P2P Helm charts, which are stored in individual folders. Each chart has its own values.yaml file defining the configuration parameters.

## Getting Started

To use these Helm charts, you first need to add the P2P repository to your local Helm client:

```bash
helm repo add p2p-lido https://p2p-org.github.io/lido-helm-charts/
```

Once the repository is added, you can deploy a specific chart with the following command:

```bash
helm install my-release p2p-lido/<chart-name>
```

**Note:** Make sure to replace `<chart-name>` with the name of the actual chart you intend to install.

## List of services

### [Lido Node Operators Keys Service](https://github.com/lidofinance/lido-keys-api)

Simple Lido keys and validators HTTP API.
Example of values configuration:

```yaml
app:
  chain_id: "17000"
  el_node_rpc: "http://holesky-node-01:8545/"
  cl_node_rpc: "http://holesky-node-01:5052"
  db_password_file: "/mnt/secrets/db-password"
  db_host: "<db host name>"
  db_name: "<db name>"
  db_user: "postgres"
  mikro_orm_disable_foreign_keys: "false"

image:
  repository: lidofinance/lido-keys-api@sha256
  tag: "90cedb5e0ec768eaa572a795fdf60df9739c78e9315a935f981c6408448155ae"
```

### [Lido Validator Ejector](https://github.com/lidofinance/validator-ejector)

Daemon service which loads LidoOracle events for validator exits and sends out exit messages when necessary.
On start, it will load events from a configurable amount of blocks behind and then poll for new events.
Example of values configuration:

```yaml
app:
  el_node_rpc: "http://holesky-node-01:8545/"
  cl_node_rpc: "http://holesky-node-01:5052"

  locator_address: "0x28FAB2059C713A7F9D8c86Db49f9bb0e96Af1ef8"
  operator_id: "9"

  messages_location: "gs://etherno-le-ejector-holesky"
  messages_password_file: "/mnt/secrets/ejector-password"

  oracle_addresses_allowlist: >
    [
      "0x12A1D74F8697b9f4F1eEBb0a9d0FB6a751366399",
      "0xD892c09b556b547c80B7d8c8cB8d75bf541B2284",
      "0xf7aE520e99ed3C41180B5E12681d31Aa7302E4e5",
      "0x31fa51343297FFce0CC1E67a50B2D3428057D1b1" 
    ]

  logger_secrets: >
    [
      "EXECUTION_NODE",
      "CONSENSUS_NODE",
      "MESSAGES_PASSWORD",
      "MESSAGES_PASSWORD_FILE"
    ]

  logger_level: "debug"
  logger_format: "json"
  dry_run: "false"

image:
  repository: lidofinance/validator-ejector@sha256
  tag: "6d80a57895e0a4d577dc78b187d2bbc62742259ccc1efcadff16685bda7a817e"
```

### [Lido Oracle](https://github.com/lidofinance/lido-oracle)

Oracle daemon for Lido decentralized staking service: Monitoring the state of the protocol across both layers and submitting regular update reports to the Lido smart contracts.
Example of values configuration:

```yaml
common_settings: &common_settings
  el_node_rpc: "http://holesky-node-01:8545/"
  cl_node_rpc: "http://holesky-node-01:5052"

  lido_locator_address: "0x28FAB2059C713A7F9D8c86Db49f9bb0e96Af1ef8"

  member_priv_key_file: "/mnt/secrets/holesky-oracle-key"

  daemon: "true"

app:
  accounting:
    <<: *common_settings
    allow_reporting_in_bunker_mode: "false"

  ejector:
    <<: *common_settings

  csm:
    <<: *common_settings
    csm_module_address: "0x4562c3e63c2e586cD1651B958C22F88135aCAd4f"

    gw3_access_key_file: "/mnt/secrets/holesky-oracle-gw3-access-key"
    gw3_secret_key_file: "/mnt/secrets/holesky-oracle-gw3-secret-key"

    http_request_timeout_consensus: "600"

image:
  repository: lidofinance/oracle@sha256
  tag: "41a719e64bde48fdba3877affb72bf03a4ee6f3e0dd3dbcf2b713398b3a72312"

cache:
  enabled: true
  storageClassName: "standard-rwo"
  size: "1Gi"
```

### [Lido Council Daemon](https://github.com/lidofinance/lido-council-daemon)

The Lido Council Daemon monitors deposit contract keys and compares them to Lido's unused keys. If a match is found, it attempts to pause deposits by sending a transaction to the Deposit Security Module contract. This document provides instructions for setting up and running the daemon, including necessary environment variables, an example configuration, and logging information.
Example of values configuration:

```yaml
app:
  el_node_rpc: "http://holesky-node-01:8545/"

  keys_api_host: "http://kapi"
  keys_api_port: "80"

  # rabbitmq
  rabbitmq_login: "p2p"
  rabbitmq_url: "wss://dsm-4fa9e52e0a8c42564f0b-holesky.testnet.fi/ws"
  rabbitmq_passcode_file: "/mnt/secrets/holesky-council-password"
  # wallet
  wallet_private_key_file: "/mnt/secrets/holesky-council-key"
  # DSM
  pubsub_service: "evm-chain"
  evm_chain_data_bus_address: "0x37de961d6bb5865867add416be07189d2dd960e6"
  evm_chain_data_bus_provider_url: "https://gnosis-chiado-rpc.publicnode.com"

image:
  repository: lidofinance/lido-council-daemon@sha256
  tag: "35b6807baf1b509b48e7f0ef2f85542c259ed4e48a0a5d469dcc4b388fea680e"

cache:
  enabled: true
  storageClassName: "standard-rwo"
  size: "2Gi"
```

## Contribute

We welcome contributions to improve our Helm charts. If you discover any bugs, have issues, or ideas for enhancements, feel free to open an issue or submit a pull request. Every feedback, bug report, or feature request is invaluable to us, and we appreciate the community's involvement in making P2P's Helm charts better.

Feel free to explore the repository and experiment with the Helm charts to suit your specific needs. P2P's Helm charts aim to make application deployment on Kubernetes an effortless experience.
