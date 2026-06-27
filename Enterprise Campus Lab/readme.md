# Enterprise Campus Lab

## Objectives

- Configure VLANs
- Configure Trunk Links
- Configure DTP
- Configure VTP
- Configure LACP EtherChannel
- Configure PAgP EtherChannel
- Configure Static EtherChannel
- Configure Rapid-PVST
- Configure PortFast
- Configure BPDU Guard
- Verify Connectivity

## VLAN Plan

| VLAN | Name | Network |
|------|------|---------|
| 10 | Management | 192.168.10.0/24 |
| 20 | Engineering | 192.168.20.0/24 |
| 30 | Sales | 192.168.30.0/24 |
| 40 | CCTV | 192.168.40.0/24 |
| 50 | Guest | 192.168.50.0/24 |

## EtherChannel

| Port-Channel | Protocol | Interfaces |
|--------------|----------|------------|
| Po1 | LACP | e0/0 - e0/1 | e0/3-e0/1
| Po2 | PAgP | e0/2 - e1/0 | e0/0-e0/1
| Po3 | Static | e1/1 - e1/2 | e0/0-e0/1

## Configuration

- Core-SW
- Access-SW1
- Access-SW2
- Access-SW3

## Verification

```bash
show vlan brief
show interfaces trunk
show etherchannel summary
show spanning-tree
show vtp status
```
