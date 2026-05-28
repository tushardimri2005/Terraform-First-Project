resource "aws_s3_bucket" "bucket" {
  bucket = "tushar-terraform-demo-947782"

  tags = {
    Name = "TerraformBucket"
  }
}