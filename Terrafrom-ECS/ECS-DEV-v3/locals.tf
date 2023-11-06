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

locals {
  ecs_task = {    
  "${var.app1_name}" ={ 
    family_name               = var.app1_name
    volume_name               = "${var.app1_name}_volume"
    ecs_service_name          = "${var.app1_name}_service"
    host_path                 = "${var.host_path}"
    container_definition      = file("${path.module}/app1_def.json") 
  }, 
  "${var.app2_name}" ={ 
    family_name               = var.app2_name
    volume_name               = "${var.app2_name}_volume"
    host_path                 = "/home/ec2-user/html"
    ecs_service_name          = "${var.app2_name}_service"
    container_definition      = file("${path.module}/app2_def.json")
    }  
  }
}

  