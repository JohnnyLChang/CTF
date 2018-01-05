#34C3 - morph

The commands I used in radare2 to this were the following:
```
ood argv1 # starts the binary with argv1
pdf @ main # disassembles the main function
db # setting breakpoints
dc # continue
pd 4@rax # to disassemble the first 4 instructions before call rax
dr # show register values
dr rax # show a specific value of a register in this case rax
dr rax = 0x1 # modifies the value of rax in this case to 0x1
```