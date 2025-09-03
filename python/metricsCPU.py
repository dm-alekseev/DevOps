import boto3
import datetime
ec2 = boto3.client('ec2')
cloudwatch = boto3.client('cloudwatch')
instance_id = 'i-0aefd6091844fc2cf'

def get_instance_details(instance_id):
    try:
        response = ec2.describe_instances(InstanceIds=[instance_id])
        instance_details = response['Reservations'][0]['Instances'][0]

        instance_type = instance_details['InstanceType']
        os = instance_details['PlatformDetails'] if 'PlatformDetails' in instance_details else 'Linux/UNIX'
        public_ip = instance_details.get('PublicIpAddress', 'No public IP')
        private_ip = instance_details.get('PrivateIpAddress', 'No  IP')
        return instance_type, os, public_ip, private_ip

    except Exception as e:
        print(f"Ошибка при получении данных о экземпляре: {str(e)}")
        return None, None, None, None

def get_cpu_utilization(instance_id):
    try:
        end_time = datetime.datetime.utcnow()
        start_time = end_time - datetime.timedelta(hours=2)

        response = cloudwatch.get_metric_statistics(
            Namespace='AWS/EC2',
            MetricName='CPUUtilization',
            Dimensions=[
                {'Name': 'InstanceId', 'Value': instance_id}
            ],
            StartTime=start_time,
            EndTime=end_time,
            Period=300,
            Statistics=['Average'],
            Unit='Percent'
        )

        return response['Datapoints']

    except Exception as e:
        print(f"Ошибка при получении метрик CPU: {str(e)}")
        return []


if __name__ == "__main__":
    # Получение данных о экземпляре
    instance_type, os, public_ip, private_ip = get_instance_details(instance_id)

    # Получение метрик использования процессора
    cpu_metrics = get_cpu_utilization(instance_id)

    # Вывод данных
    print(f"Тип экземпляра: {instance_type}")

    print(f"ОС: {os}")
    print(f"Публичный IP: {public_ip}")
    print(f"Privaete ip: {private_ip}")

    if cpu_metrics:
        for data_point in cpu_metrics:
            print(f"Время: {data_point['Timestamp']}, Среднее использование CPU: {data_point['Average']}")
    else:
        print("Нет информации по метрикам CPU.")