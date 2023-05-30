echo -e "\e[32minstalling redis repo file as a rpm \e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
echo -e "\e[32mEnabling Redis 6.2 from package strean \e[0m"
yum module enable redis:remi-6.2 -y
echo -e "\e[32mInstalling redis\e[0m"
yum install redis -y
echo -e "\e[32mSetting redis listen address\e[0m"
sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/redis/redis.conf
echo -e "\e[32mEnabling & Starting the service\e[0m"
systemctl enable redis
systemctl restart redis