resource "aws_eks_node_group" "worker-nodes" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.cluster_name}-nodegroup1"
  node_role_arn   = aws_iam_role.workers-iam-role.arn
  subnet_ids      = var.subnet_ids
  instance_types  = var.ec2_types
  scaling_config {
    desired_size = var.nodegroup_desired
    max_size     = var.nodegroup_max
    min_size     = var.nodegroup_min
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.workers-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.workers-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.workers-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_iam_role" "workers-iam-role" {
  name = "${var.cluster_name}-nodegroup-iam-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "workers-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.workers-iam-role.name
}

resource "aws_iam_role_policy_attachment" "workers-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.workers-iam-role.name
}

resource "aws_iam_role_policy_attachment" "workers-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.workers-iam-role.name
}