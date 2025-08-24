# dev infrastructure
module "dev-infra" {
  source = "./infra-app"
    env = "dev"
    bucket_name = "infra-app-bucket-alkamah-dev"
    instance_count = 1
    instance_type = "t3.micro"
    ec2_ami_id = "ami-0de716d6197524dd9" #Amazon Linux
    hash_key = "studentID"
}

#prd infrastructure
module "prd-infra" {
  source = "./infra-app"
    env = "prd"
    bucket_name = "infra-app-bucket-alkamah-prd"
    instance_count = 2
    instance_type = "t3.medium"
    ec2_ami_id = "ami-0de716d6197524dd9" #Amazon Linux
    hash_key = "studentID"
}

#stg infrastructure
module "stg-infra" {
  source = "./infra-app"
    env = "stg"
    bucket_name = "infra-app-bucket-alkamah-stg"
    instance_count = 1
    instance_type = "t3.small"
    ec2_ami_id = "ami-0de716d6197524dd9" #Amazon Linux
    hash_key = "studentID"
}