# Advanced Enterprise Network Simulation Lab

This repository features a highly available, scalable, and secure enterprise network topology integrating Layer 2 redundancy, Layer 3 routing, and granular traffic filtering.

## 📌 Network Topology
![Enterprise Wireless and EIGRP Topology](Enterprise%20Wireless%20and%20EIGRP%20Topology.png)

---

## 🛠️ Implemented Technologies & Protocols

### 1. Layer 2 Infrastructure & Redundancy
* **VLANs & Trunking:** Broadcast domain separation and 802.1Q trunking across Access and Distribution layers.
* **EtherChannel (LACP):** Link aggregation between Core switches (`CoreSw1` <-> `CoreSw2` via **Port-Channel 10**) to increase bandwidth and ensure link redundancy.
* **Spanning Tree Protocol (Rapid PVST+):** Optimizes per-VLAN load balancing and guarantees a loop-free Layer 2 environment.

### 2. First Hop Redundancy Protocols (FHRP)
* **HSRP (Hot Standby Router Protocol):** Active/Standby gateway redundancy deployed in the Left Segment (**VLAN 10 - 14**) for seamless failover.

### 3. Layer 3 Routing & EIGRP Optimization
* **EIGRP Dynamic Routing:** Implemented for fast convergence across the enterprise core.
* **Query Packet Reduction & Summarization:** Optimized to prevent **Stuck-In-Active (SIA)** states using:
  * **Route Summarization** at the Distribution/Core layer boundaries.
  * **EIGRP Stub Routing** at edge/spoke nodes to restrict query propagation.

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


