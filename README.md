# kops-terraform-starter
VPC written in terraform, as a preparation step for **HA, Private DNS, Private Topology** Kops Cluster

Customize `terraform/variables.tf` and `kops/02_create_cluster` to suit your need.

Project uses 3 AZs, each AZ has a private and public subnet for kops **private subnet** and kops **utility subnet** respectively. More details please see [Subnet Design Document](https://github.com/sagittaros/kops-terraform-starter/blob/master/staging/terraform/design_document.md)

## Usage

The steps to create a kops cluster using this starter project:

1. Setup IAM user and make sure `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` is present
2. Customize `terraform` using `variables.tf`
3. Create a S3 bucket as Kops state store, refer my script [here](https://github.com/sagittaros/kops-terraform-starter/blob/master/staging/kops/01_create_bucket.sh)
4. Create a S3 bucket as Terraform Backend, then customize it at `main.tf`
5. Run `terraform plan` and then `terraform apply`
6. Create a private hosted zone (optional) on Route53
7. Create a public hosted zone on Route53 [Details](https://github.com/kubernetes/kops/blob/master/docs/aws.md)
8. Follow numbered kops/*.sh to create kops cluster and save to `terraform/k8s`
9. Go to `terraform` and run `terraform init; terraform plan; terraform apply;`
10. Install weave, calico or other CNI plugins, to use Weave, install this addon here `kubectl apply -f https://raw.githubusercontent.com/sagittaros/kops-terraform-starter/master/common/weave-daemonset-k8s-1.10.yaml`

## Credits

This starter project is inspired by an article written by [Kasper Nissen](https://kubecloud.io/setting-up-a-highly-available-kubernetes-cluster-with-private-networking-on-aws-using-kops-65f7a94782ef) 
