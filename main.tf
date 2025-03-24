provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "random_pet" "bucket_name" {
  separator = "-"
}

resource "aws_s3_bucket" "bucket" {
  bucket = lower(random_pet.bucket_name.id)
}

resource "local_file" "foo" {
  content  = "Sample text..."
  filename = "${path.module}/foo.txt"
}

resource "aws_s3_object" "obj" {
  bucket = aws_s3_bucket.bucket.bucket
  key    = "foo.txt"
  source = "${path.module}/foo.txt"
}