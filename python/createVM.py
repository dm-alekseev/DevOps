import boto3
ec2_resource = boto3.resource('ec2')
instances = ec2_resource.create_instances(
    ImageId="ami-07eef52105e8a2059",
    MinCount=1,
    MaxCount=1,
    InstanceType="t2.micro",
    KeyName='dalekseev'
    )
