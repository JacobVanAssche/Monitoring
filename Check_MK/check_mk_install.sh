# Download check_mk rpm
wget https://mathias-kettner.de/support/1.2.6p9/check-mk-raw-1.2.6p9-el6-34.x86_64.rpm

# Download all dependencies
yum install xinetd
yum install time
yum install traceroute
yum install dialog
yum install graphviz
yum install graphviz-gd
yum install php-mbstring
yum install php-pdo
yum install php-gd
yum install python-reportlab
yum install python-ldap
yum install uuid
yum install freeradius-utils
yum install python-imaging
yum install poppler-utils

wget http://pkgs.repoforge.org/fping/fping-3.1-1.el6.rf.x86_64.rpm
rpm -i fping-3.1-1.el6.rf.x86_64.rpm

wget http://pkgs.repoforge.org/libmcrypt/libmcrypt-2.5.7-1.2.el6.rf.x86_64.rpm
rpm -i libmcrypt-2.5.7-1.2.el6.rf.x86_64.rpm

wget http://dl.fedoraproject.org/pub/epel/6/x86_64/mod_fcgid-2.3.9-1.el6.x86_64.rpm
rpm -i mod_fcgid-2.3.9-1.el6.x86_64.rpm

wget http://pkgs.repoforge.org/perl-Crypt-DES/perl-Crypt-DES-2.05-3.2.el6.rf.x86_64.rpm
rpm -i perl-Crypt-DES-2.05-3.2.el6.rf.x86_64.rpm

wget http://pkgs.repoforge.org/perl-Digest-SHA1/perl-Digest-SHA1-2.13-1.el6.rfx.x86_64.rpm
rpm -i perl-Digest-SHA1-2.13-1.el6.rfx.x86_64.rpm

wget http://mirror.centos.org/centos/6/os/i386/Packages/perl-Digest-HMAC-1.01-22.el6.noarch.rpm
rpm -i perl-Digest-HMAC-1.01-22.el6.noarch.rpm

wget http://pkgs.repoforge.org/perl-Socket6/perl-Socket6-0.23-1.el6.rfx.x86_64.rpm
rpm -i perl-Socket6-0.23-1.el6.rfx.x86_64.rpm

wget http://pkgs.repoforge.org/perl-Net-SNMP/perl-Net-SNMP-5.2.0-1.2.el6.rf.noarch.rpm
rpm -i perl-Net-SNMP-5.2.0-1.2.el6.rf.noarch.rpm

rpm -i check-mk-raw-1.2.6p9-el6-34.x86_64.rpm

# Source
wget https://mathias-kettner.de/support/1.2.6p9/check-mk-raw-1.2.6p9.cre.tar.gz
tar xzf check-mk-raw-1.2.6p9.cre.tar.gz