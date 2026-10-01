# system id = 8vQN4JKze0O
#
/interface bridge
add name=bridge1 vlan-filtering=yes
/interface gre
add keepalive=5s local-address=197.168.9.2 mtu=1400 name=Tunnel-0 \
    remote-address=196.127.86.2
/interface vlan
add interface=bridge1 name=vlan10 vlan-id=10
add interface=bridge1 name=vlan11 vlan-id=11
add interface=bridge1 name=vlan999 vlan-id=999
/ip ipsec profile
add dh-group=modp4096 enc-algorithm=aes-256,3des hash-algorithm=sha512 name=\
    Cisco
/ip ipsec peer
add address=196.127.86.2/32 local-address=197.168.9.2 name=cisco_policy1 \
    profile=Cisco
/ip ipsec proposal
add auth-algorithms=sha512,sha256,sha1 enc-algorithms="aes-256-cbc,aes-256-ctr\
    ,aes-256-gcm,aes-192-cbc,aes-192-ctr,aes-128-cbc,aes-128-gcm" name=\
    compay_pro
/ip pool
add name=dhcp_pool0 ranges=192.168.0.10-192.168.0.254
add name=dhcp_pool1 ranges=192.168.1.10-192.168.1.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=vlan10 name=dhcp1
add address-pool=dhcp_pool1 interface=vlan11 name=dhcp2
/port
set 0 name=serial0
set 1 name=serial1
/routing ospf instance
add disabled=no domain-id="" name=ospf-instance-10 out-filter-chain="" \
    router-id=10.10.10.9 routing-table=main
/routing ospf area
add disabled=no instance=ospf-instance-10 name=Area0
/interface bridge port
add bridge=bridge1 interface=ether1
/interface bridge vlan
# vlan999 not a bridge port
add bridge=bridge1 tagged=bridge1,ether1,vlan999 vlan-ids=999
# vlan10 not a bridge port
add bridge=bridge1 tagged=bridge1,ether1,vlan10 vlan-ids=10
# vlan11 not a bridge port
add bridge=bridge1 tagged=bridge1,ether1,vlan11 vlan-ids=11
/ip address
add address=197.168.9.2/30 interface=ether2 network=197.168.9.0
add address=192.168.0.1/24 interface=vlan10 network=192.168.0.0
add address=192.168.1.1/24 interface=vlan11 network=192.168.1.0
add address=192.168.99.1/28 interface=vlan999 network=192.168.99.0
add address=10.0.12.2/30 interface=Tunnel-0 network=10.0.12.0
add address=10.10.10.9 comment=Router-ID interface=lo network=10.10.10.0
/ip dhcp-client
# DHCP client can not run on slave or passthrough interface!
add interface=ether1
/ip dhcp-server network
add address=192.168.0.0/24 dns-server=9.9.9.9 domain=Norway.com gateway=\
    192.168.0.1 netmask=24
add address=192.168.1.0/24 dns-server=9.9.9.9 domain=Norway.com gateway=\
    192.168.1.1 netmask=24
/ip firewall filter
add action=drop chain=forward comment="'Block MGMT For Internet\"" \
    out-interface=ether2 src-address=192.168.99.0/28
add action=drop chain=forward comment="Block ICMP" dst-address=\
    192.168.99.0/28 protocol=!icmp src-address=0.0.0.0
add action=drop chain=forward dst-address=0.0.0.0 protocol=icmp src-address=\
    !192.168.99.0/28
/ip firewall mangle
add action=accept chain=forward out-interface=Tunnel-0 protocol=tcp \
    tcp-flags=syn tcp-mss=1360-65535
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether2 src-address=\
    !192.168.99.0/28
/ip ipsec identity
add my-id=address:197.168.9.2 peer=cisco_policy1
/ip ipsec policy
add dst-address=196.127.86.2/32 peer=cisco_policy1 proposal=compay_pro \
    src-address=197.168.9.2/32
/ip route
add check-gateway=ping disabled=no distance=1 dst-address=0.0.0.0/0 gateway=\
    197.168.9.1 routing-table=main suppress-hw-offload=no
/routing ospf interface-template
add area=Area0 disabled=no interfaces=Tunnel-0 networks=10.0.12.0/30 type=ptp
add area=Area0 disabled=no interfaces=vlan10,vlan11 networks=\
    192.168.0.0/24,192.168.1.0/24 passive type=ptp
/system note
