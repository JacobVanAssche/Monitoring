# Install dependencies
yum install -y wget httpd php gcc glibc glibc-common gd gd-level make net-snmp

# Get Nagios
cd /tmp
wget http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-4.0.4.tar.gz
# Get Plugins
wget http://nagios-plugins.org/download/nagios-plugins-2.0.tar.gz

# Add Nagios User and Group
useradd nagios
groupadd nagcmd
usermod -a -G nagcmd nagios

# Untar nagios and plugins
tar zxvf nagios-4.0.4.tar.gz
tar zxvf nagios-plugins-2.0.tar.gz

# Install Nagios
cd nagios-4.0.4
./configure --with-command-group=nagcmd
make all
make install
make install-init
make install-config
make install-commandmode
make install-webconf

# Install Nagios plugins
cd /tmp/nagios-plugins-2.0
./configure --with-nagios-user=nagios --with-nagios-group=nagios
make
make install

# Create default user for web access
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

# Start Apache
service httpd start

# Start Nagios
service nagios start

# Run on system startup
chkconfig --add nagios
chkconfig --level 35 nagios on
chkconfig --add httpd
chkconfig --level 35 httpd on

# The nagios web interface will be accessible by http://<nagios.server.ip>/nagios
