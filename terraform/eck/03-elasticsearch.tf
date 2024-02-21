resource "kubectl_manifest" "elasticsearch" {
  yaml_body = <<YAML
      apiVersion: elasticsearch.k8s.elastic.co/v1
      kind: Elasticsearch
      metadata:
        name: quickstart
      spec:
        version: 8.7.0
        nodeSets:
        - name: default
          count: 1
          config:
            node.store.allow_mmap: false
  YAML

  depends_on = [
    kubectl_manifest.operator
  ]
}

// Uncomment the the below resource to make elasticsearch external available
# resource "kubectl_manifest" "elasticsearch_lb" {
#   yaml_body = <<YAML
#       apiVersion: v1
#       kind: Service
#       metadata:
#         name: elasticsearch-lb
#         namespace: default
#       spec:
#         type: NodePort
#         ports:
#           - port: 9200
#             targetPort: 9200
#             nodePort: 30300
#             name: http
#         selector:
#           common.k8s.elastic.co/type: elasticsearch
#           elasticsearch.k8s.elastic.co/cluster-name: quickstart
#   YAML

#   depends_on = [
#     kubectl_manifest.elasticsearch
#   ]
# }

