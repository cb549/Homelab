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

## Network Topology

### WAN Switch
![WAN 
Diagram](https://github.com/cb549/Homelab/raw/main/ESXi/Diagrams/vSwitch0.png)

### LAN Switch
![LAN](https://github.com/cb549/Homelab/raw/main/ESXi/Diagrams/LAN.png)

# Networking Overview

## PFSense

PFSense virtual machine acts as the lab gateway, WAN interface goes to home network LAN interface shares 
ESXi vSwitch port group with the rest of the VMs. LAN interface is set as the gateway for all other VMs in the LAN. All traffic must pass through PFSense to access outside networks.

## Raspberry Pi Access Point

Raspberry Pi 4 running the latest verstion of Raspbian is configured as a WiFi access point in bridge mode and connected to the ESXi LAN via a USB to Ethernet adapter.

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

## Domain Controller
- CPU: 2 vCPUs
- Memory: 4 GB
- Storage: 40 GB
- Network Interfaces: LAN

## Workstation
- CPU: 2 vCPUs
- Memory: 4 GB
- Storage: 40 GB
- Network Interfaces: LAN

# Physical Machines
## Raspberry Pi 4

## Dell Inspiron Laptop
