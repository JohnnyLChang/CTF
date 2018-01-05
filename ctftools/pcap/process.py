from scapy.all import *
from scapy.utils import *
from hexdump import *

packets = rdpcap('net.pcap')

#print packets.summary()

for packet in packets:
    if packet.getlayer(Raw):
        print '[+] Found Raw' + '\n'
        l = packet.getlayer(Raw).load
        print hexdump(l)

print "finished"
