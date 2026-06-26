# CCNP Enterprise: Layer 2 - VLAN Segmentation Lab

## 1. Lab Scenario & Design
This lab demonstrates Local VLAN Segmentation using a single multilayer/layer 2 switch and three host PCs. The primary objective is to verify that hosts in the same VLAN can communicate, while hosts in different VLANs are isolated at Layer 2.

* **VLAN 10:** (Management)
* **VLAN 20:** PC-2 (Engineering)
* **VLAN 30:** PC-3 (Sales)
* **VLAN 30:** PC-1 (Sales)
---

## 2. IP Addressing & VLAN Mapping 

| Device Name | Interface | IP Address | Subnet Mask | VLAN ID | VLAN Name | Mode |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| PC-1 | Switch E0/0 | 192.168.20.1 | 255.255.255.0 | 20 | Engineering | Access |
| PC-2 | Switch E0/1 | 192.168.30.1 | 255.255.255.0 | 30 | Sales | Access |
| PC-3 | Switch E0/2 | 192.168.30.10 | 255.255.255.0 | 30 | Sales | Access |

---

## 3. Switch CLI Configuration

Below is the verified CLI configuration from the Switch to initialize VLANs and assign access ports:

```con
! 1. Create VLANs
Switch# configure terminal
Switch(config)# vlan 10
Switch(config-vlan)# name Management
Switch(config-vlan)# vlan 20
Switch(config-vlan)# name Engineering
Switch(config-vlan)# vlan 30
Switch(config-vlan)# name Sales
Switch(config-vlan)# exit

! 2. Assign Interfaces to respective VLANs as Access Ports
Switch(config)# interface ethernet 0/0
Switch(config-if)# switchport mode access
Switch(config-if)# switchport access vlan 20
Switch(config-if)# exit

Switch(config)# interface ethernet 0/1
Switch(config-if)# switchport mode access
Switch(config-if)# switchport access vlan 30
Switch(config-if)# exit

Switch(config)# interface ethernet 0/2
Switch(config-if)# switchport mode access
Switch(config-if)# switchport access vlan 30
Switch(config-if)# end
Switch# write memory (do write)
Lab Observations:

​Intra-VLAN Traffic (Success): Hosts inside VLAN 30 can successfully ping each other because they belong to the same broadcast domain and subnet.

​Inter-VLAN Traffic (Isolated): Traffic from VLAN 10 to VLAN 20/30 drops immediately at the switch level. This proves that Layer 2 isolation is working as intended, providing security and traffic containment without a Layer 3 routing device.
