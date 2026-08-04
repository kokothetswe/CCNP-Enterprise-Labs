# Enterprise Multihomed BGP Network Lab

![CCNP Enterprise](https://img.shields.io/badge/CCNP%20Enterprise-BGP-blue)
![BGP](https://img.shields.io/badge/Protocol-BGP-green)
![eBGP](https://img.shields.io/badge/BGP-eBGP-orange)
![iBGP](https://img.shields.io/badge/BGP-iBGP-purple)
![Lab](https://img.shields.io/badge/Type-Network%20Lab-lightgrey)

## 📌 Lab Overview

This lab demonstrates an **Enterprise Multihomed BGP Network** where
**AS-100** connects to two external Autonomous Systems (**AS-500** and
**AS-600**) using eBGP.

Inside AS-100, routers run **classic iBGP in a full-mesh topology**.

The lab is designed to practice BGP configuration, route propagation,
redundancy, and troubleshooting in an enterprise environment.

---

## 🌐 Topology

!https://github.com/kokothetswe/CCNP-Enterprise-Labs/blob/kokothetswe-patch-1-1/05_Enterprise_BGP_Multihome_lab/Enterprise%20Mulithome%20BGP2026.png

### Autonomous Systems

| AS | Router(s) | Role |
|---|---|---|
| AS-100 | R1, R2, R3, R4 | Enterprise Network |
| AS-500 | R5 | External ISP |
| AS-600 | R6 | External ISP |

---

## 🔗 Network Design

### AS-100 – Internal BGP

AS-100 uses **classic iBGP full-mesh**:

```text
             R2
            /  \
           /    \
         R1------R4
          \      /
           \    /
             R3
iBGP sessions:
R1 ↔ R2
R1 ↔ R3
R1 ↔ R4
R2 ↔ R3
R2 ↔ R4
R3 ↔ R4


              AS-500
                 |
                 |
              R1 AS-100
                 |
              AS-100
                 |
              R4 AS-100
                 |
                 |
              AS-600
| Link        | Network     | Prefix | Description     |
| ----------- | ----------- | ------ | --------------- |
| R1 – R2     | 10.0.12.0   | /30    | AS-100 Internal |
| R1 – R3     | 10.0.13.0   | /30    | AS-100 Internal |
| R3 – R4     | 10.0.14.0   | /30    | AS-100 Internal |
| R2 – R4     | 10.0.15.0   | /30    | AS-100 Internal |
| R1 – R5     | 10.0.15.0   | /24    | AS-500 Link 1   |
| R1 – R5     | 10.0.51.0   | /24    | AS-500 Link 2   |
| R4 – R6     | 10.0.46.0   | /24    | AS-600 Link     |
| R5 Loopback | 192.168.5.0 | /24    | AS-500 LAN      |
| R6 Loopback | 192.168.6.0 | /24    | AS-600 LAN      |
**Lab Objectives**
Configure eBGP between AS-100 and AS-500
Configure eBGP between AS-100 and AS-600
Configure classic iBGP full-mesh inside AS-100
Configure BGP update-source
Configure next-hop-self
Configure BGP authentication
Configure eBGP multihop
Configure static routing / OSPF as required
Verify BGP route propagation
Verify end-to-end reachability
Understand eBGP vs iBGP behavior
Test redundancy and failover
Technologies Covered
BGP
eBGP
iBGP
iBGP Full-Mesh
eBGP Multihop
Update-Source
Next-Hop-Self
BGP Authentication (Neighbor Authentication)
Static Routing
OSPF
Route Advertisement
Route Propagation
BGP Troubleshooting
🔐 BGP Authentication

BGP neighbor authentication is configured using an MD5-based TCP
authentication mechanism.

Example:

router bgp 100
 neighbor <PEER-IP> remote-as <REMOTE-AS>
 neighbor <PEER-IP> password <PASSWORD>
🔍 Verification

**Useful Cisco IOS commands:**

show ip bgp summary
show ip bgp
show ip bgp neighbors
show ip route bgp
show ip route
show running-config | section router bgp

**Check BGP Neighbor Status**
R1# show ip bgp summary
**Check Learned Routes**
R1# show ip bgp
