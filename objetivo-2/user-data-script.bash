#!/bin/bash
yum install -y amazon-efs-utils nfs-utils git python3-pip

FILE_SYSTEM_ID=fs-05144e4f3d335c7a3
EFS_MOUNT_POINT=/mnt/efs
APP_DIR=${EFS_MOUNT_POINT}/bookstore

# Prepare and mount EFS
mkdir -p ${EFS_MOUNT_POINT}
echo "${FILE_SYSTEM_ID}:/ ${EFS_MOUNT_POINT} efs _netdev,tls 0 0" >> /etc/fstab
mount -a -t efs defaults

# Deploy Flask app to EFS
cd ${EFS_MOUNT_POINT}
git clone https://github.com/luismtorresv/bookstore-deployment.git
cd bookstore-deployment/bookstore
cp -r . ${APP_DIR}
cd ${APP_DIR}

# Install dependencies
pip3 install -r requirements.txt

# Environment variables for RDS
export FLASK_APP=app.py
export DATABASE_URL="mysql+pymysql://admin:bookstore-deployment@bookstore-deployment-database.c14osnlgmmzl.us-east-1.rds.amazonaws.com:3306/bookstore"

# Run Flask on port 80
nohup flask run --host=0.0.0.0 --port=80 &

