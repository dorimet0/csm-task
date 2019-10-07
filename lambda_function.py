import json
import boto3

ADMIN_ACCESS_ARN = "arn:aws:iam::aws:policy/AdministratorAccess"
BILLING_ARN = "arn:aws:iam::aws:policy/job-function/Billing"


def lambda_handler(event, context):
    iam = boto3.resource('iam')
    engineering = iam.Role('Engineering')
    finance = iam.Role('Finance')

    admin_access_policy = iam.Policy(ADMIN_ACCESS_ARN)
    billing_policy = iam.Policy(BILLING_ARN)

    engineering_policies = engineering.attached_policies.all()
    # I assume either one of the policies is applied.
    if admin_access_policy in engineering_policies:
        response = admin_access_policy.detach_role(
            RoleName='Engineering')
        response = admin_access_policy.attach_role(
            RoleName='Finance')

        response = billing_policy.attach_role(
            RoleName='Engineering')
        response = billing_policy.detach_role(
            RoleName='Finance')
    else:
        response = admin_access_policy.detach_role(
            RoleName='Finance')
        response = admin_access_policy.attach_role(
            RoleName='Engineering')

        response = billing_policy.attach_role(
            RoleName='Finance')
        response = billing_policy.detach_role(
            RoleName='Engineering')



    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
