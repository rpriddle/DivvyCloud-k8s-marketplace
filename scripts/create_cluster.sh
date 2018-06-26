CLUSTER=marketplace-test-cluster
ZONE=us-east1-c

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
