# Alpine NFS Server v4.1

This is a small NFS server with NFSv4.1 version restriction.
Use it with open/forwarded ports:

- TCP:2049 (rpcd)
- TCP:111 and UDP:111 (data)
- TCP:4045 and UDP:4045 (locks)

This is implemented for local development for Kubernetes-based
applications that will be running on AWS EFS. In other words,
this is AWS EFS development mock.
