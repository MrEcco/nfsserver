# Alpine NFS Server v4.1

This is just small NFS server with strict using version 4.1 of
NFS protocol. Use it with open/forwarded ports: 

- TCP:2049 (rpcd)
- TCP:111 and UDP:111 (data)
- TCP:4045 and UDP:4045 (locks)

This implemented for local developing for Kubernetes-based
applications that will be running on AWS EFS.
