# CSM intern task README

this repository is a simple system to create two roles in aws IAM and switch between the policies every 10 minutes.

## files:
* provider.tf - general provider file. need to change to **your** key.
* Roles.tf - a configuration file for the engineering and finance roles and their default policies.
* lambda.tf - configures a simple lambda function with IAM permissions.
* rule.tf - a cloudwatch rule to invoke the lambda function every 10 minutes.
* lambda_function.py - the actual function aws runs. uses boto3 API.
* func.zip - lambda_function.py packed in zipfile.