
# PNetLab Enterprise Multicast Routing Architecture Lab

A comprehensive enterprise network lab demonstrating **Protocol Independent Multicast - Dense Mode (PIM-DM)** over an **OSPF Multi-Area** core infrastructure on PNetLab.

---

##  Topology Overview

- **Source (Server VM):** Windows 7 (`192.168.1.10/24`) — Streaming via VLC Player
- **VLAN_Sw (Source Switch):** VLAN 99 mapping (Access Ports)
- **Edge1 (R1):** Source-facing Edge Router (`192.168.1.1`)
- **Transit_Router:** Core Routing Node (OSPF Area 0 / Area 1 boundary)
- **Edge2 (R2):** Client-facing Edge Router (`192.168.2.1`)
- **VLAN_Sw (Client Switch):** VLAN 100 mapping
- **Client VM:** Windows 7 (`192.168.2.10/24`) — Multicast Receiver

---

## Key Configurations

### 1. Unicast Routing (OSPF Multi-Area)
Inter-area reachability is configured between Edge1, Transit Router, and Edge2 to ensure complete unicast convergence.

### 2. Multicast Enablement (PIM-DM)
Global multicast routing is enabled on all routers, and PIM Dense Mode is applied to all participating interfaces.

```text
! On Edge1, Transit_Router, and Edge2
ip multicast-routing
!
interface Ethernet0/0
 ip pim dense-mode
!
interface Ethernet0/1
 ip pim dense-mode
