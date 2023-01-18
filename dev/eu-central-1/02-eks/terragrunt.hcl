include {
	path = find_in_parent_folders()
}

dependency "network" {
	config_path = "../01-network"
}

terraform {
	source = "tfr:///terraform-aws-modules/eks/aws//.?version=19.5.1"
}

inputs = {
  cluster_name    = "cluster"
  cluster_version = "1.23"
  subnet_ids      = [dependency.network.outputs.public_subnet_1_id, dependency.network.outputs.public_subnet_2_id]
  vpc_id          = dependency.network.outputs.vpc_id


  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    instance_types = ["t3.medium"]

    attach_cluster_primary_security_group = false
    vpc_security_group_ids                = [dependency.network.outputs.sg_allow_web_traffic_id]
  }

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 1
      max_size     = 1
      desired_size = 1

      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"
      labels = {
        Environment = "dev"
      }
    }
  }
}

dependencies {
  paths = ["../01-network"]
}