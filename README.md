
# Overview

DivvyCloud enforces security, compliance, and governance policy in your cloud and container based infrastructure.

Below you will find steps on how to deploy DivvyCloud to a Kubernetes cluster. 

# Installation

## Quick install with Google Cloud Marketplace

Get up and running with a few clicks! Install this DivvyCloud app to a Google
Kubernetes Engine cluster using Google Cloud Marketplace. Follow the on-screen
instructions:

## Acquiring and installing License 

	DivvyCloud automatically generates and installs a 14-day trial license.

## Tool dependencies

- [gcloud](https://cloud.google.com/sdk/)
- [docker](https://docs.docker.com/install/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/). You can install
  this tool as part of `gcloud`.
- [make](https://www.gnu.org/software/make/)

## Authorization

This guide assumes you are using a local development environment. If you need
run these instructions from a GCE VM or use a service account identity
(e.g. for testing), see: [Advanced Authorization](#advanced-authorization)

Log in as yourself by running:

```shell
gcloud auth login
```

## Provisioning a GKE cluster and configuring kubectl to connect to it.

```
CLUSTER=cluster-1
ZONE=us-west1-a

# Create the cluster.
gcloud beta container clusters create "$CLUSTER" \
    --zone "$ZONE" \
    --machine-type "n1-standard-1" \
    --num-nodes "3"

# Configure kubectl authorization.
gcloud container clusters get-credentials "$CLUSTER" --zone "$ZONE"

# Bootstrap RBAC cluster-admin for your user.
# More info: https://cloud.google.com/kubernetes-engine/docs/how-to/role-based-access-control
kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole cluster-admin --user $(gcloud config get-value account)

# (Optional) Start up kubectl proxy.
kubectl proxy
```



### Building and installing 
	Clone down this repository and use the following make commands:

	* make crd/install to install the application CRD on the cluster. This needs to be done only once.
	* make app/install to build all the container images and deploy the app to a target namespace on the cluster.
	* make app/uninstall to delete the deployed app.

### Commands

Set environment variables (modify if necessary):
```
export APP_INSTANCE_NAME=divvycloud
export NAMESPACE=divvycloud
```

Expand manifest template:
```
helm template . --set APP_INSTANCE_NAME=$APP_INSTANCE_NAME,NAMESPACE=$NAMESPACE > expanded.yaml
```

Run kubectl:
```
kubectl apply -f expanded.yaml
```


# Backup / Restore

	MySQL dump and the MySQL client are used to backlup and restore a DivvyCloud database
	First you need to get the IP address of the mysql service in your k8s deployment 

	'''
      MYSQL_IP=$(kubectl get \
        --namespace {{ .Release.Namespace }} \
        svc divvycloud-mysql\
        -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

	'''


# Upgrades

*TODO: instructions for upgrades*
