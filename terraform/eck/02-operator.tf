data "kubectl_file_documents" "crds" {
  content = file("./resources/crds.yaml")
}

resource "kubectl_manifest" "crds" {
  for_each  = data.kubectl_file_documents.crds.manifests
  yaml_body = each.value

  depends_on = [
    data.kubectl_file_documents.crds
  ]
}

data "kubectl_file_documents" "operator" {
  content = file("./resources/operator.yaml")
}

resource "kubectl_manifest" "operator" {
  for_each  = data.kubectl_file_documents.operator.manifests
  yaml_body = each.value

  depends_on = [
    data.kubectl_file_documents.operator,
    kubectl_manifest.crds
  ]
}