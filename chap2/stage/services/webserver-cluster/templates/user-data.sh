#!bin/bash

sudo yum update -y && sudo yum install httpd -y  # Update system and install apache

sudo sed -i "s/^Listen .*/Listen ${custom_http_port}/" /etc/httpd/conf/httpd.conf  # Change the listening port

sudo systemctl restart httpd && sudo systemctl enable httpd

cat > /var/www/html/index.html <<EOF
<hmtl>
    <h1>Hello, World</h1>
    <p>This is a simple web page served by Apache on port ${custom_http_port}.</p>
</html>
EOF