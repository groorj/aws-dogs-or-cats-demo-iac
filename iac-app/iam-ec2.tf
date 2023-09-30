# Create IAM Assume Role
resource "aws_iam_role" "iam_assume_role" {
  name = "dogs-or-cats-iam-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      Application = "dogs-or-cats.com"
  }
}

# Create an instance profile
resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance-profile-role"
  role = aws_iam_role.iam_assume_role.name
}

# Create IAM Policy to allow S3 access
resource "aws_iam_role_policy" "instance_profile_policy" {
  name = "instance-profile-policy"
  role = aws_iam_role.iam_assume_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:*"
            ],
            "Effect": "Allow",
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

# End;