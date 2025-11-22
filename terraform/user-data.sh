#!/bin/bash
# Amazon Linux 2 bootstrap - installs mysql client and useful tools
yum update -y
yum install -y jq mysql
# create a small helper script for connecting (rds endpoint will be provided by you)
cat > /home/ec2-user/connect-rds.sh <<'EOS'
#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: ./connect-rds.sh <rds-endpoint>"
  exit 1
fi
mysql -h "$1" -P 3306 -u "${DB_USER:-admin}" -p
EOS
chmod +x /home/ec2-user/connect-rds.sh
chown ec2-user:ec2-user /home/ec2-user/connect-rds.sh
