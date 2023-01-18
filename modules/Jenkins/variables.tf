variable "release_name" {
  type        = string
  description = "The name of release"
  default     = "jenkins"
}

variable "repository_url" {
  type        = string
  description = "Helm chart repository"
  default     = "https://charts.jenkins.io"
}

variable "chart_name" {
  type        = string
  description = "Chart name"
  default     = "jenkins"
}

variable "namespace_name" {
  type        = string
  description = "Cluster namespace for chart"
  default     = ""
}

variable "path_to_values" {
  type        = string
  description = "Path to values file"
  default     = ""
}

variable "jenkins_admin_user" {
  type        = string
  description = "Admin user of the Jenkins"
  default     = ""
}

variable "jenkins_admin_password" {
  type        = string
  description = "Admin password of the Jenkins"
  default     = ""
}

variable "cluster_name" {}
