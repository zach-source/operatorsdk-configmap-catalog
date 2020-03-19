{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "configmap-catalog.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "configmap-catalog.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "configmap-catalog.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "configmap-catalog.labels" -}}
helm.sh/chart: {{ include "configmap-catalog.chart" . }}
{{ include "configmap-catalog.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "configmap-catalog.selectorLabels" -}}
app.kubernetes.io/name: {{ include "configmap-catalog.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "configmap-catalog.serviceAccountName" -}}
{{- if default true .Values.serviceAccount.create -}}
    {{ default (include "configmap-catalog.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/* Reads a file and prints the first line as a list */}}
{{/* params: dir : string, indent: int */}}
{{- define "filelist" -}}
{{- $dir := .dir -}}
{{- $indent := .indent -}}
{{- $files := .files }}
{{- $indent2 := (int (add $indent 2)) }}
{{- range $path, $_ := $files.Glob $dir -}}
  {{- $lines := $files.Lines $path -}}
  {{- $firstLine := first $lines -}}
  {{- $rest := rest $lines }}
{{ cat "-" $firstLine | indent $indent -}}
  {{- range $rest }}
{{ . | indent $indent2 -}}{{- end -}}
{{- end -}}
{{- end -}}
