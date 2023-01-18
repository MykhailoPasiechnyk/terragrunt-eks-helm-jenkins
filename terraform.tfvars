# ------------------------------------------------------------
# Networking Settings
# ------------------------------------------------------------
aws_region          = "eu-central-1"
vpc_cidr_block      = "10.0.0.0/16"
public_subnet1_az   = "eu-central-1a"
public_subnet1_cidr = "10.0.1.0/24"
public_subnet2_az   = "eu-central-1b"
public_subnet2_cidr = "10.0.2.0/24"
# ------------------------------------------------------------
# EKS Cluster Settings
# ------------------------------------------------------------
cluster_name                       = "cluster"
cluster_version                    = "1.23"
worker_group_instance_type         = ["t3.medium"]
autoscaling_group_min_size         = 1
autoscaling_group_max_size         = 1
autoscaling_group_desired_capacity = 1
# ------------------------------------------------------------
# Jenkins Settings
# ------------------------------------------------------------
jenkins_admin_user     = ""
jenkins_admin_password = ""
