{{- define "app-of-apps.application" -}}
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: {{ .name }}
  namespace: argocd
spec:
  project: default
  source:
    repoURL: {{ .repoURL }}
    chart: {{ .chart }}
    targetRevision: {{ .version }}
    helm:
{{- if .values }}
      valuesObject:
{{ .values | toYaml | nindent 8 }}
{{- else }}
      valuesObject: {}
{{- end }}
  destination:
    server: https://kubernetes.default.svc
    namespace: {{ .namespace }}
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
{{- end }}
