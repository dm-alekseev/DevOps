import boto3
def terminate_ec2_instance(instance_id):
    ec2 = boto3.resource('ec2')
    instance = ec2.Instance(instance_id)
    response = instance.terminate()

    print(f'Terminating instance {instance_id}: {response}')

if __name__ == "__main__":
    instance_id = 'i-0aefd6091844fc2cf'
    terminate_ec2_instance(instance_id)