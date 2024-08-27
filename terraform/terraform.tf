terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "0.2"
    }
    random = {
        source = "hashicorp/random"
        version = ""
    }

    tls = {
        source = "hashicorp/tls"
        version = ""
    }

    cloudinit = {
        source = "hashicorp/cloudinit"
        version = ""
    }

    kubernetes = {
        source = "hashicorp/kubernetes"
        version = ""
    }
  }

  required_version = ""
   
}