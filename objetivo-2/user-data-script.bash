#!/bin/bash
yum install -y amazon-efs-utils nfs-utils git

FILE_SYSTEM_ID=fs-05144e4f3d335c7a3
EFS_MOUNT_POINT=/mnt/efs

mkdir -p ${EFS_MOUNT_POINT}

# Mount the EFS
echo "${FILE_SYSTEM_ID}:/ ${EFS_MOUNT_POINT} efs _netdev,tls 0 0" >> /etc/fstab
mount -a -t efs defaults

# Clone or copy your Flask app
cd /home/ec2-user
git clone https://github.com/luismtorresv/bookstore-deployment.git
cd bookstore-deployment
cd bookstore

# Install dependencies
yum install -y python3-pip
pip3 install -r requirements.txt

# Environment variables for RDS
export FLASK_APP=app.py
export DATABASE_URL="mysql+pymysql://admin:bookstore-deployment@bookstore-deployment-database.c14osnlgmmzl.us-east-1.rds.amazonaws.com:3306/bookstore"

# Start Flask (example via systemd or background process)
nohup flask run --host=0.0.0.0 --port=80 &

