resource "kubectl_manifest" "kibana" {
  yaml_body = <<YAML
      apiVersion: kibana.k8s.elastic.co/v1
      kind: Kibana
      metadata:
        name: quickstart
      spec:
        version: 8.7.0
        count: 1
        elasticsearchRef:
          name: quickstart
  YAML

  depends_on = [
    kubectl_manifest.elasticsearch
  ]
}

resource "kubectl_manifest" "kibana_lb" {
  yaml_body = <<YAML
      apiVersion: v1
      kind: Service
      metadata:
        name: kibana-lb
        namespace: default
      spec:
        type: NodePort
        ports:
          - port: 5601
            targetPort: 5601
            nodePort: 30301
            name: http
        selector:
          common.k8s.elastic.co/type: kibana
          kibana.k8s.elastic.co/name: quickstart
  YAML

  depends_on = [
    kubectl_manifest.kibana
  ]
}

