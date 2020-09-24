#!/bin/bash

# Update for your admin password
username=neophilex
AdminPassword=Password-333
myRG=tempRG
mylocation=westeurope
myimage=Debian

# Create a resource group.
az group create --name $myRG --location $mylocation

# Create a virtual network.
az network vnet create --resource-group $myRG --name myVnet --subnet-name mySubnet

# Create a public IP address.
az network public-ip create --resource-group $myRG --name myPublicIP

# Create a network security group.
az network nsg create --resource-group $myRG --name myNetworkSecurityGroup

# Create a virtual network card and associate with public IP address and NSG.
az network nic create \
  --resource-group $myRG \
  --name myNic \
  --vnet-name myVnet \
  --subnet mySubnet \
  --network-security-group myNetworkSecurityGroup \
  --public-ip-address myPublicIP

# Create a virtual machine. 
az vm create \
    --resource-group $myRG \
    --name myVM \
    --location $mylocation \
    --nics myNic \
    --image $myimage \
    --admin-username $username \
    --admin-password $AdminPassword

# Open port 3389 to allow RDP traffic to host.
az vm open-port --port 22 --resource-group $myRG --name myVM

