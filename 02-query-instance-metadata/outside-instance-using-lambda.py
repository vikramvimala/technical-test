import json
import boto3

def lambda_handler(event, context):
    
    instance_id = event['instance_id']

    ec2 = boto3.client("ec2")

    try:
        response = ec2.describe_instances(
            Filters=[
                {
                    "Name": "instance-id",
                    "Values": [instance_id]
                }
            ]
        )
        instance_metadata = response["Reservations"][0]["Instances"][0]
        
        print(json.dumps(instance_metadata, indent=2, default=str))

    except ec2.exceptions.ClientError as error:
        if error.response["Error"]["Code"] == "InvalidInstanceID.NotFound":
            print(f"Instance with ID '{instance_id}' not found.")
        else:
            print(error)
