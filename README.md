# The dogs-or-cats.com Demo App - AWS IaC Deployment

## Table of contents

- [Terraform Documentation](#terraform-documentation)
- [Usage: Structure](#structure)
- [Usage: Run](#run)
- [Tips and Tricks](#tips-and-tricks)
- [Contributing](#contributing)

## What does it do

This repo contains the IaC Terraform code to create the AWS infrastructure for an demo application called the dogs-or-cats.

The application runs on (dogs-or-cats.com)[http://dogs-or-cats.com/] demo and it's code is not in this repo. This repo contains the code for the creation of the infrastrucution that will support the application.

The intent of this repo is to showcase how one can use AWS services to host an application.

## This project uses / Dependencies

- [AWS CodePipeline](https://aws.amazon.com/codepipeline/)
- [AWS Build](https://aws.amazon.com/codebuild/)
- [AWS CodeDeploy](https://aws.amazon.com/codedeploy/)
- [AWS Identity & Access Management](https://aws.amazon.com/iam/)
- [Amazon Virtual Private Cloud](https://aws.amazon.com/iam/)
- [AWS ELB](https://aws.amazon.com/elasticloadbalancing/)
- [AWS EC2](https://aws.amazon.com/ec2/)


## Usage

### Structure & Resources

```bash
.
├── LICENSE
├── README.md
├── iac-app
└── iac-cicd
```

This repo has two folders.
The `iac-app/` folder contains the Terraform files to create the infrastrucure for the app (EC2, VPC, etc)
The `iac-cicd/` folder contains the Terraform files to create the CloudPipeline that will orchestrate the deployment of the app.

The `iac-app` Terraform code will create a VPC, EC2 instances that will run the demo app and an ELB to load balance the traffice between the instances.
The `iac-cidc` Terraform code will create a CodePipeline that orchestrates the deploymemnt of new versions of the application. It uses CodeBuild to build the application and CodeDeploy to manage the deployment of new versions to the EC2 instances. By default, it uses `CodeDeployDefault.AllAtOnce` and attempts to deploy it to as many instances as possible at once. This configuration can be changed so you experiment and understand how the different deployment startegies work.
More information here: [Working with deployment configurations in CodeDeploy](https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-configurations.html)

### Configuration

Search for strings begining with `<your-`. Those are values that you will need to provide in order to use this code.
One example is the file `iac-app/compute.tf` that contains a value `public_key`. You need to replace `<your-public-key-value>` with your own if you want to be able to ssh into the created EC2 instances.

You can change the region where your resources will be created in the `vars.tf` file.

### Run

```terraform
terraform init
terraform plan
terraform apply
```

## Tips and Tricks

### Format your Terraform code

You can format your Terraform code and make them look nice by running.

Dry run:

```terraform
terraform fmt -check=true -write=false -diff=true
```

Output:

```udiff
network.tf
--- old/network.tf
+++ new/network.tf
@@ -20,40 +20,40 @@

 # Create subnets
 resource "aws_subnet" "public-subnet-1" {
-  vpc_id     = "${aws_vpc.vpc.id}"
-  cidr_block = "10.2.0.0/24"
+  vpc_id                  = "${aws_vpc.vpc.id}"
+  cidr_block              = "10.2.0.0/24"
   map_public_ip_on_launch = true
-  availability_zone = "us-east-2a"
+  availability_zone       = "us-east-2a"

   tags = {
     Name = "Public Subnet 1"
   }
 }
```

The real thing:

```terraform
terraform fmt
```

Output:

```bash
network.tf
provider.tf
```

### Validate your Terraform code

You can validate your Terraform code before running it. This is specially useful when running it inside a Pipeline.

```terraform
terraform validate
```

Output:
```bash
Success! The configuration is valid.
```

## Notes

- Congratulations on successfully setting CodePipeline and related infrastructure to manage the lifecycle of an demo app using AWS services.
- Running this code will create AWS resources in your account that might not be included in the free tier.
- Use this code at your own risk, I am not responsible for anything related to its use.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

