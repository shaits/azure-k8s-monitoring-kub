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
      valuesObject: {{ .values | toYaml | nindent 6 }}
  destination:
    server: https://kubernetes.default.svc
    namespace: {{ .namespace }}
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
{{- end }}
