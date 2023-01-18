data "aws_eks_cluster" "cluster" {
  name       = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name       = var.cluster_name
}


provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}


resource "kubernetes_namespace" "jenkins-ns" {
  metadata {
    annotations = {
      name = "Jenkins namespace"
    }

    labels = {
      name = var.namespace_name
    }

    name = var.namespace_name
  }
}


resource "kubernetes_persistent_volume_claim_v1" "jenkins-claim" {
  metadata {
    name      = "jenkins-claim"
    namespace = var.namespace_name
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "3Gi"
      }
    }
    volume_name = kubernetes_persistent_volume_v1.jenkins-pv.metadata.0.name
  }
}


resource "kubernetes_persistent_volume_v1" "jenkins-pv" {
  metadata {
    name = "jenkins"
  }

  spec {
    capacity = {
      storage = "20Gi"
    }

    storage_class_name = "gp2"
    access_modes       = ["ReadWriteOnce"]

    persistent_volume_source {
      host_path {
        path = "/data/jenkins-volume/"
      }
    }
  }
}
