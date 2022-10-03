# Ping Pong API

## Endpoints
- /ping - Responds with {'pong'}
- /pong - Responds with {'ping'}
- /professional-ping-pong - Responds with {'pong'} 90% of the time
- /amateur-ping-pong - Responds with {'pong'} 70% of the time
- /chance-ping-pong - Responds with {'ping'} 50% of the time and {'pong'} 50% of the time

## Description
This is a simple API to test that the RapidAPI/Mashape API Proxy is working. When you access /ping, the API will return a JSON that contains "pong"

## Test Endpoints
API is live at https://rapidapi.com/user/RapidAlex/package/ping-pong

## Implementation

To deploy the ping-pong application I have choosen EKS cluster for deployment. To Spun up the Infra I have opted Terraform 

## Tools and Version 
Below tools mus be present on the remote machine responsible for running the code.

* Terraform (version 1.3.1)
* Helm      (version 3.6.0)

## Application 
* Navigate to the folder `terraform/aws/env`

For dev environment. Generate your aws credentials and run the below comand
```
cd terraform/aws/env/dev
export AWS_ACCESS_KEY_ID=********************
export AWS_SECRET_ACCESS_KEY=******************
terraform init 
terraform plan 
terraform apply 
```
For qa environment. Generate your aws credentials and run the below comand
```
cd terraform/aws/env/qa
export AWS_ACCESS_KEY_ID=********************
export AWS_SECRET_ACCESS_KEY=******************
terraform init 
terraform plan 
terraform apply 
```

Once the apply is successfull. Login to the cluster with below command.

```
aws eks --region us-east-2 update-kubeconfig --name cluster_name (cluster_name will be found in terraform output)
``` 