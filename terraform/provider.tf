provider "aws" {
  region = "ap-south-1"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
