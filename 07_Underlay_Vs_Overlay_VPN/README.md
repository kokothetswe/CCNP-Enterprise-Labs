<div align="center">

# 🌐 Lab 07: Underlay vs. Overlay Network Architecture 
### Enterprise Multi-Vendor WAN Transport & Secure GRE/IPsec Tunneling
<div align="center">


![Cisco](https://img.shields.io/badge/Cisco-175DDC?style=for-the-badge&logo=cisco&logoColor=white)
![MikroTik](https://img.shields.io/badge/MikroTik-222222?style=for-the-badge&logo=mikrotik&logoColor=white)
![IPsec](https://img.shields.io/badge/VPN-GRE%20over%20IPsec-red?style=for-the-badge)
![Status](https://img.shields.io/badge/Lab%20Status-Completed-success?style=for-the-badge)

</div>

---

</div>

---
## 📌 1. Project Overview

This lab demonstrates the practical design and execution of **Underlay Transport Routing** versus an **Overlay VPN Topology** in an enterprise multi-vendor network environment (**Cisco IOS & MikroTik RouterOS**).

- **Underlay Network:** Serves as the backbone WAN infrastructure connecting two ISPs (**AS1090 Telenor** & **AS13340 Singtel**). Routing reachability is established using **eBGP**, **OSPF**, and **Default Static Routes**.
- **Overlay Network:** A virtual, secure **GRE Tunnel protected by IPsec** built across the untrusted public underlay to directly connect private LAN subnets across sites.
- **Inter-VLAN Routing:** Implemented via **Router-on-a-Stick** architecture on both endpoints.

---
## 📐 2. Network Topology

<div align="center">
  <img src="./topology.png" alt="Lab Topology" width="850"/>https://raw.githubusercontent.com/kokothetswe/CCNP-Enterprise-Labs/refs/heads/kokothetswe-patch-1-1/07_Underlay_Vs_Overlay_VPN/GERoverIPSEC.png
</div>

---
## ⚖️ 3. Underlay vs Overlay Architecture Comparison

| Feature / Dimension | Underlay Network | Overlay Network |
| :--- | :--- | :--- |
| **Primary Goal** | Physical WAN transport & End-to-End IP Reachability | Secure Enterprise LAN Segmentation & Encrypted Inter-Site Traffic |
| **Network Layer** | Physical Interfaces & Provider Infrastructure | Logical Tunnel Interfaces (`Tunnel0`, `gre-tunnel1`) |
| **Routing Protocols** | BGP (AS1090, AS13340), OSPF, Default Route | Static / Dynamic Overlay Routing |
| **IP Addressing** | Public Transit Subnets (`197.168.9.0/30`, `196.127.86.0/30`) | Private Subnets (`192.168.0.0/24`, `10.0.0.0/24`) |
| **Security Level** | Unencrypted Transit Path | IPsec Encrypted (AES-256 / SHA-256) |

---
## 📋 4. Detailed IP Addressing & Subnet Table

### 🇲🇲 Co,Ltd Site (MikroTik RouterOS + Sw5)
| Device | Interface | IP Address | Subnet Mask / CIDR | VLAN / ID | Description / Role |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Norway-Mikrotik** | eth2 | `197.168.9.2` | `255.255.255.252` (/30) | N/A | WAN Interface to Telenor ISP |
| | eth1.10 | `192.168.0.1` | `255.255.255.0` (/24) | VLAN 10 | Gateway for Sales/Users |
| | eth1.11 | `192.168.1.1` | `255.255.255.0` (/24) | VLAN 11 | Gateway for Staff/Internal |
| | eth1.999 | `192.168.99.1` | `255.255.255.240` (/28) | VLAN 999 | Gateway for Native/MGMT |
| **Sw5 Switch** | e0/0 | Unassigned | N/A | Trunk Port | Trunk Link to MikroTik (Native VLAN 999) |
| | e0/2 | Unassigned | N/A | VLAN 10 | Access Port for PC1 |
| | e0/3 | Unassigned | N/A | VLAN 11 | Access Port for PC_Vlan11 |
| | e0/1 | Unassigned | N/A | VLAN 999 | Access Port for MGMT PC |
| **Pc1** | e0/0 | `192.168.0.10` | `255.255.255.0` (/24) | VLAN 10 | Host in VLAN 10 |
| **PC_Vlan11** | eth0 | `192.168.1.10` | `255.255.255.0` (/24) | VLAN 11 | Host in VLAN 11 |
| **MGMT PC** | e0 | `192.168.99.10` | `255.255.255.240` (/28) | VLAN 999 | Host in MGMT Network |

### 🇸🇬 Singapore Site (Cisco IOS Router + Sw6)
| Device | Interface | IP Address | Subnet Mask / CIDR | VLAN / ID | Description / Role |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Singapore Cisco** | e0/0 | `196.127.86.2` | `255.255.255.252` (/30) | N/A | WAN Interface to Singtel ISP |
| | e0/1.20 | `10.0.0.1` | `255.255.255.0` (/24) | VLAN 20 | Sub-interface Gateway (VLAN 20) |
| **Overlay Tunnel** | Tunnel0 | `200.17.78.100` | `255.255.255.252` (/30) | Overlay | Point-to-Point GRE Tunnel Endpoint |
| **Pc9** | eth0 | `10.0.0.10` | `255.255.255.0` (/24) | VLAN 20 | Host in Singapore Local LAN |

---
## ⚙️ 5. Key Technical Implementations

- **Dual-AS Service Provider Core:** Simulates internet transport with BGP Peering (**AS1090 Telenor** $\leftrightarrow$ **AS13340 Singtel**).
- **Router-on-a-Stick (ROAS):** Sub-interfaces configured on WAN Edge Routers to perform Inter-VLAN Routing for local subnets.
- **Native & Management VLAN Standard:** **VLAN 999** is explicitly designated for management isolation and native untagged traffic on Trunk ports.
- **Cross-Vendor IPsec Security:** Standardized AES-256/SHA-256 proposal parameters ensuring compatibility between Cisco IOS and MikroTik RouterOS.
---
## 🧪 6. Verification Commands
<details>
<summary>👉 <b>Cisco Router Verification (Singapore)</b></summary>

```bash
# Verify BGP Peerings with Singtel ISP
Singapore# show ip bgp summary

# Verify Tunnel Interface and IPsec Status
Singapore# show interface Tunnel0
Singapore# show crypto ipsec sa
Singapore# show crypto session
<div align="center">

# 🌐 Lab 07: Underlay vs. Overlay Network Architecture
### Enterprise Multi-Vendor WAN Transport & Secure GRE/IPsec Tunneling

![Cisco](https://img.shields.io/badge/Cisco-175DDC?style=for-the-badge&logo=cisco&logoColor=white)
![MikroTik](https://img.shields.io/badge/MikroTik-222222?style=for-the-badge&logo=mikrotik&logoColor=white)
![IPsec](https://img.shields.io/badge/VPN-GRE%20over%20IPsec-red?style=for-the-badge)
![Status](https://img.shields.io/badge/Lab%20Status-Completed-success?style=for-the-badge)

</div>
---
## 📌 1. Project Overview

This lab demonstrates the practical design and execution of **Underlay Transport Routing** versus an **Overlay VPN Topology** in an enterprise multi-vendor network environment (**Cisco IOS & MikroTik RouterOS**).

- **Underlay Network:** Serves as the backbone WAN infrastructure connecting two ISPs (**AS1090 Telenor** & **AS13340 Singtel**). Routing reachability is established using **eBGP**, **OSPF**, and **Default Static Routes**.
- **Overlay Network:** A virtual, secure **GRE Tunnel protected by IPsec** built across the untrusted public underlay to directly connect private LAN subnets across sites.
- **Inter-VLAN Routing:** Implemented via **Router-on-a-Stick** architecture on both endpoints.

---
## 📐 2. Network Topology

<div align="center">
  <img src="./topology.png" alt="Lab Topology" width="850"/>
</div>

---

## ⚖️ 3. Underlay vs Overlay Architecture Comparison

| Feature / Dimension | Underlay Network | Overlay Network |
| :--- | :--- | :--- |
| **Primary Goal** | Physical WAN transport & End-to-End IP Reachability | Secure Enterprise LAN Segmentation & Encrypted Inter-Site Traffic |
| **Network Layer** | Physical Interfaces & Provider Infrastructure | Logical Tunnel Interfaces (`Tunnel0`, `gre-tunnel1`) |
| **Routing Protocols** | BGP (AS1090, AS13340), OSPF, Default Route | Static / Dynamic Overlay Routing |
| **IP Addressing** | Public Transit Subnets (`197.168.9.0/30`, `196.127.86.0/30`) | Private Subnets (`192.168.0.0/24`, `10.0.0.0/24`) |
| **Security Level** | Unencrypted Transit Path | IPsec Encrypted (AES-256 / SHA-256) |

---

## 📋 4. Detailed IP Addressing & Subnet Table

### 🇲🇲 Co,Ltd Site (MikroTik RouterOS + Sw5)
| Device | Interface | IP Address | Subnet Mask / CIDR | VLAN / ID | Description / Role |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Norway-Mikrotik** | eth2 | `197.168.9.2` | `255.255.255.252` (/30) | N/A | WAN Interface to Telenor ISP |
| | eth1.10 | `192.168.0.1` | `255.255.255.0` (/24) | VLAN 10 | Gateway for Sales/Users |
| | eth1.11 | `192.168.1.1` | `255.255.255.0` (/24) | VLAN 11 | Gateway for Staff/Internal |
| | eth1.999 | `192.168.99.1` | `255.255.255.240` (/28) | VLAN 999 | Gateway for Native/MGMT |
| **Sw5 Switch** | e0/0 | Unassigned | N/A | Trunk Port | Trunk Link to MikroTik (Native VLAN 999) |
| | e0/2 | Unassigned | N/A | VLAN 10 | Access Port for PC1 |
| | e0/3 | Unassigned | N/A | VLAN 11 | Access Port for PC_Vlan11 |
| | e0/1 | Unassigned | N/A | VLAN 999 | Access Port for MGMT PC |
| **Pc1** | e0/0 | `192.168.0.10` | `255.255.255.0` (/24) | VLAN 10 | Host in VLAN 10 |
| **PC_Vlan11** | eth0 | `192.168.1.10` | `255.255.255.0` (/24) | VLAN 11 | Host in VLAN 11 |
| **MGMT PC** | e0 | `192.168.99.10` | `255.255.255.240` (/28) | VLAN 999 | Host in MGMT Network |

### 🇸🇬 Singapore Site (Cisco IOS Router + Sw6)
| Device | Interface | IP Address | Subnet Mask / CIDR | VLAN / ID | Description / Role |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Singapore Cisco** | e0/0 | `196.127.86.2` | `255.255.255.252` (/30) | N/A | WAN Interface to Singtel ISP |
| | e0/1.20 | `10.0.0.1` | `255.255.255.0` (/24) | VLAN 20 | Sub-interface Gateway (VLAN 20) |
| **Overlay Tunnel** | Tunnel0 | `200.17.78.100` | `255.255.255.252` (/30) | Overlay | Point-to-Point GRE Tunnel Endpoint |
| **Pc9** | eth0 | `10.0.0.10` | `255.255.255.0` (/24) | VLAN 20 | Host in Singapore Local LAN |

---

## ⚙️ 5. Key Technical Implementations

- **Dual-AS Service Provider Core:** Simulates internet transport with BGP Peering (**AS1090 Telenor** $\leftrightarrow$ **AS13340 Singtel**).
- **Router-on-a-Stick (ROAS):** Sub-interfaces configured on WAN Edge Routers to perform Inter-VLAN Routing for local subnets.
- **Native & Management VLAN Standard:** **VLAN 999** is explicitly designated for management isolation and native untagged traffic on Trunk ports.
- **Cross-Vendor IPsec Security:** Standardized AES-256/SHA-256 proposal parameters ensuring compatibility between Cisco IOS and MikroTik RouterOS.

---

## 🧪 6. Verification Commands

<details>
<summary>👉 <b>Cisco Router Verification (Singapore)</b></summary>

```bash
# Verify BGP Peerings with Singtel ISP
Singapore# show ip bgp summary

# Verify Tunnel Interface and IPsec Status
Singapore# show interface Tunnel0
Singapore# show crypto ipsec sa
Singapore# show crypto session
<div align="center">

# 🌐 Lab 07: Underlay vs. Overlay Network Architecture
### Enterprise Multi-Vendor WAN Transport & Secure GRE/IPsec Tunneling

![Cisco](https://img.shields.io/badge/Cisco-175DDC?style=for-the-badge&logo=cisco&logoColor=white)
![MikroTik](https://img.shields.io/badge/MikroTik-222222?style=for-the-badge&logo=mikrotik&logoColor=white)
![IPsec](https://img.shields.io/badge/VPN-GRE%20over%20IPsec-red?style=for-the-badge)
![Status](https://img.shields.io/badge/Lab%20Status-Completed-success?style=for-the-badge)

</div>

---

## 📌 1. Project Overview

This lab demonstrates the practical design and execution of **Underlay Transport Routing** versus an **Overlay VPN Topology** in an enterprise multi-vendor network environment (**Cisco IOS & MikroTik RouterOS**).

- **Underlay Network:** Serves as the backbone WAN infrastructure connecting two ISPs (**AS1090 Telenor** & **AS13340 Singtel**). Routing reachability is established using **eBGP**, **OSPF**, and **Default Static Routes**.
- **Overlay Network:** A virtual, secure **GRE Tunnel protected by IPsec** built across the untrusted public underlay to directly connect private LAN subnets across sites.
- **Inter-VLAN Routing:** Implemented via **Router-on-a-Stick** architecture on both endpoints.

---

## 📐 2. Network Topology

<div align="center">
  <img src="./topology.png" alt="Lab Topology" width="850"/>
</div>

---

## ⚖️ 3. Underlay vs Overlay Architecture Comparison

| Feature / Dimension | Underlay Network | Overlay Network |
| :--- | :--- | :--- |
| **Primary Goal** | Physical WAN transport & End-to-End IP Reachability | Secure Enterprise LAN Segmentation & Encrypted Inter-Site Traffic |
| **Network Layer** | Physical Interfaces & Provider Infrastructure | Logical Tunnel Interfaces (`Tunnel0`, `gre-tunnel1`) |
| **Routing Protocols** | BGP (AS1090, AS13340), OSPF, Default Route | Static / Dynamic Overlay Routing |
| **IP Addressing** | Public Transit Subnets (`197.168.9.0/30`, `196.127.86.0/30`) | Private Subnets (`192.168.0.0/24`, `10.0.0.0/24`) |
| **Security Level** | Unencrypted Transit Path | IPsec Encrypted (AES-256 / SHA-256) |

---

## 📋 4. Detailed IP Addressing & Subnet Table

### 🇲🇲 Co,Ltd Site (MikroTik RouterOS + Sw5)
| Device | Interface | IP Address | Subnet Mask / CIDR | VLAN / ID | Description / Role |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **-Mikrotik** | eth2 | `197.168.9.2` | `255.255.255.252` (/30) | N/A | WAN Interface to Telenor ISP |
| | eth1.10 | `192.168.0.1` | `255.255.255.0` (/24) | VLAN 10 | Gateway for Sales/Users |
| | eth1.11 | `192.168.1.1` | `255.255.255.0` (/24) | VLAN 11 | Gateway for Staff/Internal |
| | eth1.999 | `192.168.99.1` | `255.255.255.240` (/28) | VLAN 999 | Gateway for Native/MGMT |
| **Sw5 Switch** | e0/0 | Unassigned | N/A | Trunk Port | Trunk Link to MikroTik (Native VLAN 999) |
| | e0/2 | Unassigned | N/A | VLAN 10 | Access Port for PC1 |
| | e0/3 | Unassigned | N/A | VLAN 11 | Access Port for PC_Vlan11 |
| | e0/1 | Unassigned | N/A | VLAN 999 | Access Port for MGMT PC |
| **Pc1** | e0/0 | `192.168.0.10` | `255.255.255.0` (/24) | VLAN 10 | Host in VLAN 10 |
| **PC_Vlan11** | eth0 | `192.168.1.10` | `255.255.255.0` (/24) | VLAN 11 | Host in VLAN 11 |
| **MGMT PC** | e0 | `192.168.99.10` | `255.255.255.240` (/28) | VLAN 999 | Host in MGMT Network |

### 🇸🇬 Singapore Site (Cisco IOS Router + Sw6)
| Device | Interface | IP Address | Subnet Mask / CIDR | VLAN / ID | Description / Role |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Singapore Cisco** | e0/0 | `196.127.86.2` | `255.255.255.252` (/30) | N/A | WAN Interface to Singtel ISP |
| | e0/1.20 | `10.0.0.1` | `255.255.255.0` (/24) | VLAN 20 | Sub-interface Gateway (VLAN 20) |
| **Overlay Tunnel** | Tunnel0 | `200.17.78.100` | `255.255.255.252` (/30) | Overlay | Point-to-Point GRE Tunnel Endpoint |
| **Pc9** | eth0 | `10.0.0.10` | `255.255.255.0` (/24) | VLAN 20 | Host in Singapore Local LAN |

---

## ⚙️ 5. Key Technical Implementations

- **Dual-AS Service Provider Core:** Simulates internet transport with BGP Peering (**AS1090 Telenor** $\leftrightarrow$ **AS13340 Singtel**).
- **Router-on-a-Stick (ROAS):** Sub-interfaces configured on WAN Edge Routers to perform Inter-VLAN Routing for local subnets.
- **Native & Management VLAN Standard:** **VLAN 999** is explicitly designated for management isolation and native untagged traffic on Trunk ports.
- **Cross-Vendor IPsec Security:** Standardized AES-256/SHA-256 proposal parameters ensuring compatibility between Cisco IOS and MikroTik RouterOS.

---

## 🧪 6. Verification Commands

<details>
<summary>👉 <b>Cisco Router Verification (Singapore)</b></summary>

```bash
# Verify BGP Peerings with Singtel ISP
Singapore# show ip bgp summary

# Verify Tunnel Interface and IPsec Status
Singapore# show interface Tunnel0
Singapore# show crypto ipsec sa
Singapore# show crypto session
<div align="center">

# 🌐 Lab 07: Underlay vs. Overlay Network Architecture
### Enterprise Multi-Vendor WAN Transport & Secure GRE/IPsec Tunneling

![Cisco](https://img.shields.io/badge/Cisco-175DDC?style=for-the-badge&logo=cisco&logoColor=white)
![MikroTik](https://img.shields.io/badge/MikroTik-222222?style=for-the-badge&logo=mikrotik&logoColor=white)
![IPsec](https://img.shields.io/badge/VPN-GRE%20over%20IPsec-red?style=for-the-badge)
![Status](https://img.shields.io/badge/Lab%20Status-Completed-success?style=for-the-badge)

</div>

---

## 📌 1. Project Overview

This lab demonstrates the practical design and execution of **Underlay Transport Routing** versus an **Overlay VPN Topology** in an enterprise multi-vendor network environment (**Cisco IOS & MikroTik RouterOS**).

- **Underlay Network:** Serves as the backbone WAN infrastructure connecting two ISPs (**AS1090 Telenor** & **AS13340 Singtel**). Routing reachability is established using **eBGP**, **OSPF**, and **Default Static Routes**.
- **Overlay Network:** A virtual, secure **GRE Tunnel protected by IPsec** built across the untrusted public underlay to directly connect private LAN subnets across sites.
- **Inter-VLAN Routing:** Implemented via **Router-on-a-Stick** architecture on both endpoints.

---

## 📐 2. Network Topology

<div align="center">
  <img src="./topology.png" alt="Lab Topology" width="850"/>
</div>

---

## ⚖️ 3. Underlay vs Overlay Architecture Comparison

| Feature / Dimension | Underlay Network | Overlay Network |
| :--- | :--- | :--- |
| **Primary Goal** | Physical WAN transport & End-to-End IP Reachability | Secure Enterprise LAN Segmentation & Encrypted Inter-Site Traffic |
| **Network Layer** | Physical Interfaces & Provider Infrastructure | Logical Tunnel Interfaces (`Tunnel0`, `gre-tunnel1`) |
| **Routing Protocols** | BGP (AS1090, AS13340), OSPF, Default Route | Static / Dynamic Overlay Routing |
| **IP Addressing** | Public Transit Subnets (`197.168.9.0/30`, `196.127.86.0/30`) | Private Subnets (`192.168.0.0/24`'192.168.1.0/24 , `10.0.0.0/24`) |
| **Security Level** | Unencrypted Transit Path | IPsec Encrypted (AES-256 / SHA-256) |

---

## 📋 4. Detailed IP Addressing & Subnet Table

### 🇲🇲 Co,Ltd Site (MikroTik RouterOS + Sw5)
| Device | Interface | IP Address | Subnet Mask / CIDR | VLAN / ID | Description / Role |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **-Mikrotik** | eth2 | `197.168.9.2` | `255.255.255.252` (/30) | N/A | WAN Interface to Telenor ISP |
| | eth1.10 | `192.168.0.1` | `255.255.255.0` (/24) | VLAN 10 | Gateway for Sales/Users |
| | eth1.11 | `192.168.1.1` | `255.255.255.0` (/24) | VLAN 11 | Gateway for Staff/Internal |
| | eth1.999 | `192.168.99.1` | `255.255.255.240` (/28) | VLAN 999 | Gateway for Native/MGMT |
| **Sw5 Switch** | e0/0 | Unassigned | N/A | Trunk Port | Trunk Link to MikroTik (Native VLAN 999) |
| | e0/2 | Unassigned | N/A | VLAN 10 | Access Port for PC1 |
| | e0/3 | Unassigned | N/A | VLAN 11 | Access Port for PC_Vlan11 |
| | e0/1 | Unassigned | N/A | VLAN 999 | Access Port for MGMT PC |
| **Pc1** | e0/0 | `192.168.0.10` | `255.255.255.0` (/24) | VLAN 10 | Host in VLAN 10 |
| **PC_Vlan11** | eth0 | `192.168.1.10` | `255.255.255.0` (/24) | VLAN 11 | Host in VLAN 11 |
| **MGMT PC** | e0 | `192.168.99.10` | `255.255.255.240` (/28) | VLAN 999 | Host in MGMT Network |

### 🇸🇬 Singapore Site (Cisco IOS Router + Sw6)
| Device | Interface | IP Address | Subnet Mask / CIDR | VLAN / ID | Description / Role |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Singapore Cisco** | e0/0 | `196.127.86.2` | `255.255.255.252` (/30) | N/A | WAN Interface to Singtel ISP |
| | e0/1.20 | `10.0.0.1` | `255.255.255.0` (/24) | VLAN 20 | Sub-interface Gateway (VLAN 20) |
| **Overlay Tunnel** | Tunnel0 | `200.17.78.100` | `255.255.255.252` (/30) | Overlay | Point-to-Point GRE Tunnel Endpoint |
| **Pc9** | eth0 | `10.0.0.10` | `255.255.255.0` (/24) | VLAN 20 | Host in Singapore Local LAN |

---

## ⚙️ 5. Key Technical Implementations

- **Dual-AS Service Provider Core:** Simulates internet transport with BGP Peering (**AS1090 Telenor** $\leftrightarrow$ **AS13340 Singtel**).
- **Router-on-a-Stick (ROAS):** Sub-interfaces configured on WAN Edge Routers to perform Inter-VLAN Routing for local subnets.
- **Native & Management VLAN Standard:** **VLAN 999** is explicitly designated for management isolation and native untagged traffic on Trunk ports.
- **Cross-Vendor IPsec Security:** Standardized AES-256/SHA-256 proposal parameters ensuring compatibility between Cisco IOS and MikroTik RouterOS.

---

## 🧪 6. Verification Commands

<details>
<summary>👉 <b>Cisco Router Verification (Singapore)</b></summary>

```bash
# Verify BGP Peerings with Singtel ISP
Singapore# show ip bgp summary

# Verify Tunnel Interface and IPsec Status
Singapore# show interface Tunnel0
Singapore# show crypto ipsec sa
Singapore# show crypto session
