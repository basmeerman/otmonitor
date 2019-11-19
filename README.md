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
* otmonitor in /opt/otmonitor
* otmonitor configfile /opt/otmonitor/otmonitor.conf
* make sure to chmod 755 otmonitor and build.sh
* make sure to have ./kit/runtime symbolic link to ./kit/tclkit
* make sure to install otmonitor as a system service 
** copy ./initd/otmonitor to /etc/init.d/
** chmod 755 /etc/init.d/otmonitor
** sudo update-rc.d otmonitor defaults
** sudo reboot
** verify working systemctl status otmonitor

## Hardware
* OTGW (http://otgw.tclcode.com/otmonsrc.html)
* 20V 3A Powersupply for OTGW (https://www.nodo-shop.nl/nl/voedingen/201-universele-voeding-9-24v.html)
* TTL-USB (https://www.electrodragon.com/product/usb-ttl-serial-ch340-board/)
* Raspberry Pi Zero W (https://www.raspberrypi.org/pi-zero-w/)
* 5V 1A Powersupply for Raspberry Pi (generic)
* 3Pcs DuPont Jumper Cable connecting GND, RTX, TRX between TTL-USB and OTGW FTDI interface
