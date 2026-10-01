# LAN to LAN Reachability & Wireshark Packet Analysis

## 1. Network Scenario & Target
* **Source:** LAN 10 (Singapore Site - 192.168.0.x)
* **Destination:** LAN 20 (Norway Site - 192.168.1.x)
* **Encapsulation:** GRE over IPsec Tunnel

---

## 2. Ping Test Output

### Ping from LAN 20 PC to LAN 11 PC

Pc9> sh ip 

NAME        : Pc9[1]
IP/MASK     : 10.0.0.11/24
GATEWAY     : 10.0.0.1
DNS         : 9.9.9.9  
DHCP SERVER : 10.0.0.1
DHCP LEASE  : 71713, 86400/43200/75600
DOMAIN NAME : Singapore
MAC         : 00:50:79:66:68:06
LPORT       : 20000
RHOST:PORT  : 127.0.0.1:30000
MTU         : 1500



C:\> ping 192.168.1.253 -src 10.0.0.11

Pinging 192.168.1.10 with 32 bytes of data:
Reply from 192.168.1.253: bytes=32 time=45ms TTL=126
Reply from 192.168.1.253: bytes=32 time=42ms TTL=126
Reply from 192.168.1.253: bytes=32 time=40ms TTL=126

Ping statistics for 192.168.1.253:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
    
