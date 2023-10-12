# [Lido]: https://github.com/lidofinance services helm charts repo

Prepared helm charts for easy deploy of NO services. Unification of enviromen variables for EL and CL. Example of preset:

```
  el_node_rpc: "http://localhost:8545/"
  cl_node_rpc: "http://localhost:3500/"
```

## List of services

### [Lido Node Operators Keys Service]: https://github.com/lidofinance/lido-keys-api

Simple Lido keys and validators HTTP API.

### [Lido Validator Ejector]: https://github.com/lidofinance/validator-ejector

Daemon service which loads LidoOracle events for validator exits and sends out exit messages when necessary.
On start, it will load events from a configurable amount of blocks behind and then poll for new events.

### [Lido Oracle]: https://github.com/lidofinance/lido-oracle

Oracle daemon for Lido decentralized staking service: Monitoring the state of the protocol across both layers and submitting regular update reports to the Lido smart contracts.

### [Lido Council Daemon]: https://github.com/lidofinance/lido-council-daemon

The Lido Council Daemon monitors deposit contract keys and compares them to Lido's unused keys. If a match is found, it attempts to pause deposits by sending a transaction to the Deposit Security Module contract. This document provides instructions for setting up and running the daemon, including necessary environment variables, an example configuration, and logging information.
