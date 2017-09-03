mappings = { 0x00:"A",  0x01:"S",  0x02:"D", 0x03:"F", 0x04:"H", 0x05:"G", 0x06:"Z",  0x07:"X", 0x08:"C",  0x09:"V", 0x0B:"B", 0x0C:"Q", 0x0D:"W", 0x0E:"E", 0x0F:"R",  0x10:"Y", 0x11:"T", 0x12:"1", 0x13:"2", 0x14:"3", 0x15:"4",0x16:"6", 0x17:"5", 0x1A:"7", 0x28:"K", 0x20:"U", 0x2F:",", 0x21: "(", 0x18:"=", 0x22:"I", 0x30:"\t", 0x23:"P", 0x2E:"M", 0x25:"L", 0x26:"J", 0x2D:"N", 0x1C:"8"}
nums = []
keys = open('task.txt')
output = ""
for line in keys:
    #if line[0]!='0' or line[1]!='0' or line[3]!='0' or line[4]!='0' or line[9]!='0' or line[10]!='0' or line[12]!='0' or line[13]!='0' or line[15]!='0' or line[16]!='0' or line[18]!='0' or line[19]!='0' or line[21]!='0' or line[22]!='0':
    #     continue
    caps = int(line[0:2],16)
    n = int(line[6:8],16)
    if n in mappings:
        if n != 0:
            output += mappings[n]
    elif n == 82 or n == 81:
        output += ''
    elif n != 0:
        output += '('+'{:02X}'.format(n)+')'
keys.close()
print 'output :\n' + output
