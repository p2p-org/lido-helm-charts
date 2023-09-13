{{/*
Expand the name of the chart.
*/}}
{{- define "oracle.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "oracle.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "oracle.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "oracle.labels" -}}
helm.sh/chart: {{ include "oracle.chart" . -}}
{{ include "oracle.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ (toString .Chart.AppVersion) | trunc 63 | quote }}
app.kubernetes.io/component: lido-oracle
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "oracle.selectorLabels" -}}
{{- if .Values.labels }}
{{- toYaml .Values.labels | nindent 0 }}
{{- else -}}
app.kubernetes.io/name: {{ include "oracle.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: lidofinance
{{- end }}
{{- end }}
