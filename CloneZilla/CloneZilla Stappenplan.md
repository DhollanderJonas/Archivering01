#Stappenplan en info document voor de installatie/gebruik CloneZilla

Authors: Jonas D'hollander & Dries Boone

##Initiële installatie

**OPGELET: om de DRBL server te kunnen gebruiken moet de SELinux aangepast worden*

Edit de SELlinux file met een teksteditor zodat `SELINUX=disabled` is.

Gebruik het toegevoegde script in `/Scripts/Install DRBL CloneZilla` om de DRBL server te installeren. Voer het script uit met sudo rechten.

ga naar `tftpboot/nbi_img/pxelinux.cfg/default` en edit de 2 labels op volgende manier:

![labels](https://github.com/HoGentTIN/elnx-cd-DhollanderJonas/blob/master/CloneZilla/Images/labels.PNG)

**De Firewall regels worden overschreven tijdens de installatie** de oude firewall regels worden echter opgeslagen als `iptables.drblsave` in `etc/sysconfig` of `etc/default`


##Cloning/Restoring

Eenmaal de installatie volledig afgerond is, start de designated hosts op en gebruik `F12` om naar het boot up menu te gaan. Selecteer de NIC en vervolgens de functie die je wenst.
