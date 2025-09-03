from getpass import getpass
import paramiko
import subprocess

ssh = paramiko.SSHClient()
ssh.load_system_host_keys()
#key_pass = getpass ("Enter key:")
key = paramiko.RSAKey.from_private_key_file("C:\cert\dalekseev.pem")
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
#ssh.connect('3.125.3.71', username='username', password='password')
ssh.connect('3.125.3.71',  username='ubuntu', pkey = key)
            #allow_agent=False,
            #look_for_keys=False)
stdin, stdout, stderr = ssh.exec_command('python3 cpu.py' )

print(stdout.read().decode())
ssh.close()