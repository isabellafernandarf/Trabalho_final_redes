## DOCUMENTAÇÃO DO PROJETO
Discentes: Isabela Fernanda Rodrigues de Oliveira e Wanessa Martins Rocha
Disciplina: Administração de Redes de Computadores 
4º Período

Vagrantfile: 

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network "public_network", ip: "10.0.0.10", type:"static"
  config.vm.provision "docker" do |docker|
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt update
    sudo apt install nfs-common
    sudo docker docker run -it --rm --init --net host -v "$(pwd)/data":/data networkboot/dhcpd eth0. dhcpd
    sudo docker docker run -d --name bind9-container -e TZ=UTC -p 30053:53 ubuntu/bind9:9.18-22.04_beta
    sudo docker run -dit --name my-apache-app -p 8080:80 -v "$PWD":/usr/local/apache2/htdocs/ httpd:2.4
    sudo docker run -d -p 21:21 -v /my/data/directory:/home/vsftpd --name vsftpd fauria/vsftpd
    sudo docker run -d --name nfs --privileged -v /some/where/fileshare:/nfsshare -e
  SHELL
  end
end


●	config.vm.box = "ubuntu/bionic64": Define a imagem base da máquina virtual como o Ubuntu 18.04 (bionic64).
●	config.vm.network "public_network", ip: "10.0.0.10", type: "static": Configura a interface de rede da máquina virtual para usar um endereço IP estático (10.0.0.10) na rede pública.
●	config.vm.provision "docker": Define a configuração de provisionamento para o Docker.
●	config.vm.provision "shell", inline: <<-SHELL ...: Executa comandos shell dentro da máquina virtual para instalar pacotes e puxar imagens Docker.

- sudo apt update: atualiza a lista de pacotes disponíveis para instalação na sua máquina virtual.
- sudo apt install nfs-common: instala o pacote nfs-common, que contém os utilitários necessários para montar sistemas de arquivos NFS (Network File System) na sua máquina virtual. O NFS é um protocolo que permite compartilhar arquivos entre máquinas em uma rede.
- sudo docker docker run -it --rm --init --net host -v “(pwd)/data":/datanetworkboot/dhcpdeth0.dhcpd:executaumconte^inerDockercomaimagemnetworkboot/dhcpd,queconteˊmumservidorDHCP(DynamicHostConfigurationProtocol)configuradoparaainterfacederedeeth0.ODHCPeˊumprotocoloquepermiteatribuirenderec\c​osIPdinamicamenteaosdispositivosemumarede.Ocomandotambeˊmusaasopc\c​o~es−itparainteragircomoconte^iner,−−rmpararemoveroconte^inerapoˊsaexecuc\c​a~o,−−initparausarotinicomooprocessoinicialdoconte^iner,−−nethostparausararededohost,e−v"(pwd)/data”:/data para montar o diretório data do host no contêiner.
- sudo docker docker run -d --name bind9-container -e TZ=UTC -p 30053:53 ubuntu/bind9:9.18-22.04_beta: executa um contêiner Docker com a imagem ubuntu/bind9:9.18-22.04_beta, que contém um servidor DNS (Domain Name System) configurado com o BIND 9. O DNS é um sistema que permite resolver nomes de domínio em endereços IP. O comando também usa as opções -d para executar o contêiner em segundo plano, --name bind9-container para dar um nome ao contêiner, -e TZ=UTC para definir a variável de ambiente TZ como UTC, e -p 30053:53 para mapear a porta 53 do contêiner para a porta 30053 do host.
- sudo docker run -dit --name my-apache-app -p 8080:80 -v “$PWD”:/usr/local/apache2/htdocs/ httpd:2.4: executa um contêiner Docker com a imagem httpd:2.4, que contém um servidor web Apache. O Apache é um software que permite servir páginas web e outros conteúdos na internet. O comando também usa as opções -dit para executar o contêiner em segundo plano, interagir com ele e alocar um pseudo-TTY, --name my-apache-app para dar um nome ao contêiner, -p 8080:80 para mapear a porta 80 do contêiner para a porta 8080 do host, e -v “$PWD”:/usr/local/apache2/htdocs/ para montar o diretório atual do host no diretório htdocs do contêiner.
- sudo docker run -d -p 21:21 -v /my/data/directory:/home/vsftpd --name vsftpd fauria/vsftpd: executa um contêiner Docker com a imagem fauria/vsftpd, que contém um servidor FTP (File Transfer Protocol) configurado com o vsftpd. O FTP é um protocolo que permite transferir arquivos entre máquinas em uma rede. O comando também usa as opções -d para executar o contêiner em segundo plano, -p 21:21 para mapear a porta 21 do contêiner para a porta 21 do host, -v /my/data/directory:/home/vsftpd para montar o diretório /my/data/directory do host no diretório /home/vsftpd do contêiner, e --name vsftpd para dar um nome ao contêiner.
- sudo docker run -d --name nfs --privileged -v /some/where/fileshare:/nfsshare -e: executa um contêiner Docker com a imagem itsthenetwork/nfs-server-alpine, que contém um servidor NFS configurado com o Alpine Linux. O comando também usa as opções -d para executar o contêiner em segundo plano, --name nfs para dar um nome ao contêiner, --privileged para dar ao contêiner acesso total ao dispositivo host, -v /some/where/fileshare:/nfsshare para montar o diretório /some/where/fileshare do host no diretório /nfsshare do contêiner, e -e para definir a variável de ambiente SHARED_DIRECTORY como /nfsshare.

####
Inicialmente, é necessário subir a máquina virtual, entrando no diretório em que está incluído o Vagrant, digitando o comando “vagrant up” no terminal. Isso permitirá subir a imagem escolhida para a criação da VM. Logo após é possível entrar na máquina virtual digitando o comando “vagrant ssh default”. Default é o nome da VM. Em seguida entre na pasta vagrant com o comando “cd /vagrant” e o após o comando “sudo su” para conseguir as permissões necessárias. O próximo comando a ser digitado é o “./script.sh” que irá executar o script no sistema operacional. Por fim, digite o comando “docker ps -a” que irá listar todos os contêineres do docker, incluindo os que estiverem parados. 
####

Dockerfile para Servidor NFS
Este Dockerfile cria um contêiner com um servidor NFS configurado para compartilhar o diretório /shared. Aqui estão as partes importantes do arquivo:
1.	Imagem Base (FROM itsthenetwork/nfs-server-alpine:latest):
○	Utilizamos a imagem itsthenetwork/nfs-server-alpine:latest como base. Essa imagem já contém um servidor NFS configurado.
2.	Criação do Diretório Compartilhado (RUN mkdir -p /shared):
○	Criamos um diretório chamado /shared dentro do contêiner. Esse diretório será usado para compartilhar arquivos via NFS.
3.	Configuração das Exportações NFS (RUN echo "/shared *(rw,fsid=0,sync,no_subtree_check,no_auth_nlm,insecure,no_root_squash)" > /etc/exports):
○	Definimos as configurações de exportação NFS para o diretório /shared.
○	Essas configurações permitem que qualquer cliente monte o diretório /shared com permissões de leitura e gravação.
4.	Exposição das Portas (EXPOSE 2049, EXPOSE 111/udp, EXPOSE 111):
○	As instruções EXPOSE especificam quais portas do contêiner devem ser expostas para comunicação externa.
○	Aqui, estamos expondo as portas 2049 (NFS), 111 (RPC) e 111/udp (RPC via UDP).


# DHCP

O servidor DHCP, que é responsável por atribuir endereços IP às máquinas na rede, foi utilizado este serviço: https://hub.docker.com/r/networkboot/dhcpd/ para o conteiner em docker.
Após baixá-lo é necessário criar um arquivo de configuração de dhcp, igual ao arquivo de configurações básicas na pasta config/dhcp.
Utilizando o comando para criar o contêiner, automaticamente o arquivo de configuração será atribuído ao servidor.

Script do DHCP:
subnet 10.0.0.0 netmask 255.255.255.0 {
  range 10.0.0.100 10.0.0.200;
  option routers 10.0.0.1;
  option domain-name-servers 10.0.0.10;
  default-lease-time 600;
  max-lease-time 7200;
  authoritative;
}

Explicações para cada linha:

- subnet 10.0.0.0 netmask 255.255.255.0: Define a sub-rede com endereço IP 10.0.0.0 e máscara de sub-rede 255.255.255.0.
- range 10.0.0.100 10.0.0.200;: Especifica o intervalo de endereços IP que o servidor DHCP pode atribuir às máquinas na rede (de 10.0.0.100 a 10.0.0.200).
- option routers 10.0.0.1;: Define o endereço IP do gateway padrão (roteador) para a rede como 10.0.0.1.
- option domain-name-servers 10.0.0.10;: Especifica o endereço IP do servidor DNS (10.0.0.10) que será fornecido aos clientes DHCP.
- default-lease-time 600;: Define o tempo de concessão padrão para endereços IP (em segundos).
- max-lease-time 7200;: Define o tempo máximo de concessão para endereços IP (em segundos).
- authoritative;: Indica que este servidor DHCP é a fonte autoritativa para informações de configuração na rede.
## Teste do DHCP 
Crie uma nova máquina na rede e utilize os comandos "sudo dhclient -r" liberar o endereço IP atual "sudo dhclient" e solicitar um novo endereço IP.


# DNS

O servidor DNS é responsável por resolver os dominios para IP, foi utilizado este serviço: https://hub.docker.com/r/ubuntu/bind9
Após baixá-lo é necessário criar alguns arquivos de configuração de dns, igual aos arquivos de configurações básicas na pasta config/dns.
Utilizando o comando para criar o contêiner, automaticamente os arquivos de configuração serão atribuídos ao servidor.
## Teste do DNS
Utilize o comando dig example.com, já o domínio usado para criar o servidor foi esse de exemplo. Qualquer site que você digitar acompanhado do "dig", te resultará em um endereço IP, pois essa é exatamente a função do DNS. 



# APACHE

O servidor APACHE é responsável por criar um servidor WEB, foi utilizado este serviço: https://hub.docker.com/_/httpd
Após baixá-lo é necessário criar um arquivo de index.html, semelhante ao arquivo de na pasta web.
Utilizando o comando para criar o contêiner, automaticamente o arquivo index.html será atribuído ao servidor.
## Teste do apache 
Abra o navegador nesta pagina "http://10.0.0.10:8080" e verá o seu arquivo de index.html

# FTP

O servidor FTP é um protocolo padrão de rede usado para transferir arquivos de um host para outro em uma rede, foi utilizado este serviço: https://hub.docker.com/r/fauria/vsftpd
## Teste do FTP
Abra o terminal e digite ftp admin@10.0.0.10, usuário e senha são admin, admin respectivamente.

# NFS
O servidor NFS é responsável pelo compartilhamento de arquivos que permite computadores na rede compartilharem diretorios e arquivos, foi utilizado este serviço: https://hub.docker.com/r/itsthenetwork/nfs-server-alpine
## Teste do NFS
Após executá-lo crie uma pasta para receber o compartilhamento, mkdir /mnt/nfs, depois monte o compartilhamento na pasta, mount -v 10.0.0.10:/nfsshare /mnt/nfs, crie um arquivo para testar, docker exec -it server-nfs touch /nfsshare/teste.txt

## TOPOLOGIA DE REDE 
O host do Vagrant, é uma máquina virtual Ubuntu com o endereço IP 10.0.0.10. O host do Vagrant é o ambiente onde é executado o script e o vagrantfile para criar e configurar os contêineres Docker.
Os contêineres Docker são ambientes isolados que executam os serviços de rede que você especificou, como DHCP, DNS, Apache, FTP e NFS. Cada contêiner Docker tem o seu próprio endereço IP na rede privada, que é diferente do endereço IP do host do Vagrant na rede pública.
A rede pública é a rede que usada para acessar o host do Vagrant a partir do seu computador ou de outros dispositivos na internet. O endereço IP do host do Vagrant na rede pública é 10.0.0.10, especificado no vagrantfile. 
A rede privada é a rede que usada para comunicar entre os contêineres Docker e o host do Vagrant. A rede privada tem o seu próprio intervalo de endereços IP, que é diferente do intervalo de endereços IP da rede pública. Os endereços IP dos contêineres Docker na rede privada são atribuídos pelo serviço DHCP, que é executado pelo contêiner Docker chamado server-dhcp.
É possível acessar o serviço Apache a partir da rede pública usando o endereço IP e a porta do host do Vagrant, que são 10.0.0.10 e 8080, respectivamente. 
Os serviços DNS, FTP e NFS, são executados pelos contêineres Docker chamados server-dns, server-ftp e server-nfs, respectivamente, para a rede pública. Você pode acessar esses serviços a partir da rede pública usando os endereços IP e as portas do host do Vagrant, que são 10.0.0.10 e 30053, 21 e 2049, respectivamente. A rede foi criada a partir da topologia de rede anel. 