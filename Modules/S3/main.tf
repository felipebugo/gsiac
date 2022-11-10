
resource "aws_s3_bucket" "s3_dev" {
  bucket = "bugobucket"

  tags = {
    Name = "bugobucket"
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.s3_dev.id
  acl    = "${var.s3_acl}"
}

#VERSIONING S3 BUCKET

resource "aws_s3_bucket_versioning" "s3_dev_versioning" {
  bucket = aws_s3_bucket.s3_dev.id
  versioning_configuration {
    status = "Enabled"
  }
}
