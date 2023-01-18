include {
	path = find_in_parent_folders()
}

terraform {
	source = "../../../modules/K8S//."
}

dependency "eks" {
	config_path = "../02-eks"
}

inputs = {
	cluster_name = dependency.eks.outputs.cluster_name
}

dependencies {
	paths = ["../02-eks"]
}
