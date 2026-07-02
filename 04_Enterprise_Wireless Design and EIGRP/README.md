# Advanced Enterprise Network Simulation Lab

This repository features a highly available, scalable, and secure enterprise network topology integrating Layer 2 redundancy, Layer 3 routing, and granular traffic filtering.

## 📌 Network Topology
![Enterprise Wireless and EIGRP Topology](Enterprise%20Wireless%20and%20EIGRP%20Topology.png)

---

## 🛠️ Implemented Technologies & Protocols

### 1. Layer 2 Infrastructure & Redundancy
* **VLANs & Trunking:** Broadcast domain separation and 802.1Q trunking across Access and Core/Distribution layers.
* **Layer 3 EtherChannel (LACP):** Implemented between core switches (`CoreSw1` <-> `CoreSw2` via **Port-Channel 10**) to increase bandwidth and guarantee routing redundancy. If the primary links (e.g., `e2/0`) go down, EIGRP neighbor adjacency seamlessly fails over to **Port-Channel 10**.
* **Layer 2 EtherChannel:** Deployed between `CoreSw1` <-> `Access_Sw` and `CoreSw2` <-> `Access_Sw` for redundant access-layer uplinks.
* **Spanning Tree Protocol (Rapid PVST+):** Optimizes per-VLAN load balancing and guarantees a loop-free Layer 2 environment.

### 2. First Hop Redundancy Protocols (FHRP)
* **HSRP (Hot Standby Router Protocol):** Active/Standby gateway redundancy deployed in the Left Segment (**VLAN 10 - 14**) for seamless infrastructure failover.

### 3. Layer 3 Routing & EIGRP Optimization
* **EIGRP Dynamic Routing:** Implemented for fast convergence across the enterprise core network.
* **Query Packet Reduction & Summarization:** Optimized to prevent **Stuck-In-Active (SIA)** states using:
  * **Route Summarization** at the Distribution/Core layer boundaries to reduce routing table overhead.
  * **EIGRP Stub Routing** at edge/spoke nodes to strictly restrict query propagation.

### 4. Device Management & Hardening (Enterprise Style)
* **Secure Management:** Configured secure **SSH** access and **SNMP** monitoring across all network elements.
* **Infrastructure Access Control Lists (ACLs):** Granular ACL policies applied to secure and control access to the management plane and infrastructure devices.

---

## 🔬 Verification & Testing
To verify EIGRP packet behavior (Hello, ACK, Update, Query, Reply) and summarization efficiency, use the following Cisco IOS commands:

```bash
# Check EIGRP neighbor adjacencies
show ip eigrp neighbors

# Verify EIGRP traffic statistics and monitor Query/Reply packets
show ip eigrp traffic

# View the EIGRP topology table for Successors and Feasible Successors
show ip eigrp topology

# Verify EtherChannel status and bundle interfaces
show etherchannel summary
