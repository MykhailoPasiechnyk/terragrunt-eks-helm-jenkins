include {
	path = find_in_parent_folders()
}

terraform {
	source = "../../../modules/Jenkins//."
}

dependency "eks" {
	config_path = "../02-eks"
}

dependency "k8s" {
	config_path = "../03-k8s_resoursces"
}

inputs = {
	namespace_name = dependency.k8s.outputs.namespace
	path_to_values = "jenkins-values.yaml"
	cluster_name   = dependency.eks.outputs.cluster_name
}

dependencies {
	paths = ["../02-eks", "../03-k8s_resoursces"]
}
