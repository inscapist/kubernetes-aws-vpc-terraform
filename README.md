# kops-terraform-starter
**HA, Private DNS, Private Topology** Kops Cluster

Customize `terraform/variables.tf`, `terraform/main.tf` and `kops/02_create_cluster` to suit your need.

Project uses 3 AZs, each AZ has a private and public subnet for kops **private subnet** and kops **utility subnet** respectively. More details please see [Subnet Design Document](https://github.com/sagittaros/kops-terraform-starter/blob/master/staging/terraform/design_document.md)

## Usage

The steps to create a kops cluster using this starter project:

1. Setup IAM user and make sure `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` is present
2. Create a S3 bucket as Kops state store, refer my script [here](https://github.com/sagittaros/kops-terraform-starter/blob/master/staging/kops/01_create_bucket.sh)
3. Create a S3 bucket as Terraform Backend, then customize it at `main.tf`
4. Customize `terraform` using `variables.tf`
5. Create a private hosted zone (optional) on Route53
6. Create a public hosted zone on Route53 [Details](https://github.com/kubernetes/kops/blob/master/docs/aws.md)
7. Follow numbered kops/*.sh to create kops cluster and save to `terraform/k8s`
8. Go to `terraform` and run `terraform init; terraform plan; terraform apply;`
9. Make sure you have api.<yourdomain> and bastion.<yourdomain> in your public DNS zone.
10. run kops validate cluster

Check the pods running in kube_system by running `kubectl get pod --namespace kube-system`
```
NAME                                                                      READY     STATUS    RESTARTS   AGE
dns-controller-7954c48879-qxlfv                                           1/1       Running   0          48m
etcd-server-events-ip-10-1-142-70.ap-southeast-1.compute.internal         1/1       Running   4          47m
etcd-server-events-ip-10-1-147-202.ap-southeast-1.compute.internal        1/1       Running   4          48m
etcd-server-events-ip-10-1-164-244.ap-southeast-1.compute.internal        1/1       Running   5          47m
etcd-server-ip-10-1-142-70.ap-southeast-1.compute.internal                1/1       Running   1          48m
etcd-server-ip-10-1-147-202.ap-southeast-1.compute.internal               1/1       Running   0          48m
etcd-server-ip-10-1-164-244.ap-southeast-1.compute.internal               1/1       Running   2          46m
kube-apiserver-ip-10-1-142-70.ap-southeast-1.compute.internal             1/1       Running   2          48m
kube-apiserver-ip-10-1-147-202.ap-southeast-1.compute.internal            1/1       Running   0          47m
kube-apiserver-ip-10-1-164-244.ap-southeast-1.compute.internal            1/1       Running   0          46m
kube-controller-manager-ip-10-1-142-70.ap-southeast-1.compute.internal    1/1       Running   0          47m
kube-controller-manager-ip-10-1-147-202.ap-southeast-1.compute.internal   1/1       Running   0          48m
kube-controller-manager-ip-10-1-164-244.ap-southeast-1.compute.internal   1/1       Running   0          46m
kube-dns-7785f4d7dc-sw8sr                                                 3/3       Running   0          46m
kube-dns-7785f4d7dc-vd8fm                                                 3/3       Running   0          48m
kube-dns-autoscaler-787d59df8f-rb5g2                                      1/1       Running   0          48m
kube-proxy-ip-10-1-136-100.ap-southeast-1.compute.internal                1/1       Running   0          47m
kube-proxy-ip-10-1-142-70.ap-southeast-1.compute.internal                 1/1       Running   0          47m
kube-proxy-ip-10-1-144-200.ap-southeast-1.compute.internal                1/1       Running   0          46m
kube-proxy-ip-10-1-147-202.ap-southeast-1.compute.internal                1/1       Running   0          48m
kube-proxy-ip-10-1-164-244.ap-southeast-1.compute.internal                1/1       Running   0          46m
kube-proxy-ip-10-1-174-66.ap-southeast-1.compute.internal                 1/1       Running   0          47m
kube-scheduler-ip-10-1-142-70.ap-southeast-1.compute.internal             1/1       Running   0          47m
kube-scheduler-ip-10-1-147-202.ap-southeast-1.compute.internal            1/1       Running   0          48m
kube-scheduler-ip-10-1-164-244.ap-southeast-1.compute.internal            1/1       Running   0          47m
weave-net-4h5t7                                                           2/2       Running   0          47m
weave-net-9drwh                                                           2/2       Running   0          48m
weave-net-bnzjt                                                           2/2       Running   2          47m
weave-net-fnmrs                                                           2/2       Running   0          48m
weave-net-l2spt                                                           2/2       Running   0          47m
weave-net-l8tpf                                                           2/2       Running   0          47m
```
WeaveNet is baked in! Now you have a fully functional kops cluster! 

## Versions

Terraform v0.11.7

Kops v1.9.0

Kubernetes v1.9.3


## Credits

This starter project is inspired by an article written by [Kasper Nissen](https://kubecloud.io/setting-up-a-highly-available-kubernetes-cluster-with-private-networking-on-aws-using-kops-65f7a94782ef) 
