# extractKeystrokes.py
import dpkt
import struct
import sys

pcap = dpkt.pcap.Reader(open(sys.argv[1], 'rb'))

ktab = {}

ktab.update({
    i + 0x4: chr(i + ord('a'))
    for i in range(26)
})

ktab.update({
    i + 0x1e: chr(i + ord('1'))
    for i in range(9)
})

ktab.update({
    0x27: '0', 0x28: '\C-m',

    0x2c: ' ', 0x2d: '_', 0x2e: '=', 0x2f: '{', 0x30: '}', 0x31: '\\',
    0x32: '#', 0x33: ';', 0x34: "'", 0x35: "~", 0x36: ",", 0x37: ".",

    0x4F: '\C-[OC',  # Right
    0x50: '\C-[OD',  # Left
    0x51: '\C-[OB',  # Down
    0x52: '\C-[OA',  # Up

    0x54: '/', 0x55: '*', 0x56: '-',
})
sys.stdout.write('(setq last-kbd-macro "')
for ts, buf in pcap:
    if len(buf) < 0x1B:
        continue
    transferType, = struct.unpack('<B', buf[0x16])
    dataLength, = struct.unpack('<I', buf[0x17:0x1B])
    if (dataLength == 8) and (transferType == 1):
        q, = struct.unpack('<B', buf[0x1D])
        if q:
            if (q in ktab):
                sys.stdout.write(ktab[q])
            else:
                sys.stdout.write("?" + `q` + "?")

sys.stdout.write('")')