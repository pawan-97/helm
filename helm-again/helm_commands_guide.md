# Helm and Kubernetes Commands Guide

This document provides a summary of the commands and notes extracted from `notes.txt`.

## Helm Commands

| Command | Description |
| :--- | :--- |
| `helm list` | Lists all Helm releases in the current namespace. |
| `helm list --all-namespaces` | Lists Helm releases across all Kubernetes namespaces. |
| `helm repo add <name> <url>` | Adds a new chart repository with a given name and URL. |
| `helm repo list` | Displays a list of all repositories currently added to Helm. |
| `helm search repo <term>` | Searches for charts in the added repositories matching the search term. |
| `helm search repo <chart> --versions` | Lists all available versions of a specific chart in the repository. |
| `helm install <name> <chart>` | Installs a chart with the specified release name. |
| `helm install <name> <chart> --namespace <ns>` | Installs a chart into a specific Kubernetes namespace. |
| `helm install <name> <chart> --create-namespace` | Automatically creates the namespace if it does not exist during installation. |
| `helm install <name> <chart> --values <file>` | Installs a chart using custom values provided in a YAML file. |
| `helm install <name> <chart> --set <key>=<value>` | Overrides specific chart values using the `--set` flag during installation. |
| `helm install <name> <chart> --dry-run` | Simulates an installation to see the rendered templates without applying them. |
| `helm install <chart> --generate-name` | Installs a chart and automatically generates a unique name for the release. |
| `helm install <chart> --generate-name --name-template <tmpl>` | Uses a specific template to format the automatically generated release name. |
| `helm upgrade <name> <chart>` | Upgrades an existing release to a new version or with new configuration. |
| `helm upgrade <name> <chart> --version <v>` | Upgrades a release to a specific version of the chart. |
| `helm upgrade <name> <chart> --reuse-values` | Upgrades a release while maintaining the values from the previous revision. |
| `helm upgrade --install <name> <chart>` | Upgrades the release if it exists; otherwise, it performs a fresh installation. |
| `helm upgrade <name> <chart> --force` | Forces resource updates during an upgrade, which may involve deleting and recreating resources. |
| `helm upgrade <name> <chart> --clean-on-fail` | Automatically deletes newly created resources if the upgrade operation fails. |
| `helm uninstall <name>` | Uninstalls the specified Helm release from the cluster. |
| `helm uninstall <name> --keep-history` | Uninstalls the release but preserves its history for future reference or rollbacks. |
| `helm template <name> <chart>` | Renders the chart templates locally and displays the resulting YAML. |
| `helm template <name> <chart> --validate` | Renders templates and validates them against the Kubernetes cluster. |
| `helm get notes <name>` | Retrieves the usage notes provided by the chart for a specific release. |
| `helm get values <name>` | Shows the values that were used for a specific Helm release. |
| `helm get values <name> --revision <n>` | Retrieves the values associated with a specific revision of the release. |
| `helm get values <name> --all` | Displays all values (both user-supplied and chart defaults) for the release. |
| `helm get manifest <name>` | Displays the Kubernetes manifest files generated for a release. |
| `helm history <name>` | Lists the revision history of a specific Helm release. |
| `helm rollback <name> <revision>` | Rolls back a release to a previously deployed revision number. |
| `helm install ... --wait` | Waits until all resources are in a ready state before marking the release as successful. |
| `helm install ... --wait --timeout <time>` | Specifies the maximum duration to wait for resources to become ready (e.g., `5m`). |
| `helm install ... --atomic` | Automatically rolls back the installation if it fails to reach a ready state. |

## Kubernetes Commands

| Command | Description |
| :--- | :--- |
| `kubectl create ns <name>` | Creates a new namespace in the Kubernetes cluster. |

## Important Notes

- **Reuse Values**: Do not attempt to mix the `--reuse-values` flag with additional `--set` or `--values` options, as it can lead to configuration conflicts.
- **Release Statuses**: Helm tracks releases through several statuses:
    - `pending-install`: The release is being installed.
    - `deployed`: The release has been successfully deployed.
    - `pending-upgrade`: An upgrade is currently in progress.
    - `superseded`: A previous version has been replaced by a newer one.
    - `pending-rollback`: A rollback is currently in progress.
    - `uninstalling`: The release is being removed.
    - `uninstalled`: The release has been removed (visible if history is kept).
    - `failed`: The release operation did not complete successfully.
