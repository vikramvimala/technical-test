`Challenge #1`: A 3-tier environment is a common setup. Use a tool of your choosing/familiarity create these resources on a cloud environment (Azure/AWS/GCP). Please remember we will not be judged on the outcome but more focusing on the approach, style and reproducibility.

### To create a 3-tier environment on AWS, we can use the following steps:
1.	Create an Amazon Virtual Private Cloud (VPC) to provide a secure and isolated network for our resources.
2.	Create an Amazon Elastic Compute Cloud (EC2) instance to serve as the web server in our environment. We can use an Amazon Machine Image (AMI) with a pre-installed web server, such as Apache or Nginx, or we can install oour own web server software on a bare-bones AMI.
3.	Create an Amazon Relational Database Service (RDS) instance to serve as the database in our environment. We can choose from a variety of database engines, such as MySQL, PostgreSQL, or Oracle.
4.	Create an Amazon Elastic Load Balancer (ELB) to distribute incoming traffic to our EC2 instances and improve the availability of our application.

### To create the above mentioned resources on AWS, we can use terraform:
1.	Install Terraform on your local machine.
2.	Create a Terraform configuration file that defines the resources you want to create.
3.	Initialize Terraform by running the following command:
    ```sh    
    terraform init 
    ```
    This will download the necessary plugins for your provider (in this case, AWS).
4.	Preview the resources that will be created by running the following command:
    ```sh 
    terraform plan -out "current.plan"
    ```
    This will show you a summary of the resources that will be created, modified, or destroyed.This will also save the plan to current.plan.
5.	Apply the changes by running the following command:
    ```sh
    terraform apply "current.plan"
    ```
    This will create the resources in your AWS account.
6.	When you are finished, you can destroy the resources by running the following command:
    ```sh
    terraform plan -destroy -out removal.plan
    terraform apply "removal.plan"
    ```
    This will delete all the resources that were created.