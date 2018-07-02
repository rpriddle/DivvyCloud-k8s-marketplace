
# Overview

DivvyCloud enforces security, compliance, and governance policy in your cloud and container based infrastructure.

Below you will find steps on how to deploy DivvyCloud to a Kubernetes cluster. 

# Installation

## Quick install with Google Cloud Marketplace

Get up and running with a few clicks! Install this DivvyCloud app to a Google
Kubernetes Engine cluster using Google Cloud Marketplace. Follow the on-screen
instructions:
*TODO: link to solution details page*

## Command line instructions

Follow these instructions to install DivvyCloud from the command line.

### Prerequisites

- Setup cluster
  - Permissions
- Setup kubectl
- Setup helm
- Install Application Resource

*TODO: add details above*

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


# Backups

*TODO: instructions for backups*

# Upgrades

*TODO: instructions for upgrades*
