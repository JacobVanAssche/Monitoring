# Get additional repositories
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm

# Yum install all of the things
yum -y install nagios gcc httpd gcc-c++ autoconf automake mlocate xinetd check-mk-agent nagios-plugins-all.x86_64 mod_python

# Start the services Apache, Nagios and xinetd on startup
chkconfig httpd on
chkconfig nagios on
chkconfig xinetd on

service httpd start
service nagios start
service xinetd start

# Set user/password for nagios
htpasswd -c /etc/nagios/passwd nagiosadmin
# Check if nagios is up on http://<nagios.server.ip>/nagios

# Download and install check_mk
cd /tmp
wget https://mathias-kettner.de/download/check_mk-1.2.5i2.tar.gz
tar zxfv check*
cd check*
./setup.sh --yes
