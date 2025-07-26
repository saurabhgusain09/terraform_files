output "website_url" {
  value="aws_s3_bucket.static_website.bucket_regional_domain_name"
  description = "value of the static website URL"
  
}