import json
import boto3

def lambda_handler(event, context):
    asg_name = event['AutoScalingGroupName']
    max_size = event['MaxSize']
    
    client = boto3.client('autoscaling')
    
    response = client.update_auto_scaling_group(
        AutoScalingGroupName=asg_name,
        MaxSize=max_size
    )

    print(response)
    
    return {
        'statusCode': 200,
        'body': json.dumps('Auto Scaling group updated successfully!')
    }