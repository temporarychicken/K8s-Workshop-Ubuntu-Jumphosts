variable "region" {
  default = "eu-west-1"
}

provider "aws" {
  profile    = "664341837355_Users"
  region     = var.region
}

