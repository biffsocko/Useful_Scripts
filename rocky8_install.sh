#!/bin/sh
#######################################
# TR Murphy
# rocky8_install.sh
#
# example of how to install rocky8 with
# an ansible pull 
#######################################
dnf groupinstall Server
dnf groupinstall base
dnf groupinstall core
dnf groupinstall 'Development Tools'
dnf groupinstall 'Legacy UNIX Compatibility'
dnf groupinstall 'System Tools'
dnf groupinstall 'Security Tools'
dnf groupinstall 'Container Management'

LIST="kexec-tools
      dstat
      git
      chrony
      net-snmp
      net-snmp-utils
      telnet
      nmap
      epel-release
      libnsl "


dnf -y install $LIST
dnf -y install ansible

echo "starting biff post install"
echo "search schonfeld.com prod.schonfeld.com uat.schonfeld.com dev.schonfeld.com securities.schonfeld.com" > /etc/resolv.conf
echo "nameserver 10.202.80.3" >> /etc/resolv.conf
echo "nameserver 10.202.80.4" >> /etc/resolv.conf


echo "SELINUX=disabled" > /etc/selinux/config

cd /root
mkdir --mode=700 .ssh
cat >> .ssh/authorized_keys << "PUBLIC_KEY"
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA0gOAFuRZkMOj7aelFnaXkWiAwskRyhUREklDw7vURMiHR6dFwsz0SOw6KlS3N4wTpYS7hLK/uFN7WGFqrCBOKqIVOb6kvjUqNO9YwjB3gpeh75RLX8PTPFEAAIpWmq2y0FysTjcq1zSqVGK5URqG4DbPVoET/E9cVHZbRKcNJOeHk4IVBxAohHVqQafs0DF7LTms9TYmBK7Z7G/z/y1MUoF5SBfBP1MHSDtLbtD4ny0GucBtSm7OWv5bgazOZP1MDDj8+nDG1Oys0ZeI5Pf2Ki2SFG7pTv5Oizn+JzzN6lhP0+ROdK1ELtJO1fYAerO5tGhv3zJ9Wdt+RZx7Anchqw== root@grv-jump01
PUBLIC_KEY

chmod 600 .ssh/authorized_keys

############################################
# ANSIBLE  SETUP
############################################
# install key for ansible-pull
# note - this key has been altered so it will not
# work anyplace
cat >> .ssh/id_rsa_ansible << "PRIVATE_KEY"
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAs8myQtMaMd8nE56l4xySUlHIhtk/Xb4e+WAPM6FMIcrovp5m
3p4o4IsrNzqgajBLTn9RlnCGQ9Wb+0gOHIYQpe0stX66RNFw20EabW507OV3eWN9
gJ26uzs14gR6SWRlDB97QIKtnwB49HLbZMnxWKpHMjPL6DqFg+L91SfyjV6fWKUL
d1umReGyz6vvvv0OrZqoEXARssNXxgQ5lJo1NJE+5+8WEYakyOS00O6xUzyosgw2
UkudhKHP1VK5fGCTYBs7VfepwQjpnf0C0CBCp4P6m0qqL+4hQVMXbxdiTK68+4UE
sU2mSPX2teLEeCoJv0Ho7QvuW5xTlgaS8solTQIDAQABAoIBAQCAyYDagaIIC5RQ
Z5rpP3RJZ7A/eKv9mM1TUc5R678/jbx/n7SMz7r0bny8iVCUAJhRWL63B1AGk6Oy
swD4ychvM6CNOoRv+5/eT5qAvVkgwZd96xjh4xr6OAX3K8H1hOclcf+2TGXWul3q
rcQfRNGP9BogCh6M8i7mNNojsQP845C6apHFnXtDVng7SeOlbEWRJJOchYllGu00
XfOcLbZ2d3x6u0QKK7gVTsRP38AD7YT9BUNFmHQT9Pj/EhRnI4QtwmsfwfUrhzPV
TRJDi0vuqaFRk7yu83mvYxImsYkfI9/LSFa7DcWo62Ew7i2qXHlIqpEO9kmKJsaA
qyo9wbd5AoGBAOnu9UBOF9a86cOUX2tPSyeadRIeBxNPSltNCtY0IdXnminxSBaV
IGED/xGYnQTlz7wT0on+l4+SuRrYapMsb77xt0P0BKkEADLxwFnH78dzZ2JjX/5Y
CQAikIPd9qPxnoJ1dMoGBBS9rJRFCpynyif4khgGCCzMAEYPNa/SDzW3AoGBAMS/
Ojlr3KUHgMmE/bce9QkVVpJxp0d3l7qdOxZCPfdiyeR+0SVjS3pTtasdH4yrpciw
tbfUCZfZ2CVw40nTsscNplNPQAy87EYYx+mPcFyGWLAFHC8KYPRNVgp9I34w8Dxc
SsjB+CwMNqWs7gTjuKYlX/De8pvgulBXOS2AtF0bAoGAI0JnKNgcc7tpqJb2guAi
vcdkGeT4wApVdMl59qtI5krQS74YVX8IsFa/3VEZaaGR3BFIzI/ZHETLLaas+Z3b
AfbA3rcq9KaruQIDMgUWuQNF8+hykY2jasPX8GhGQpOqhpNZlRGvD8k+9+IoJVCN
AdVPf9t44/ejmuuz9do9fKUCgYEAnHWKAuHw3FgkJZ2Z+kcnC6spZln1chL72U5y
D5hsGNA5x3jGL5pQCp6I54C6Si6yLu/AAskfO9/kUJn+VdaBJGSJcVTjlX2j03af
e/AypZG883WM3Se+xGi/1KWBVTfrw8SNQCtohPbNemEUA1VooM+2BSH3AtjqsTs7
4CCqziMCgYByRbg4kt4SfSJQMB8KaZQha/FAlr3Z9DiXfiYdxML8/6feg0reuTUn
q75gCIX0VMHRWilxeuwL+hd00uTBHOF2PTfHA3XPWIiQJSEcTFlf9QfZycRCTcNL
r+TAS1Tt3s0sviOQF62avyHxoX7AJRHTuPg96jMLyfsK3zQsLg04qg==
-----END RSA PRIVATE KEY-----
PRIVATE_KEY

chmod 600 .ssh/id_rsa_ansible

echo "[all]" > /tmp/inventory
echo `hostname`  >> /tmp/inventory


############################################
# updated base to include more stuff
############################################
#ansible-pull -i /tmp/inventory -U git@github.dumpyplace.com:infrastructure/ansible-infrastructure.git base.yml --key-file /root/.ssh/id_rsa_ansible --accept-host-key
ansible-pull -i /tmp/inventory -U git@github.dumpyplace.com:infrastructure/ansible-infrastructure.git base_packer.yml --key-file /root/.ssh/id_rsa_ansible --accept-host-key
