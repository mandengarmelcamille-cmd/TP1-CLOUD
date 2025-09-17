# 🌞 Déterminer quel algorithme de chiffrement utiliser pour vos clés
## Raisons principales et source fiable qui explique pourquoi on évite RSA désormais (pour les connexions SSH notamment)
•	Le chiffrement/déchiffrement RSA est plus lent que l'ECC en raison des opérations mathématiques impliquées. (Source https://www.sslinsights.com)
•	La taille de clé recommandée par ECC est de 256 bits, contre 2 048 bits pour RSA, pour une protection comparable. Cela permet aux certificats ECC d'être plus rapides et de consommer moins de bande passante. (Source https://sslinsights.com)
•	ECC est plus adapté aux appareils à faible puissance de calcul, tels que les mobiles et les objets connectés. RSA est privilégié pour les applications nécessitant une rétrocompatibilité, comme les serveurs web. (Source https://www.sslinsights.com)
•	RSA utilise généralement des tailles de clé comprises entre 2048 et 4096 bits. Des clés plus grandes sont nécessaires pour que RSA atteigne le même niveau de sécurité que ECDSA. Par exemple, une clé RSA de 2048 bits est à peu près équivalente en termes de sécurité à une clé ECDSA de 224 bits. (Source https://www.ssl.com)
•	La méthode de création de paires de clés publiques/privées de RSA est vulnérable aux attaques par factorisation. Lors d'une telle attaque, un attaquant se fait passer pour le propriétaire d'une clé et peut obtenir la clé privée associée à la paire. Cela lui permet de déchiffrer des données sensibles et de contourner la sécurité d'un système. Il existe des moyens de compliquer cette tâche, comme l'utilisation de clés plus longues.  (Source https://www.eclypse.com)

## Une source fiable qui recommande un autre algorithme de chiffrement (pour les connexions SSH notamment)
•	ECDSA utilise généralement des tailles de clé allant de 256 à 384 bits. Malgré sa taille de clé plus petite, elle offre un niveau de sécurité équivalent à celui de clés RSA beaucoup plus grandes. Par exemple, une clé ECDSA de 256 bits offre une sécurité comparable à celle d'une clé RSA de 3072 XNUMX bits. (Source https://www.ssl.com)
•	ECDSA excelle en termes de performances, offrant une génération de clés et une création et une vérification de signature plus rapides. Son efficacité le rend idéal pour les appareils dotés d'une puissance de traitement limitée. (Source https://www.ssl.com)
•	L'algorithme ed25519 repose sur une formule spécifique pour une ellipse, contrairement à l'algorithme RSA, qui utilise des nombres premiers. Largement utilisé depuis une dizaine d'années, il est pris en charge par tous les logiciels modernes et constitue donc la norme actuelle pour la plupart des utilisateurs professionnels. Créer une clé est simple avec la commande ssh-keygen. (Source https://www.brandonchecketts.com)

# 🌞 Générer une paire de clés pour ce TP
```bash
  PS C:\Users\DELL> ssh-keygen -t ed25519
Generating public/private ed25519 key pair.
Enter file in which to save the key (C:\Users\DELL/.ssh/id_ed25519):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in C:\Users\DELL/.ssh/id_ed25519
Your public key has been saved in C:\Users\DELL/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:9/MsiW5Q+mCJCC7fv3bNFk405p89wfhnVvkzJQUKXoA dell@DESKTOP-8S6D2T8
The key's randomart image is:
+--[ED25519 256]--+
|         ...     |
|        E . . .  |
|         . o . . |
|  .       * .   .|
| . . . .SB.. o ..|
|. . . . *.+.. +.o|
| o .   . O +o= o+|
|  . . . . O =++o=|
|     ooo +.  .o=o|
  +----[SHA256]-----+
```

```bash
PS C:\Users\DELL\.ssh> ren id_ed25519 cloud_tp1
PS C:\Users\DELL\.ssh> ls
    Répertoire : C:\Users\DELL\.ssh
Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        15/09/2025     02:56            411 cloud_tp1
-a----        15/09/2025     02:56            103 id_ed25519.pub
```

# 🌞 Configurer un agent SSH sur votre poste
```bash
PS C:\Windows\system32> Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
Name  : OpenSSH.Client~~~~0.0.1.0
State : Installed
Name  : OpenSSH.Server~~~~0.0.1.0
State : NotPresent
PS C:\Windows\system32> Start-Service ssh-agent

PS C:\Users\DELL> ssh-add.exe .\.ssh\cloud_tp1
Identity added: .\.ssh\cloud_tp1 (dell@DESKTOP-8S6D2T8)
```

# 🌞 Connectez-vous en SSH à la VM pour preuve
```bash
PS C:\Users\DELL\.ssh> ssh azureuser@20.162.198.64
Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.11.0-1018-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Mon Sep 15 08:14:10 UTC 2025

  System load:  0.02              Processes:             114
  Usage of /:   5.7% of 28.02GB   Users logged in:       0
  Memory usage: 27%               IPv4 address for eth0: 172.17.0.4
  Swap usage:   0%
  ```



# 🌞 Créez une VM depuis le Azure CLI

``PS C:\Users\DELL> az vm create --size ``"Standard_B1s" -g MAITRE_MANDENG -n super_vm --image Ubuntu2204 --admin-username lemandeng --ssh-key-values C:\Users\DELL\.ssh\cloud_tp1.pub
The default value of '--size' will be changed to 'Standard_D2s_v5' from 'Standard_DS1_v2' in a future release.
{
  "fqdns": "",
  "id": "/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/MAITRE_MANDENG/providers/Microsoft.Compute/virtualMachines/super_vm",
  "location": "uksouth",
  "macAddress": "7C-ED-8D-3A-D1-58",
  "powerState": "VM running",
  "privateIpAddress": "172.16.0.5",
  "publicIpAddress": "172.167.34.241",
  "resourceGroup": "MAITRE_MANDENG" 
  ``

# 🌞 Assurez-vous que vous pouvez vous connecter à la VM en SSH sur son IP publique
```bash
PS C:\Users\DELL\.ssh> ssh lemandeng@172.167.34.241
The authenticity of host '172.167.34.241 (172.167.34.241)' can't be established.
ED25519 key fingerprint is SHA256:G/gNa7jTexZPCju6xC6JUEzeuXCpGi7yb/AM5yKbqNE.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '172.167.34.241' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.8.0-1031-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Mon Sep 15 11:58:21 UTC 2025

  System load:  0.0               Processes:             105
  Usage of /:   5.4% of 28.89GB   Users logged in:       0
  Memory usage: 28%               IPv4 address for eth0: 172.16.0.5
  Swap usage:   0%

Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

lemandeng@supervm:~$ 
```

# 🌞 Une fois connecté, prouvez la présence…

```bash
lemandeng@supervm:~$ service walinuxagent status
Warning: The unit file, source configuration file or drop-ins of walinuxagent.service changed on disk. Run 'systemctl daemon-reload' to reload units.
● walinuxagent.service - Azure Linux Agent
     Loaded: loaded (/lib/systemd/system/walinuxagent.service; enabled; vendor preset: enabled)
    Drop-In: /run/systemd/system.control/walinuxagent.service.d
             └─50-CPUAccounting.conf, 50-MemoryAccounting.conf
     Active: active (running) since Mon 2025-09-15 10:44:23 UTC; 1h 28min ago
   Main PID: 728 (python3)
      Tasks: 7 (limit: 1009)
     Memory: 44.9M
        CPU: 7.401s
     CGroup: /system.slice/walinuxagent.service
             ├─ 728 /usr/bin/python3 -u /usr/sbin/waagent -daemon
             └─1026 python3 -u bin/WALinuxAgent-2.14.0.1-py3.12.egg -run-exthandlers

Sep 15 10:49:34 supervm python3[1026]: 2025-09-15T10:49:34.028126Z INFO CollectLogsHandler ExtHandler Starting log collection...
Sep 15 10:49:48 supervm python3[1026]: 2025-09-15T10:49:48.588492Z INFO CollectLogsHandler ExtHandler Successfully collected logs. Archive size: 76219 b, elapsed time: 145>
Sep 15 10:49:48 supervm python3[1026]: 2025-09-15T10:49:48.608675Z INFO CollectLogsHandler ExtHandler Successfully uploaded logs.
Sep 15 10:59:30 supervm python3[728]: 2025-09-15T10:59:30.637136Z INFO Daemon Agent WALinuxAgent-2.14.0.1 launched with command 'python3 -u bin/WALinuxAgent-2.14.0.1-py3.1>
Sep 15 11:14:36 supervm python3[1026]: 2025-09-15T11:14:36.859686Z INFO ExtHandler ExtHandler [HEARTBEAT] Agent WALinuxAgent-2.14.0.1 is running as the goal state agent [D>
Sep 15 11:44:38 supervm python3[1026]: 2025-09-15T11:44:38.718439Z INFO ExtHandler ExtHandler Downloading agent manifest
Sep 15 11:44:38 supervm python3[1026]: 2025-09-15T11:44:38.752730Z INFO ExtHandler ExtHandler [HEARTBEAT] Agent WALinuxAgent-2.14.0.1 is running as the goal state agent [D>
Sep 15 11:49:48 supervm python3[1026]: 2025-09-15T11:49:48.666739Z INFO CollectLogsHandler ExtHandler Starting log collection...
Sep 15 11:50:03 supervm python3[1026]: 2025-09-15T11:50:03.310133Z INFO CollectLogsHandler ExtHandler Successfully collected logs. Archive size: 77540 b, elapsed time: 146>
Sep 15 11:50:03 supervm python3[1026]: 2025-09-15T11:50:03.319982Z INFO CollectLogsHandler ExtHandler Successfully uploaded logs.
lines 1-24/24 (END)
```
```bash
lemandeng@supervm:~$ cloud-init status
status: done
```

# 🌞 Utilisez Terraform pour créer une VM dans Azure 
```bash
PS C:\Program Files\Terraform> terraform apply
azurerm_resource_group.main: Refreshing state... [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING]
azurerm_virtual_network.main: Refreshing state... [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Network/virtualNetworks/vm-vnet]
azurerm_subnet.main: Refreshing state... [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_linux_virtual_machine.main will be created
  + resource "azurerm_linux_virtual_machine" "main" {
      + admin_username                                         = "MASTER"
      + allow_extension_operations                             = (known after apply)
      + bypass_platform_safety_checks_on_user_schedule_enabled = false
      + computer_name                                          = (known after apply)
      + disable_password_authentication                        = (known after apply)
      + disk_controller_type                                   = (known after apply)
      + extensions_time_budget                                 = "PT1H30M"
      + id                                                     = (known after apply)
      + location                                               = "uksouth"
      + max_bid_price                                          = -1
      + name                                                   = "super-vm"
      + network_interface_ids                                  = (known after apply)
      + os_managed_disk_id                                     = (known after apply)
      + patch_assessment_mode                                  = (known after apply)
      + patch_mode                                             = (known after apply)
      + platform_fault_domain                                  = -1
      + priority                                               = "Regular"
      + private_ip_address                                     = (known after apply)
      + private_ip_addresses                                   = (known after apply)
      + provision_vm_agent                                     = (known after apply)
      + public_ip_address                                      = (known after apply)
      + public_ip_addresses                                    = (known after apply)
      + resource_group_name                                    = "KING"
      + size                                                   = "Standard_B1s"
      + virtual_machine_id                                     = (known after apply)
      + vm_agent_platform_updates_enabled                      = (known after apply)

      + admin_ssh_key {
          + public_key = <<-EOT
                ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILsBG3cpnzS/vPQ/7TUzvVhrY0wJPx6j+YF0eq2MVx6q dell@DESKTOP-8S6D2T8
            EOT
          + username   = "MASTER"
        }

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + id                        = (known after apply)
          + name                      = "vm-os-disk"
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + source_image_reference {
          + offer     = "0001-com-ubuntu-server-focal"
          + publisher = "Canonical"
          + sku       = "20_04-lts"
          + version   = "latest"
        }

      + termination_notification (known after apply)
    }

  # azurerm_network_interface.main will be created
  + resource "azurerm_network_interface" "main" {
      + accelerated_networking_enabled = false
      + applied_dns_servers            = (known after apply)
      + id                             = (known after apply)
      + internal_domain_name_suffix    = (known after apply)
      + ip_forwarding_enabled          = false
      + location                       = "uksouth"
      + mac_address                    = (known after apply)
      + name                           = "vm-nic"
      + private_ip_address             = (known after apply)
      + private_ip_addresses           = (known after apply)
      + resource_group_name            = "KING"
      + virtual_machine_id             = (known after apply)

      + ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + name                                               = "internal"
          + primary                                            = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = "Dynamic"
          + private_ip_address_version                         = "IPv4"
          + public_ip_address_id                               = (known after apply)
          + subnet_id                                          = "/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet"
        }
    }

  # azurerm_public_ip.main will be created
  + resource "azurerm_public_ip" "main" {
      + allocation_method       = "Static"
      + ddos_protection_mode    = "VirtualNetworkInherited"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "uksouth"
      + name                    = "vm-ip"
      + resource_group_name     = "KING"
      + sku                     = "Standard"
      + sku_tier                = "Regional"
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_public_ip.main: Creating...
azurerm_public_ip.main: Creation complete after 4s [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Network/publicIPAddresses/vm-ip]
azurerm_network_interface.main: Creating...
azurerm_network_interface.main: Creation complete after 3s [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Network/networkInterfaces/vm-nic]
azurerm_linux_virtual_machine.main: Creating...
azurerm_linux_virtual_machine.main: Still creating... [00m10s elapsed]
azurerm_linux_virtual_machine.main: Creation complete after 13s [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Compute/virtualMachines/super-vm]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

# 🌞 Ajouter un NSG à votre déploiement Terraform
```bash

# Network Security Group
resource "azurerm_network_security_group" "main" {
  name                = "nsg-main"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# Règle SSH dans le NSG
resource "azurerm_network_security_rule" "ssh" {
  name                        = "SSH"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name
}

# Associer le NSG au Subnet
resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}
```

# 🌞 Prouver que ça fonctionne, rendu attendu
```bash
PS C:\Program Files\Terraform> terraform apply
azurerm_resource_group.main: Refreshing state... [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING]
azurerm_public_ip.main: Refreshing state... [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Network/publicIPAddresses/vm-ip]
azurerm_virtual_network.main: Refreshing state... [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Network/virtualNetworks/vm-vnet]
azurerm_subnet.main: Refreshing state... [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet]
azurerm_network_interface.main: Refreshing state... [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Network/networkInterfaces/vm-nic]
azurerm_linux_virtual_machine.main: Refreshing state... [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Compute/virtualMachines/super-vm]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  ## azurerm_network_security_group.main will be created
  + resource "azurerm_network_security_group" "main" {
      + id                  = (known after apply)
      + location            = "uksouth"
      + name                = "nsg-main"
      + resource_group_name = "KING"
      + security_rule       = (known after apply)
    }

  ## azurerm_network_security_rule.ssh will be created
  + resource "azurerm_network_security_rule" "ssh" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_range      = "22"
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "SSH"
      + network_security_group_name = "nsg-main"
      + priority                    = 1001
      + protocol                    = "Tcp"
      + resource_group_name         = "KING"
      + source_address_prefix       = "*"
      + source_port_range           = "*"
    }

  ## azurerm_subnet_network_security_group_association.main will be created
  + resource "azurerm_subnet_network_security_group_association" "main" {
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = "/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet"
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_network_security_group.main: Creating...
azurerm_network_security_group.main: Creation complete after 3s [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Network/networkSecurityGroups/nsg-main]
azurerm_subnet_network_security_group_association.main: Creating...
azurerm_network_security_rule.ssh: Creating...
azurerm_network_security_rule.ssh: Creation complete after 2s [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Network/networkSecurityGroups/nsg-main/securityRules/SSH]
azurerm_subnet_network_security_group_association.main: Creation complete after 7s [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

### une commande az pour obtenir toutes les infos liées à la VM
````bash
PS C:\Program Files\Terraform> az vm show  --resource-group KING  --name super-vm
{
  "additionalCapabilities": null,
  "applicationProfile": null,
  "availabilitySet": null,
  "billingProfile": null,
  "capacityReservation": null,
  "diagnosticsProfile": {
    "bootDiagnostics": {
      "enabled": false,
      "storageUri": null
    }
  },
  "etag": "\"1\"",
  "evictionPolicy": null,
  "extendedLocation": null,
  "extensionsTimeBudget": "PT1H30M",
  "hardwareProfile": {
    "vmSize": "Standard_B1s",
    "vmSizeProperties": null
  },
  "host": null,
  "hostGroup": null,
  "id": "/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Compute/virtualMachines/super-vm",
  "identity": null,
  "instanceView": null,
  "licenseType": null,
  "location": "uksouth",
  "managedBy": null,
  "name": "super-vm",
  "networkProfile": {
    "networkApiVersion": null,
    "networkInterfaceConfigurations": null,
    "networkInterfaces": [
      {
        "deleteOption": null,
        "id": "/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Network/networkInterfaces/vm-nic",
        "primary": true,
        "resourceGroup": "KING"
      }
    ]
  },
  "osProfile": {
    "adminPassword": null,
    "adminUsername": "MASTER",
    "allowExtensionOperations": true,
    "computerName": "super-vm",
    "customData": null,
    "linuxConfiguration": {
      "disablePasswordAuthentication": true,
      "enableVmAgentPlatformUpdates": null,
      "patchSettings": {
        "assessmentMode": "ImageDefault",
        "automaticByPlatformSettings": null,
        "patchMode": "ImageDefault"
      },
      "provisionVmAgent": true,
      "ssh": {
        "publicKeys": [
          {
            "keyData": "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILsBG3cpnzS/vPQ/7TUzvVhrY0wJPx6j+YF0eq2MVx6q dell@DESKTOP-8S6D2T8\r\n",
            "path": "/home/MASTER/.ssh/authorized_keys"
          }
        ]
      }
    },
    "requireGuestProvisionSignal": true,
    "secrets": [],
    "windowsConfiguration": null
  },
  "placement": null,
  "plan": null,
  "platformFaultDomain": null,
  "priority": "Regular",
  "provisioningState": "Succeeded",
  "proximityPlacementGroup": null,
  "resourceGroup": "KING",
  "resources": null,
  "scheduledEventsPolicy": null,
  "scheduledEventsProfile": null,
  "securityProfile": null,
  "storageProfile": {
    "alignRegionalDisksToVmZone": null,
    "dataDisks": [],
    "diskControllerType": null,
    "imageReference": {
      "communityGalleryImageId": null,
      "exactVersion": "20.04.202505200",
      "id": null,
      "offer": "0001-com-ubuntu-server-focal",
      "publisher": "Canonical",
      "sharedGalleryImageId": null,
      "sku": "20_04-lts",
      "version": "latest"
    },
    "osDisk": {
      "caching": "ReadWrite",
      "createOption": "FromImage",
      "deleteOption": "Detach",
      "diffDiskSettings": null,
      "diskSizeGb": 30,
      "encryptionSettings": null,
      "image": null,
      "managedDisk": {
        "diskEncryptionSet": null,
        "id": "/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/KING/providers/Microsoft.Compute/disks/vm-os-disk",
        "resourceGroup": "KING",
        "securityProfile": null,
        "storageAccountType": "Standard_LRS"
      },
      "name": "vm-os-disk",
      "osType": "Linux",
      "vhd": null,
      "writeAcceleratorEnabled": false
    }
  },
  "tags": {},
  "timeCreated": "2025-09-16T13:00:23.890969+00:00",
  "type": "Microsoft.Compute/virtualMachines",
  "userData": null,
  "virtualMachineScaleSet": null,
  "vmId": "548c0016-ce14-4bfc-a835-0b540795a8df",
  "zones": null
}
````
### une commande ssh fonctionnelle vers l'IP publique de la VM
````Bash
PS C:\Program Files\Terraform> ssh MASTER@51.142.195.23
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-1089-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Sep 17 08:54:59 UTC 2025

  System load:  0.1               Processes:             110
  Usage of /:   5.9% of 28.89GB   Users logged in:       0
  Memory usage: 31%               IPv4 address for eth0: 10.0.1.4
  Swap usage:   0%

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

MASTER@super-vm:~$
````
### modifiez le port d'écoute du serveur OpenSSH sur la VM pour le port 2222/tcp
```bash
Include /etc/ssh/sshd_config.d/*.conf

#Port 2222
#AddressFamily any
#ListenAddress 0.0.0.0
#ListenAddress ::

#HostKey /etc/ssh/ssh_host_rsa_key
#HostKey /etc/ssh/ssh_host_ecdsa_key
#HostKey /etc/ssh/ssh_host_ed25519_key

# Ciphers and keying
#RekeyLimit default none

# Logging
#SyslogFacility AUTH
#LogLevel INFO
```
### prouvez que le serveur OpenSSH écoute sur ce nouveau port (avec une commande ss sur la VM)
```bash
MASTER@super-vm:~$ sudo ss -tlnp | grep sshd
LISTEN    0         128                0.0.0.0:2222             0.0.0.0:*        users:(("sshd",pid=19066,fd=3))
LISTEN    0         128                   [::]:2222                [::]:*        users:(("sshd",pid=19066,fd=4))
````

### prouvez qu'une nouvelle connexion sur ce port 2222/tcp ne fonctionne pas à cause du NSG
```bash
PS C:\Program Files\Terraform> ssh -i C:\Users\DELL\.ssh\cloud_tp1 -p 2222 MASTER@51.142.195.23
kex_exchange_identification: Connection closed by remote host
Connection closed by 51.142.195.23 port 2222
PS C:\Program Files\Terraform>
```
