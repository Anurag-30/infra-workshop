This is a repository that has the terraform code and automation that is required to spin up all the resources and deploy the spring petclinic application into AWS.
## This project creates the following aws resources

### network Module
    - VPC
    - Subnets 
    - Routetable
    - Internet-Gateway
    - NAT-Gateway
    - Routes
    - Route Table Association

### loadbalancers Module
    - Application Loadbalancers
    - Target Groups
    - Security Groups for the ALB
  
### ec2 Module
    - Bastion node (ec2)
    - Database (ec2)
    - Autoscaling groups
    - launch templates
    - AWS key pair
    - Security groups for the EC2

![Alt text](./petclinic.jpg "Title")


## How to Run the Project?

# Prerequsites:

AMI:

There is already an ami image available for the frontend in the region `ap-south-1` if you are using any other region please use the packer folder to create the AMI.

Docker Image:

For the backend this project uses a docker image. The `Dockerfile` is available in the docker folder. An Image is already created and pushed to the docker hub.

## Running Terraform

`terraform init` <br>
There is folder named `environments` where you can find the customizable values for the setup. Make sure the Database related variables are configured appropriately.

Since Database values are considered to be sensitive its a good idea not to update them in the file and check-in. Instead you can pass them as environment variables and read them from the machine you are running this code from.

`export export TF_VAR_variable_name = "value"`

`terraform apply -target=module.vpc -var-file=environments/stage/stage.tfvars` <br>

`terraform apply -target=module.lb -var-file=environments/stage/stage.tfvars`  <br>

`terraform apply -target=module.ec2 -var-file=environments/stage/stage.tfvars`  <br>

## Accessing the Application

Once terraform has been applied successfully you can access the application by using the following commands.

`terraform output frontend_alb`

This gives you the dns name of the ALB where you can access the Frontend


`terraform output backend_alb`

This gives you the dns name of the ALB where you can access the Backend


`terraform output bastion_ip`

This gives you the IP to connect to the bastion node, which enables you to connect to other instances in private subnets.

## Destroying the Infra

you can delete all the resources created by executing the following command.

`terraform destroy  -var-file=environments/stage/stage.tfvars`
  