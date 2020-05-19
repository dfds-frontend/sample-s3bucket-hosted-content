# Introduction 
This sample project is boilerplate for static content applications that are meant to be hosted in Amazon S3 bucket.
The project contains a sample index.html page, that through AzureDevOps pipeline, will create the needed resources on Amazon. Then content is copied to S3 the created bucket.
The static content is meant is to be accessed through an Amazon Cloudfront distribution.
Therefore the setup will configure S3 bucket as private bucket by default while the Access level control will be set to be public through the pipeline.

# Local development

Terraform v0.12.x

# Build and Test
1. Clone the repo into your local space
2. Update the Terraform state bucket name
   Change the value for the property "remote_state.config.bucket" in \infrastructure\environments\terragrunt.hcl with the appropriate bucket name.

3. Make sure that the Library of hosting Azure DevOps project, has defined defined variable group named "aws-deploy" with the following variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY.
These variables can be found in the capability's Amazon Account's Parameter Store.

4. (Optional) Update the paths with the appropriate name when desired.

5. Push the code and wait for the pipeline to finish. 
The pipeline will output the address of the bucket. You can view the file in the browser by pasting the the address http://app-name.s3.eu-central-1.amazonaws.com/index.html in the address bar.