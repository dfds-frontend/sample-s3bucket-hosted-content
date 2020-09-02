# Introduction 
This sample project contain boiler plates for static content applications that are meant to be hosted in Amazon S3 bucket.
The project contains a sample index.html page, which will deployed to an S3 bucket through Azure DevOps pipeline. The project contains Terraform code to configure the S3 bucket on Amazon. 
The pipeline will run Terragrunt scripts to create the s3 bucket and copy the html page to the new S3 bucket.

The static content is meant is to be accessed through an Amazon Cloudfront distribution.
Therefore the setup will configure S3 bucket as private bucket by default, while the Access level control will be set to be public on the content through the pipeline.

There are two folders one with simple terraform/terragrunt setup and the other one is with more advanced setup. 

You should be able to configure your s3 bucket using the simplified setup by only providing a name of the s3 bucket that is going to host the content of your app in each environment.

The advanced setup provides an example of how to deal with a more complicated terraform/terragrunt project. This could be used in situations when there is a need to use multiple resources to create bigger Cloud infrastructure. This is usually done by loading multiple modules and creating dependencies between them. You can read more about using Terraform modules [here](https://www.terraform.io/docs/configuration/modules.html).

# Local development

Terraform v0.12.x

# Build and Test
1. Clone the repo into your local space
2. Create a repo on Azure DevOps and clone it locally or use an existing repo.
3. Choose between using simplified or advanced configuration. And remove the other to keep your project clean. (Preferably the simplified)
4. Copy content to your project
5. Move content out of the xxxx_terraform_setup folder to root folder
The folder structure should ideally look like this:
```
   /root
      /app
      /infrastructure
         /environments
         /...
      azure-pipelines.yml
      README.md
      ...
```
6. Update the Terraform state bucket name by doing the following:
   3.1 Change the value for the property "remote_state.config.bucket" in this file ..\infrastructure\environments\terragrunt.hcl with the appropriate bucket name.
   3.2 Update the inputs section

7. Make sure that the Library inside the Azure DevOps project, has a variable group named "aws-deploy" with the following variables:
   - AWS_PROFILE
   - SAML2AWS_USERNAME
   - SAML2AWS_PASSWORD
   - SAML2AWS_ROLE

SAML Username and password can be found in the Parameter Store in Amazon Account that is associated with the capability. You can find it by going to AWS Systems Manager -> Parameter Store under Application Management in the menu.
The name of the parameter is /managed/deploy/ad-creds and make sure that the region is set to Frankfurt.

More information can be found at DFDS playbook here [here](https://wiki.dfds.cloud/en/playbooks/deployment/authentication).

8. Update the paths with the appropriate name in the azure-pipeline.yml file.

9. Push the code and wait for the pipeline to finish. 
The pipeline will output the address of the bucket. You can view the file in the browser by pasting the the address http://app-name.s3.eu-central-1.amazonaws.com/index.html in the address bar.

## Adding more staging environment
Adding a new staging environment is as simple as creating a new folder under /infrastructure/environments/your_environment_name
The easiest way to create the new folder is by copying the content of /infrastructure/environments/staging into your new folder /infrastructure/environments/your_environment_name. Then finally updating the inputs section inside /infrastructure/environments/your_environment_name/terragrunt.hcl