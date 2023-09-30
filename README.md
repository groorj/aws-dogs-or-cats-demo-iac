# The dogs-or-cats.com Demo App - AWS IaC Deployment

This repo contains the IaC Terraform code to create the AWS infrastructure for the dogs-or-cats.com app demo.

The dogs-or-apps.com demo application is not in this repo.

## Table of contents

- [Terraform Documentation](#terraform-documentation)
- [Usage: Structure](#structure)
- [Usage: Run](#run)
- [Tips and Tricks](#tips-and-tricks)
- [Contributing](#contributing)

## Usage

### Structure

```bash
.
└── aws
```

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

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

