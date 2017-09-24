
import re

with open('cap.pcap', 'rb') as f:
	data = f.read()

	
arr = re.findall(r'&x=([0-9a-f]+)', data)
value = []
for x in arr:
	if len(x) % 2 == 0:
		value.append(x)
	else:
		value.append(x[:-1])
		
with open('flag.bmp', 'wb') as f:
	f.write(''.join(value).decode('hex'))