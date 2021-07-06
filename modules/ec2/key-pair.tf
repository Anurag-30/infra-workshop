resource "null_resource" "public_key" {

  provisioner "local-exec" {
    command                 = "yes y | ssh-keygen -q -t rsa -f petclinic-keypair -N '' -C centos@$(hostname)"
  }
}

data "local_file" "public_content" {
  filename   = "petclinic-keypair.pub"
  depends_on = [null_resource.public_key]
}

resource "aws_key_pair" "ec2-keypair" {
  depends_on = [null_resource.public_key]
  key_name   = "petclinic-keypair"
  public_key = data.local_file.public_content.content
}


output "public_key_content" {
  value = data.local_file.public_content.content
}

