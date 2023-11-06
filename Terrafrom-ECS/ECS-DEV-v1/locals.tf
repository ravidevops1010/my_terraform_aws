locals {
  cloud_config_config = <<-END
    #cloud-config
    ${jsonencode({
  write_files = [
    {
      path        = "/home/ec2-user/html/index.html"
      permissions = "0777"
      owner       = "ec2-user:ec2-user"
      encoding    = "b64"
      content     = filebase64("${path.module}/index.html")
    },
  ]
})}
  END
}