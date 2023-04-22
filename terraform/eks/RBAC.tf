resource "kubectl_manifest" "cluster_developer_role" {
  yaml_body = <<-YAML
    apiVersion: rbac.authorization.k8s.io/v1
    kind: Role
    metadata:
      namespace: dev
      name: developer
    rules:
    - apiGroups: [""]
      resources: ["pods"]
      verbs: ["get", "watch", "list"]
      YAML

  depends_on = [
    module.eks
  ]
}

resource "kubectl_manifest" "cluster_developer_role_binding" {
  yaml_body = <<-YAML
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      name: developer
      namespace: dev
    subjects:
    - kind: User
      name: eks-developer
      apiGroup: rbac.authorization.k8s.io
    roleRef:
      kind: Role
      name: developer
      apiGroup: rbac.authorization.k8s.io
      YAML

  depends_on = [
    module.eks
  ]
}
