import r2pipe
import re
def write_lowest_byte(n, b):
	return n & 0xffffffffffffff00 | b
flag_begin = '34C3_'
flag = flag_begin + 'A'*(23-len(flag_begin))
r2=r2pipe.open('./morph',flags=['-2'])
r2.cmd("ood %s" % flag)
r2.cmd("aa")
source_main = r2.cmd("pdf @ main")
bp_lines = [line for line in source_main.split('\n') if "call rax" in line]
bps = [re.search(r'0x[0-9a-f]+', bp).group(0) for bp in bp_lines]
for bp in bps:
	r2.cmd('db %s'%bp)
r2.cmd("dc")
flag_bytes = []
for i in range(23):	
	code = r2.cmd("pd 4@rax")
	line = code.split('\n')[-1]
	finds = re.findall(r'0x[0-9a-f]+', line)
	cmp_b = finds[0]
	flag_byte = finds[1]
	t = (int(flag_byte,16), int(r2.cmd("dr rax"), 16))
	flag_bytes.append(t)
	r2.cmd("db %s" % cmp_b)
	r2.cmd("dc")
	address = int(r2.cmd("dr rax"), 16)
	r2.cmd("dr rax = %s" % hex(write_lowest_byte(address, int(flag_byte,16))))
	r2.cmd("dc")
flag = ''
flag_bytes = sorted(flag_bytes,key=lambda tup: tup[1])
print ''.join([chr(t[0]) for t in flag_bytes])
r2.quit()