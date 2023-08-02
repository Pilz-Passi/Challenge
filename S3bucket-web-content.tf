# # S3 bucket for Wordpress-content

# resource "aws_s3_bucket" "wordpress-content-bucket-for-homepage645" {
#   bucket        = "wordpress-content"
#   tags = {
#     Name        = "wordpress-content-bucket-for-homepage645"
#   }
# }

# # Ownership (for writing permissions)

# resource "aws_s3_bucket_ownership_controls" "wordpress-content-bucket-for-homepage645-ownership" {
#   bucket = aws_s3_bucket.wordpress-content-bucket-for-homepage645.id

#   rule {
#     object_ownership = "BucketOwnerPreferred"
#   }
# }

# # allowing Access

# resource "aws_s3_bucket_acl" "wordpress_bucket-acl" {
#   depends_on = [aws_s3_bucket_ownership_controls.wordpress-content-bucket-for-homepage645-ownership]
#   bucket = aws_s3_bucket.wordpress-content-bucket-for-homepage645.id
#   acl    = "private"
# }
