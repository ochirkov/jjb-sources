# Install Jenkins https://www.jenkins.io/doc/book/installing/linux/#debianubuntu
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update
apt-get install openjdk-8-jre nginx -y
apt-get install jenkins -y \
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libsqlite3-dev \
    libreadline-dev \
    libffi-dev \
    curl \
    libbz2-dev
cd /tmp
curl -O https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tar.xz
curl -O https://www.python.org/ftp/python/3.7.12/Python-3.7.12.tar.xz
tar -xf Python-3.7.12.tar.xz
tar -xf Python-3.8.2.tar.xz
cd Python-3.8.2 && ./configure && make -j 4 && make altinstall
cd ../Python-3.7.12 && ./configure && make -j 4 && make altinstall
curl -O https://bootstrap.pypa.io/get-pip.py && python3.8 get-pip.py

# create ssl cert
mkdir  /etc/ca-certificates/jenkins
openssl req -newkey rsa:2048 -nodes \
  -keyout /etc/ca-certificates/jenkins/key.pem -x509 \
  -days 365 -out /etc/ca-certificates/jenkins/certificate.pem \
  -subj "/C=UA/ST=Kyiv/L=Kyiv/O=Dis/CN=jenkins.example.com"
openssl x509 -text -noout -in /etc/ca-certificates/jenkins/certificate.pem
chown -R www-data:www-data /etc/ca-certificates/jenkins/

# configure Nginx proxy https://www.jenkins.io/doc/book/system-administration/reverse-proxy-configuration-nginx/

cp ./jenkins.conf /etc/nginx/sites-available/jenkins

# Enable Jenkins site
ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/
rm /etc/nginx/sites-available/default
mkdir -p /var/log/nginx/jenkins
chown www-data:www-data /var/log/nginx/jenkins
systemctl restart nginx

