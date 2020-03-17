# otmonitor
Monitor tool for the OTGW (http://otgw.tclcode.com/)

Build instructions: http://otgw.tclcode.com/otmonsrc.html

## Deployment scenario
* OTGW (see Hardware)
* Connected through TTL-USB
* OTMonitor running on Raspberry PI Zero W (Headless)
* OTMonitor publishes to MQTT (that I consume with OpenHAB MQTT Binding)

## Environment settings
* running Raspian headless
* sudo apt-get update
* sudo apt-get install -y git
* sudo git clone https://github.com/basmeerman/otmonitor.git /opt/otmonitor
  * make sure to chmod 755 otmonitor and build.sh
  * make sure to have ./kit/runtime symbolic link to ./kit/tclkit
* build otmonitor by executing sudo ./build.sh
* manually create otmonitor configfile /opt/otmonitor/otmonitor.conf
* make sure to install otmonitor as a system service 
  * sudo cp ./initd/otmonitor /etc/init.d/
  * sudo chmod 755 /etc/init.d/otmonitor
  * sudo update-rc.d otmonitor defaults  
  * sudo reboot
  * verify working systemctl status otmonitor
* extra create MOTD
  * sudo nano /etc/motd remove all lines and add "Device: Opentherm Gateway" save and exit
  * sudo nano sudo nano /etc/update-motd.d/80-overlay
    ``` 
    #!/bin/sh
    str=$(mount | grep ' on / ')
    if echo $str | grep -q 'overlay'; then
       printf "\n------ INFO: / MOUNTED WITH OVERLAY ------\n\n"
    elif echo $str | grep -q 'rw'; then
       printf "\n++++++ INFO: / MOUNTED READ-WRITE ++++++\n\n"
    else
       printf "\n!!!!!! WARNING: / UNKNOWN STATE !!!!!!\n\n"
    fi
    ```
  * sudo chmod 755 /etc/update-motd.d/80-overlay
* extra backup
  * sudo mkdir /backup
  * sudo nano /root/.smbcredentials and add credentials for SMB share access
  * sudo /etc/fstab and add mountpoint to SMB share   
    ```
    //192.168.100.99/NeuralHomeBackups/BackupRPIOpenThermGateway /backup cifs credentials=/root/.smbcredentials 0 0 comment=systemd.automount
    ```
  * sudo mount -a
  * curl -sSLO https://www.linux-tips-and-tricks.de/raspiBackupInstallUI.sh && sudo bash ./raspiBackupInstallUI.sh 
  * configure backup in menu
* extra readonly filesystem
  * sudo raspi-config
  * under Advanced enable Overlay FS
  * save / close / reboot
* test http://<ipaddress>:8080
   

## Hardware
* OTGW (http://otgw.tclcode.com/otmonsrc.html)
* 20V 3A Powersupply for OTGW (https://www.nodo-shop.nl/nl/voedingen/201-universele-voeding-9-24v.html)
* TTL-USB (https://www.electrodragon.com/product/usb-ttl-serial-ch340-board/)
* Raspberry Pi Zero W (https://www.raspberrypi.org/pi-zero-w/)
* 5V 1A Powersupply for Raspberry Pi (generic)
* 3Pcs DuPont Jumper Cable connecting GND, RTX, TRX between TTL-USB and OTGW FTDI interface
