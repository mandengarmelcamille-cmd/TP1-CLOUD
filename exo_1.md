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
PS C:\Program Files\Terraform> terraform init
Initializing the backend...
Initializing provider plugins...
- Reusing previous version of hashicorp/azurerm from the dependency lock file
- Using previously-installed hashicorp/azurerm v4.43.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

PS C:\Program Files\Terraform> terraform apply
azurerm_resource_group.main: Refreshing state... [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/LEGENDE]
azurerm_virtual_network.main: Refreshing state... [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/LEGENDE/providers/Microsoft.Network/virtualNetworks/vm-vnet]
azurerm_subnet.main: Refreshing state... [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/LEGENDE/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet]
azurerm_network_interface.main: Refreshing state... [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/LEGENDE/providers/Microsoft.Network/networkInterfaces/vm-nic]
azurerm_linux_virtual_machine.main: Refreshing state... [id=/subscriptions/4743a650-180b-4be1-971f-f92f2fa62d0e/resourceGroups/LEGENDE/providers/Microsoft.Compute/virtualMachines/super-vm]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```