# Introduction 
This sample project is boilerplate for static content applications that are meant to be hosted in Amazon S3 bucket.
The project contains a sample index.html page, that through AzureDevOps pipeline, will create the needed resources on Amazon. Then content is copied to S3 the created bucket.
The static content is meant is to be accessed through an Amazon Cloudfront distribution.
Therefore the setup will configure S3 bucket as private bucket by default while the Access level control will be set to be public through the pipeline.

There are two folders one with simple terraform/terragrunt setup and the other one is with more advanced setup. 
You should be able to configure your s3 bucket using the simplified setup by only providing a name of the s3 bucket for your app in each environment.
The advanced setup provides an example of how setup a more complicated terraform/terragrunt project. This could be used in situation when there is a need to create multiple resources by combining building multiple modules and creating dependencies between them

# Local development

Terraform v0.12.x

# Build and Test
1. Clone the repo into your local space
2. Choose between using simplified or advanced configuration. And remove the other to keep your project clean. (Preferably the simplified)
3. Update the Terraform state bucket name by doing the following:
   3.1 Change the value for the property "remote_state.config.bucket" in ..\infrastructure\environments\terragrunt.hcl with the appropriate bucket name.
   3.2 Update the inputs section

4. Make sure that the Library of hosting Azure DevOps project, has defined defined variable group named "aws-deploy" with the following variables:
   - AWS_PROFILE
   - SAML2AWS_USERNAME
   - SAML2AWS_PASSWORD
   - SAML2AWS_ROLE

These variables can be found in the capability's Amazon Account's Parameter Store. You can find it by going to AWS Systems Manager -> Parameter Store under Application Management in the menu.
Name of the parameter is /managed/deploy/ad-creds and the region is Frankfurt

5. Update the paths with the appropriate name in the azure-pipeline.yml file.

6. Move content of the xxxx_terraform_setup

7. Push the code and wait for the pipeline to finish. 
The pipeline will output the address of the bucket. You can view the file in the browser by pasting the the address http://app-name.s3.eu-central-1.amazonaws.com/index.html in the address bar.