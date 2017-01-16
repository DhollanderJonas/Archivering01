# Enterprise Linux Lab Report

- Student name: Jonas D'hollander
- Github repo: <https://github.com/HoGentTIN/elnx-DhollanderJonas.git>


CloneZilla

## Requirements

- Create image from the dual-boot and redistribute physical
- Automating restoring process

## Test plan

Check if the dual-boot image works properly on the destination hosts physical

## Documentation

- Solved the connection problem 

The DRBL server didn't function properly as dns-server, used the `journalctl` command to determine this

Reconfigured the DRBL server, dns problem was solved

- Connected Jonas' laptop (functions as the DRBL server) to the switch which in turn is connected to 3 hosts (pcs in room 4.038)

The speed wasn't optimal (2Gb/s) vs 10 Gb/s when using the virtualized hosts

Examined the cables and switch, all lights were green, however the laptop uses a transformer (ethernet to usb) which limits transferring speed.

Replaced laptops, created a new DRBL server on Dries' laptop (has a direct ethernet port)

Speed increases to ~9Gb/s

Uploading the dual-boot image to three hosts at the same time lowers the speed to ~500Kb/s

Examined cables and switch again, deducted the problem had to do with the NIC of one of the hosts. Used a different NIC, speed increased again to ~9Gb/s

- Restoring starts automatically because of correct parameters in config file


## Test report

- The dual-boot image (a personally created one, not one being used in room 4.038) is created and distributed to the destination hosts on the physical machine with minimal input

## Resources

http://clonezilla.org/