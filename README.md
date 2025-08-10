# HELM

## HELM basic commands

* List helm charts

```
helm list
```

* List of availabe helm repo

```
helm repo list
```
* Search Helm Charts

```
helm search repo mysql
```

* Installing a Helm Chart

```
helm install my-mysql stable/mysql
```

* Uninstalling a Helm Chart

```
helm uninstall my-mysql
```

* Uninstalling a Helm Chart from a specific namespace

```
helm uninstall my-mysql -n mysql-ns
```

* Adding a HELM repo

```
helm repo add <Repo_LInk>
```

* Updating the repo

```
helm repo update
```

* To add individual parameters to an install or upgrade

```
helm install mysite bitnami/drupal --set drupalUsername=admin
```

```
helm install mysite bitnami/drupal --set mariadb.db.name=my-database
```

* To add individual parameters to an install or upgrade

```
helm install mysite bitnami/drupal --set drupalUsername=admin
```

* Upgrading the chart

```
helm upgrade mysite bitnami/drupal
```

* Upgrading the chart with values

```
helm upgrade mysite bitnami/drupal --values values.yaml
```

* Reusing the last set of values

```
helm upgrade mysite bitnami/drupal --reuse-values
```
> Note: Helm maintainers strongly suggest not trying to mix --reuse-values with additional --set or --values options.
* Upgrading the chart to a particular version

```
helm upgrade mysite bitnami/drupal --version 6.2.22
```

* Delete the application, but keep the release records:

```
helm uninstall --keep-history
```

