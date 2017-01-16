# Enterprise Linux Lab Report

- Student name: Jonas D'hollander
- Github repo: <https://github.com/HoGentTIN/elnx-DhollanderJonas.git>


CloneZilla

## Requirements

- Create image from the dual-boot and redistribute physical

- Use "Golden image"

## Test plan

Check if the dual-boot image ("golden image" works properly on the destination hosts physical

## Documentation

- Recreated the physical environment from last time but added the "golden image" host

- Started creating image

Returned an error, not enough space

Removed previous images to create more space

Same error when trying to copy the image again

Tried adding a second disk (250 Gb) to the vm to store the image -> was found under `/dev/sdb`. Problem when trying to mount the new disk, incompatibility with the guest additions.

Decided to create new server with 300 Gb free space

Established that the image would be around 500Gb rendering the new server useless

## Test report

- Golden image is too large for VM. Cannot import. Implementation will have to be done using the actual server in room 4.037

## Resources

http://clonezilla.org/

https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1003940

https://www.cyberciti.biz/tips/vmware-add-a-new-hard-disk-without-rebooting-guest.html

https://howtobi.wordpress.com/2010/10/30/adding-a-additional-hard-disk-in%C2%A0virtualbox/

http://www.vitalsofttech.com/add-disk-storage-to-oracle-virtualbox-with-linux/