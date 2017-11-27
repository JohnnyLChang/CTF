define unknowprint 
b *0x0401F20
r 567890_hijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234
set $i = 0
   while($i<56)
     p/x $eax
     c
     set $i = $i+1 
   end
end
