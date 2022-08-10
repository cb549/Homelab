# Networking Overview

## PFSense

PFSense virtual machine acts as the lab gateway, WAN interface goes to home network LAN interface shares 
ESXi vSwitch port group with the rest of the VMs. LAN interface is set as the gateway for all other VMs in the LAN. All traffic must pass through PFSense to access outside networks.

## Raspberry Pi Access Point

Raspberry Pi 4 running the latest verstion of Raspbian is configured as a WiFi access point in bridge mode and connected to the ESXi LAN via a USB to Ethernet adapter.
