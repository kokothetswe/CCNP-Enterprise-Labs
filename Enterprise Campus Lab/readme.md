
Objectives

✔ Configure VLANs
✔ Configure Trunk Links
✔ Configure DTP
✔ Configure VTP
✔ Configure LACP EtherChannel
✔ Configure PAgP EtherChannel
✔ Configure Static EtherChannel
✔ Configure Rapid-PVST
✔ Configure PortFast
✔ Configure BPDU Guard
✔ Verify Connectivity Each Vlan
VLAN ID,VLAN Name,Department / Purpose,IP Network Range,Default Gateway
10,Management,Management Dpt & Switches,192.168.10.0/24,192.168.10.1
20,Engineering,Engineering Dpt,192.168.20.0/24,192.168.20.1
30,Sales,Sale Dpt,192.168.30.0/24,192.168.30.1
40,CCTV,CCTV Dpt (IP Cameras),192.168.40.0/24,192.168.40.1
50,Guest_WIFI,Guest Network,192.168.50.0/24,192.168.50.1
Port-Channel ID,Protocol,Connected Devices,Active Interfaces,Description
Po1,LACP (Link Aggregation),Core-SW <---> Access-Switch1,"e0/1, e0/3",Dynamic Negotiation (Active/Passive)
Po2,PAgP (Cisco Proprietary),Core-SW <---> Access-Switch2,"e0/2, e1/0",Cisco Dynamic Bundle (Desirable/Auto)
Po3,Static (On Mode),Core-SW <---> Access-Switch3,"e1/2, e1/1",Unconditional EtherChannel Block
## Configuration
-Core-Sw
- Access-SW1
- Access-SW2
- Access-SW3

## Verification
show vlan brief
show interfaces trunk
show etherchannel summary
show spanning-tree
show vtp status
