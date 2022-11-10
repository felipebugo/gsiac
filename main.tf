
#Conf tf

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0" /* Opcional, porém recomendado para ambiente de produção */
    }
  }
  backend "s3" {
    bucket = "bucket-auditoria-terraform"
    key    = "auditoria"
    region = "us-east-1"
  }
}

#Region AWS
provider "aws" {
  region = var.region_aws
}


/*-------------------------------------------
                 VPC Modules                
-------------------------------------------*/

module "VPC" {
  source  = "./Modules/VPC"
}

module "RDS" {
  source  = "./Modules/RDS"
  sn_vpc_dev_pub_1a_id = "${module.VPC.sn_vpc_dev_pub_1a_id}"
  sn_vpc_dev_pub_1b_id = "${module.VPC.sn_vpc_dev_pub_1b_id}"
  vpc_dev_security_group_priv_id = "${module.VPC.vpc_dev_security_group_priv_id}"

}

module "ASG_ELB" {
  source  = "./Modules/ASG_ELB"
  vpc_id = "${module.VPC.vpc_dev_id}"
  rds_endpoint = "${module.RDS.rds_endpoint}"
  rds_name = "${var.rds_name}"
  rds_user = "${var.rds_user}"
  rds_password = "${var.rds_password}"
  sn_vpc_dev_pub_1a_id = "${module.VPC.sn_vpc_dev_pub_1a_id}"
  sn_vpc_dev_pub_1b_id = "${module.VPC.sn_vpc_dev_pub_1b_id}"
  vpc_dev_security_group_pub_id = "${module.VPC.vpc_dev_security_group_pub_id}"
}
