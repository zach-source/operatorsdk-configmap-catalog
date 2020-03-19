# OperatorSDK Configmag Catalog Helm 3 Chart

This is a helm chart that takes the files in the operators folder and packages
them into a configmap for the OperatorSDK Configmap Operator Source to consume.

This chart will deploy the follow:

- configmap of the operator csvs.
- deployment of the configmap registry dockerfile using port 50051.
- service pointing to the deployment.
- service account for the deployment.
- role for the deployment (to access the configmap).
- rolebinding to bind the to the serviceaccount.
- catalog-source to define the operator catalog source to use grpc and point at
  the service the for deployment.

When you run this chart, it should be deployed into the namespace
`operator-source`

You can use the operator-sdk registry image from quay.io/zach-source or you can
build it yourself [here](https://github.com/operator-framework/operator-registry/blob/master/configmap-registry.Dockerfile)

## Requirements

- helm 3

## Install

To install do the following:

1. Add your ClusterServiceVersion files to operators/csvs
2. Add your CustomResourceDefinition files to operators/crds
3. Add your Package files to operators/packages
4. Run
   ```sh
   helm install my-catalog . --namespace openshift-operator-lifecycle-manager
   ```

## Update

1. Update your crd, csv, or package files.

2. Run
   ```sh
   helm upgrade my-catalog . --namespace openshift-operator-lifecycle-manager
   ```
