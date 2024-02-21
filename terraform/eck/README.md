# Elastic Cloud on Kubernetes

Elastic Cloud is the best way to consume all of Elastic's products across any cloud. Easily deploy in your favorite public cloud, or in multiple clouds, and extend the value of Elastic with cloud-native features. Accelerate results that matter, securely and at scale.

Documentation: https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-quickstart.html


### ECK terraform module

As part of this terraform module, ECK's Custom resource definitions and operator in installed on the kubernetes cluster.
Elasticsearch and Kibana services are also created.

Once the module is applied successfully, visit the respective service urls to access their dashboards.

### Credentials

Both Elasticsearch and Kibana use same credentials.
Username: ***elastic***

Use the below command to generate the password.
> PASSWORD=$(kubectl get secret quickstart-es-elastic-user -o go-template='{{.data.elastic | base64decode}}')

### References:

[Elasticsearch ](https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-elasticsearch.html)

[Kibana](https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-kibana.html)


### How to access deployed services:

[Elasticsearch] > refer elasticsearch-dns.txt 

[Kibana]        > refer kibana-dns.txt

The above txt file contains the links to access the services respectively.

Note: These txt files are generated after the successful deployment.


