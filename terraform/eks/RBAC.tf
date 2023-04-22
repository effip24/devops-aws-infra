resource "kubectl_manifest" "cluster_developer_group" {
  yaml_body = <<-YAML
    apiVersion: rbac.authorization.k8s.io/v1
    kind: Group
    metadata:
      name: developer
  YAML

  depends_on = [
    module.eks
  ]
}

resource "kubectl_manifest" "cluster_role_developer" {
  yaml_body = <<-YAML
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
      name: pod-editor
    rules:
      - apiGroups:
        - ""
        resources:
        - pods
        verbs:
        - get
        - watch
        - list
        - create
        - update
        - patch
        - delete
  YAML

  depends_on = [
    module.eks, kubectl_manifest.cluster_developer_group
  ]
}

resource "kubectl_manifest" "role_binding_developer" {
  yaml_body = <<-YAML
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      name: pod-editor-devs
    subjects:
      - kind: Group
        name: developer
    roleRef:
      kind: ClusterRole
      name: pod-editor
      apiGroup: rbac.authorization.k8s.io
  YAML

  depends_on = [
    module.eks, kubectl_manifest.cluster_developer_group
  ]
}
