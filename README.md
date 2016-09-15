#Puppet PKI
This module allows using the puppet certificates to establish trust between nodes in a network. Given that all nodes have a certificate with their hostname that is signed by the puppet master we can use the puppet master as an internal CA.

This module creates three files:

1. /etc/ssl/certs/host.crt: The certificate of this node
1. /etc/ssl/certs/host-ca.crt: The certificate of the puppet master that signs other certificates
1. /etc/ssl/private/host.key: The key of this node.

The puppet certificates are placed in the ssl-cert group to allow applications like apache to use them.
