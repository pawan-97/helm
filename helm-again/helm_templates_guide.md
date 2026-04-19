# Helm Templates and Built-in Objects Guide

This guide covers commonly used Helm built-in objects, pipeline functions, file operations, and the `lookup` function. Understanding these concepts is crucial for writing dynamic and flexible Helm charts.

---

## 1. Built-in Objects

Helm provides several built-in objects that inject information about the chart, the Kubernetes cluster, or the release itself into your templates.

### The Chart Object (`.Chart`)
The `Chart` object contains the contents of the `Chart.yaml` file.

* **`.Chart.Name`**: Contains the name of the chart.
* **`.Chart.Version`**: The version of the chart.
* **`.Chart.AppVersion`**: The application version, if set.
* **`.Chart.Annotations`**: Contains a key/value list of annotations.

**Example Usage:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Chart.Name }}-deployment
  labels:
    app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
```

### The Capabilities Object (`.Capabilities`)
The `Capabilities` object provides information about the features supported by the Kubernetes cluster.

* **`.Capabilities.APIVersions`**: Contains the API versions and resource types available in your cluster. Useful for checking if a specific Custom Resource Definition (CRD) or API is present.
* **`.Capabilities.KubeVersion.Version`**: The full Kubernetes version.
* **`.Capabilities.KubeVersion.Major`**: Contains the major Kubernetes version (e.g., `1`).
* **`.Capabilities.KubeVersion.Minor`**: The minor version of Kubernetes being used in the cluster.

**Example Usage:**
```yaml
{{- if .Capabilities.APIVersions.Has "batch/v1/CronJob" }}
apiVersion: batch/v1
kind: CronJob
{{- else }}
apiVersion: batch/v1beta1
kind: CronJob
{{- end }}
```

### The Template Object (`.Template`)
Contains information about the current template being executed.

* **`.Template.Name`**: Contains the namespaced filepath to the template (e.g., `mychart/templates/deployment.yaml`).
* **`.Template.BasePath`**: The namespaced path to the templates directory of the current chart (e.g., `mychart/templates`).

---

## 2. Pipelines and Formatting

Helm templating relies on the Go template language, which makes heavy use of pipelines (`|`) to chain functions together.

### Default Values and Quoting
You can use pipelines to provide fallback values and ensure correct YAML typing.

**Example Usage:**
```yaml
character: {{ .Values.character | default "Sylvester" | quote }}
```
*If `character` is not provided in `values.yaml`, it defaults to `"Sylvester"`. The `quote` function ensures the output is safely wrapped in double quotes.*

### `indent` vs `nindent`
Both functions indent a block of text, but they behave slightly differently regarding whitespace.
* **`indent`**: Indents the text by the specified number of spaces.
* **`nindent`**: Prints a newline (`\n`) and then indents the text. This is often preferred when placing a multi-line block directly after a YAML key.

**Example Usage:**
```yaml
spec:
  template:
    metadata:
      labels:
        {{- include "mychart.labels" . | nindent 8 }}
```

---

## 3. File Operations (`.Files`)

The `.Files` object provides tools for reading and interacting with non-template files inside your chart (e.g., configurations, scripts).

* **`.Files.Get <name>`**: Retrieves the contents of the file as a string. `<name>` is the filepath relative to the root of the chart.
* **`.Files.GetBytes`**: Similar to `.Files.Get`, but returns the file as an array of bytes (`[]byte` in Go).
* **`.Files.Glob`**: Accepts a glob pattern and returns a files object containing only the matching files (e.g., `.Files.Glob("configs/*.conf")`).
* **`.Files.AsConfig`**: Takes a files group and returns it as flattened YAML suitable for the `data` section of a `ConfigMap`.
* **`.Files.AsSecrets`**: Similar to `AsConfig`, but Base64 encodes the data, making it suitable for a Kubernetes `Secret`.
* **`.Files.Lines`**: Takes a filename and returns its contents as an array split by newlines.

**Example - Injecting files into a ConfigMap:**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-config
data:
  {{- (.Files.Glob "configs/*").AsConfig | nindent 2 }}
```

**Example - Injecting files into a Secret:**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
type: Opaque
data:
  {{- (.Files.Glob "secrets/*").AsSecrets | nindent 2 }}
```

---

## 4. The `lookup` Function

The `lookup` function allows you to query the Kubernetes API server for existing resources during the template rendering process. 

**Syntax:**
```go
lookup "api-version" "Kind" "namespace" "name"
```
* **API Version**: The API group and version (e.g., `v1`, `apps/v1`).
* **Kind**: The kind of object (e.g., `Deployment`, `ConfigMap`).
* **Namespace**: The namespace to look in.
* **Name**: The name of the specific resource. Leave blank `""` to return a list of all resources of that kind in the namespace.

**Examples:**

*Get annotations from an existing Deployment:*
```yaml
{{ (lookup "apps/v1" "Deployment" "anvil" "runner").metadata.annotations }}
```

*List all ConfigMaps in the `anvil` namespace:*
```yaml
{{ range $cm := (lookup "v1" "ConfigMap" "anvil" "").items }}
  # Do something with $cm
{{ end }}
```

> **Note:** `lookup` only functions when Helm is connected to a Kubernetes cluster (e.g., during `helm install` or `helm upgrade`). It will return empty values during a basic `helm template` dry-run unless specific cluster capabilities are mocked.


{{- if and .Values.characters .Values.products -}}
...
{{- end }}
{{- if or (eq .Values.character "Wile E. Coyote") .Values.products -}}
...
{{- end }}
{{- with .Values.ingress.annotations }}
annotations:
{{- toYaml . | nindent 4 }}
{{- end }}