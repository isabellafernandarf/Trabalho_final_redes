#!/bin/bash

#docker exec -it server-nfs touch /nfsshare/teste.txt

sudo docker run -d --name server-dhcp -v /vagrant/config/dhcp/dhcpd.conf:/etc/dhcp/ networkboot/dhcpd:latest
sudo docker run -d --name server-dns -v /vagrant/config/dns/:/etc/bind/ -p 30053:53 ubuntu/bind9:latest
sudo docker run -d --name server-apache -v /vagrant/web/:/usr/local/apache2/htdocs/ -p 8080:80 httpd:2.4
sudo docker run -d --name server-ftp -v /home/vagrant:/home/vsftpd -p 20:20 -p 21:21 -p 21100-21110:21100-21110 -e FTP_USER=admin -e FTP_PASS=admin -e PASV_ADDRESS=127.0.0.1 -e PASV_MIN_PORT=21100 -e PASV_MAX_PORT=21110 fauria/vsftpd
sudo docker run -d --name server-nfs --privileged -v /vagrant/nfs:/nfsshare  --net=host  -e SYNC=true -e SHARED_DIRECTORY=/nfsshare itsthenetwork/nfs-server-alpine:latest
