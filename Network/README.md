# Networking Overview

PFSense gateway, WAN interface goes to home network LAN interface shares 
ESXi vSwitch port group with the rest of the VMs. LAN interface is set as the gateway for all other VMs in the LAN. All traffic must pass through PFSense to access outside
