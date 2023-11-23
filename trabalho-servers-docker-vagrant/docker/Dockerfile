# Use a imagem NFS Server Alpine
FROM itsthenetwork/nfs-server-alpine:latest

# Crie um diretório para compartilhar
RUN mkdir -p /shared

# Configure as exportações NFS
RUN echo "/shared *(rw,fsid=0,sync,no_subtree_check,no_auth_nlm,insecure,no_root_squash)" > /etc/exports

# Exponha as portas necessárias
EXPOSE 2049
EXPOSE 111/udp
EXPOSE 111