#-----------------------------------------------------------------------------
{{/* Generate basic labels */}}
{{- define "mychart.labels"}}
  labels:
    generator: helm
    date: {{ now | htmlDate }}
    chart: {{ .Chart.Name }}
    version: {{ .Chart.Version }}
{{- end }}



{{- define "mychart.app" -}}
app_name: {{ .Chart.Name }}
app_version: "{{ .Chart.Version }}"
{{- end -}}

#-----------------------------------------------------------------------------
{{/* Generate full name for resources */}}

{{- define "myapp.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

#-----------------------------------------------------------------------------
{{/* Generate common labels */}}

{{- define "myapp.labels" -}}
app.kubernetes.io/name: {{ include "myapp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "myapp.chart" . }}
{{- end }}

#-----------------------------------------------------------------------------
{{/* Generate selector labels */}}

{{- define "myapp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "myapp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

#-----------------------------------------------------------------------------
{{/* Generate name */}}

{{- define "myapp.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

#-----------------------------------------------------------------------------
{{/* Generate chart name and version */}}

{{- define "myapp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

#-----------------------------------------------------------------------------
