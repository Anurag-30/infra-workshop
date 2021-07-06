resource "null_resource" "public_key" {

  provisioner "local-exec" {
    command    = <<-EOT
                   yes y | ssh-keygen -q -t rsa -f ec2-keypair -N ''
                  EOT
  }
}

data "local_file" "public_content" {
  filename     = "${path.module}/ec2-keypair.pub"
  depends_on   = [null_resource.public_key]
}

resource "aws_key_pair" "ec2-keypair" {
  depends_on   = [null_resource.public_key]
  key_name     = "ec2-keypair"
  public_key   = data.local_file.public_content.content
}


output "public_key_content" {
  value        =  data.local_file.public_content.content
}

