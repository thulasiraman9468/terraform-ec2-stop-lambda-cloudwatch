import boto3
region = 'us-east-1'
#instances = ['i-0dfe38e73445d4885']
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    ec2.stop_instances(InstanceIds=[event["id"]])
    print('stopped your instances')