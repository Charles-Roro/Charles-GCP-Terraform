This was a fun Lab that I did for GCP using Terraform!

A European gaming company is moving to GCP.  It has the following requirements in it's first stage migration to the Cloud:

A) I choose a region in Europe to host it's prototype gaming information.  This page must only be on a RFC 1918 Private 10 net and can't be accessible from the Internet.
B) The Americas must have 2 regions and both must be RFC 1918 172.16 based subnets.  They can peer with HQ in order to view the homepage however, they can only view the page on port 80.
C) Asia Pacific region must be choosen and it must be a RFC 1918 192.168 based subnet.  This subnet can only VPN into HQ.  Additionally, only port 3389 is open to Asia. No 80, no 22.


It was really fun getting all of this up and Running!
