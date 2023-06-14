{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper flink image name
*/}}
{{- define "flink.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Create the name of the jobmanager deployment
*/}}
{{- define "flink.jobmanager.fullname" -}}
    {{ printf "%s-jobmanager" (include "common.names.fullname" .)  | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Create the name of the taskmanager deployment
*/}}
{{- define "flink.taskmanager.fullname" -}}
    {{ printf "%s-taskmanager" (include "common.names.fullname" .)  | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Create the name of the service account to use for the taskmanager
*/}}
{{- define "flink.taskmanager.serviceAccountName" -}}
{{- if .Values.taskmanager.serviceAccount.create -}}
    {{ default (include "flink.taskmanager.fullname" .) .Values.taskmanager.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.taskmanager.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the jobmanager
*/}}
{{- define "flink.jobmanager.serviceAccountName" -}}
{{- if .Values.jobmanager.serviceAccount.create -}}
    {{ default (include "flink.jobmanager.fullname" .) .Values.jobmanager.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.jobmanager.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the headless service
*/}}
{{- define "flink.headlessServiceName" -}}
{{-  printf "%s-headless" (include "common.names.fullname" .) -}}
{{- end -}}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "flink.zookeeper.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "zookeeper" "chartValues" .Values.zookeeper "context" $) -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "flink.minio.uri" -}}
{{- printf "s3://%s:%d/%s" (include "common.names.dependency.fullname"  (dict "chartName" "minio" "chartValues" .Values.minio "context" $)) (.Values.minio.service.ports.api | int) .Values.minio.defaultBuckets -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "flink.zookeeper.fullAddress" -}}
    {{ printf "%s:%d" (include "flink.zookeeper.fullname" .) (.Values.zookeeper.service.ports.client | int) }}
{{- end -}}

{{/*
Return the proper install_plugins initContainer image name
*/}}
{{- define "flink.libsJob.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.libs.image "global" .Values.global) }}
{{- end -}}
