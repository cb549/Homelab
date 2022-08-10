# Homelab
Documentation for my personal learning homelab

# ESXi Overview

## Software
ESXi Version 7.3

## Hardware
- HP Elitedesk 800 G2
	- CPU: Intel i5 6500T
	- Memory: 32 GB SODIMM RAM
	- Storage: 1 TB SATA SSD
	- Networking: Intel Gigabit Ethernet PCIe Adapter, StarTech USB 3.0 to Gigabit Ethernet Adapter

# Networking Overview

## Virtual Network Topology

### WAN Switch
![WAN Diagram](https://github.com/cb549/Homelab/raw/main/ESXi/Diagrams/vSwitch0.png)

### LAN Switch
![LAN Diagram](https://github.com/cb549/Homelab/raw/main/ESXi/Diagrams/LAN.png)
LAN Monitoring port group is configured in promiscuous mode to allow Security Onion to sniff network traffic.

## PFSense

PFSense virtual machine acts as the lab gateway. The WAN interface goes to the home network. The LAN interface shares the LAN
ESXi vSwitch port group with the rest of the VMs. The LAN interface is set as the gateway for all other VMs in the LAN. This is the only route into or out of the lab. 

## Raspberry Pi Access Point

Raspberry Pi 4 running the latest verstion of Raspbian is configured as a WiFi access point in bridge mode and connected to the ESXi LAN via a USB to Ethernet (vusb0) adapter.

# Virtual Macines
## PFSense
- CPU: 1 vCPU
- Memory: 1 GB
- Storage: 10 GB
- Network Interfaces: WAN, LAN 

## Security Onion
- CPU: 4 vCPUs
- Memory: 12 GB
- Storage: 300 GB
- Network Interfaces: Management, Monitoring

## CentOS
- CPU: 2 vCPUs
- Memory: 4 GB
- Storage: 100 GB
- Network Interfaces: LAN

## Domain Controller (Windows Server 2019)
- CPU: 2 vCPUs
- Memory: 4 GB
- Storage: 40 GB
- Network Interfaces: LAN

## Workstation (Windows 10 Pro)
- CPU: 2 vCPUs
- Memory: 4 GB
- Storage: 40 GB
- Network Interfaces: LAN

# Physical Machines (Raspbian)
## Raspberry Pi 4

## Dell Inspiron Laptop (Windows 10 Home)
