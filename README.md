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

* Generate k8s manifest files using helm template command

```
helm template mysite bitnami/drupal --values values.yaml --set drupalEmail=foo@example.com
```

### helm get command

* helm get notes subcommand prints the release notes

```
helm get notes mysite
```

* helm get command to get values supplied during the last release

```
helm get values mysite
```

* helm get command to get values supplied during the 2nd release

```
helm get values mysite --revision 2
```

* helm get values to see all of the values currently set for that release

```
helm get values mysite --all
```
* Retrieve yaml manifest files

```
helm get manifest mysite
```

### History and Rollbacks

* helm chart history

```
helm history mysite
```

* Rollback mysite chart to release version 2

```
helm rollback mysite 2 
```

* Keep history of a chart after deletion

```
helm uninstall wordpress --keep-history
```

### Installs and Upgrades

* Generate unique name for a helm chart

```
helm install bitnami/wordpress --generate-name
```

* Additional flag that allows you to specify a naming template

```
helm install bitnami/wordpress --generate-name \
--name-template "foo-{{ randAlpha 9 | lower }}"
```

* Create a namespace with helm charts

```
helm install drupal bitnami/drupal --namespace mynamspace --create-namespace
```
