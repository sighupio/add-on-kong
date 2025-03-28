<h1 align="center">
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/sighupio/distribution/refs/heads/main/docs/assets/white-logo.png">
  <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/sighupio/distribution/refs/heads/main/docs/assets/black-logo.png">
  <img alt="Shows a black logo in light color mode and a white one in dark color mode." src="https://raw.githubusercontent.com/sighupio/distribution/refs/heads/main/docs/assets/white-logo.png">
</picture><br/>
  Kong Add-On Module
</h1>

![Release](https://img.shields.io/badge/Latest%20Release-v2.8.1-blue)
![License](https://img.shields.io/github/license/sighupio/fury-kubernetes-kong?label=License)
![Slack](https://img.shields.io/badge/slack-@kubernetes/fury-yellow.svg?logo=slack&label=Slack)

<!-- <SD-DOCS> -->

**Kong Add-On Module** contains Kong Ingress Controller for Kubernetes and all the possible deployment options as an
add-on for [SIGHUP Distribution (SD)][kfd-repo].

## Compatibility

| Kubernetes Version |   Compatibility    | Notes                                               |
|--------------------|:------------------:|-----------------------------------------------------|
| `1.20.x`           | :white_check_mark: | No known issues                                     |
| `1.21.x`           | :white_check_mark: | No known issues                                     |
| `1.22.x`           | :white_check_mark: | No known issues                                     |
| `1.23.x`           | :white_check_mark: | No known issues                                     |

Check the [compatibility matrix][compatibility-matrix] for additional information about previous releases of the modules.

### Open Source Packages

The following Open Source Packages packages are included in the Fury Kubernetes Kong add-on module:

| Package                                              | KIC Version  | Kong Version | Description                                           |
|------------------------------------------------------|--------------|--------------|-------------------------------------------------------|
| [kong-dbless](katalog/kong/kong-dbless)              | `2.3.1`      | `2.8.1`      | Default Kong Ingress, without DB.                     |
| [kong-db](katalog/kong/kong-db)                      | `2.3.1`      | `2.8.1`      | Kong Ingress that uses a postgres db for persistence  |


### Enterprise Packages

The following Enterprise packages are included in the Fury Kubernetes Kong add-on module:

| Package                                                        | KIC Version  | Kong Version | Description                                                                                                                      |
|----------------------------------------------------------------|--------------|--------------|----------------------------------------------------------------------------------------------------------------------------------|
| [kong-enterprise](katalog/kong/kong-enterprise)                | `2.3.1`      | `2.8.1.0`    | The Kong Ingress Controller for Kubernetes with Kong Enterprise Edition.                                                         |
| [kong-enterprise-hybrid](katalog/kong/kong-enterprise-hybrid)  | `2.3.1`      | `2.8.1.0`    | The Kong Ingress Controller for Kubernetes with Kong Enterprise Edition. Data Planes connected to Control Plane in Hybrid Mode.  |
| [kong-enterprise-k8s](katalog/kong/kong-enterprise-k8s)        | `2.3.1`      | `2.8.1.0`    | The Kong Ingress Controller for Kubernetes with Kong Enterprise Edition for K8s.                                                 |

<!-- Links -->

[kfd-repo]: https://github.com/sighupio/fury-distribution
[kfd-docs]: https://docs.kubernetesfury.com/docs/distribution/
[compatibility-matrix]: https://github.com/sighupio/fury-kubernetes-kong/blob/master/docs/COMPATIBILITY_MATRIX.md

<!-- </SD-DOCS> -->

<!-- <FOOTER> -->

## Contributing

Before contributing, please read first the [Contributing Guidelines](docs/CONTRIBUTING.md).

### Reporting Issues

In case you experience any problem with the module, please [open a new issue](https://github.com/sighupio/fury-kubernetes-kong/issues/new/choose).

## License

This module is open-source and it's released under the following [LICENSE](LICENSE)

<!-- </FOOTER> -->
