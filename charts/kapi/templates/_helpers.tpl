{{/*
Expand the name of the chart.
*/}}
{{- define "kapi.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kapi.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kapi.labels" -}}
{{ include "kapi.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kapi.selectorLabels" -}}
{{- if .Values.labels }}
{{- toYaml .Values.labels | nindent 0 }}
{{- else -}}
app.kubernetes.io/name: {{ include "kapi.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: lidofinance
{{- end }}
{{- end }}
