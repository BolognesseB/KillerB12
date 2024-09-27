module "eks_project_x" {
  source            = "./eks-module/"
  cluster_name      = "project-x-eks-dev"
  subnet_ids        = ["subnet-0687edb6e31fc16da", "subnet-0d732b6100932331c"]
  ec2_types         = ["t3.medium", "t3.micro"]
  nodegroup_desired = 2
  nodegroup_max     = 4
  nodegroup_min     = 1
}