#! /bin/bash
yum install docker -y
systemctl start docker 
systemctl enable docker 
docker run -d -p 80:9966 -e DB_USERNAME=${DB_USERNAME} -e DB_PASSWORD=${DB_PASSWORD} -e DB_HOST=${DB_HOST} -e DB_NAME=${DB_NAME} imanurag30/petclinic-backend