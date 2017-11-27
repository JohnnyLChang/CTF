https://github.com/volatilityfoundation/volatility/wiki/Command-Reference

vola -f memory.vmem imageinfo

```
johnny:help_500$ vola -f memory.vmem imageinfo
Volatility Foundation Volatility Framework 2.6
INFO    : volatility.debug    : Determining profile based on KDBG search...
          Suggested Profile(s) : Win7SP1x86_23418, Win7SP0x86, Win7SP1x86
                     AS Layer1 : IA32PagedMemoryPae (Kernel AS)
                     AS Layer2 : FileAddressSpace (/media/sd128/sdcard/ctf/ctfs/kaspersky2017/forensics/help_500/memory.vmem)
                      PAE type : PAE
                           DTB : 0x185000L
                          KDBG : 0x82961be8L
          Number of Processors : 1
     Image Type (Service Pack) : 0
                KPCR for CPU 0 : 0x82962c00L
             KUSER_SHARED_DATA : 0xffdf0000L
           Image date and time : 2017-09-25 12:18:53 UTC+0000
     Image local date and time : 2017-09-25 15:18:53 +0300
```

vola -f memory.vmem --profile=Win7SP1x86 pslist
```
johnny:help_500$ vola -f memory.vmem --profile=Win7SP1x86 pstree
Volatility Foundation Volatility Framework 2.6
Name                                                  Pid   PPid   Thds   Hnds Time
-------------------------------------------------- ------ ------ ------ ------ ----
 0x86aa8328:wininit.exe                               400    336      3     74 2017-09-25 12:08:15 UTC+0000
. 0x86d28558:lsm.exe                                  516    400      9    141 2017-09-25 12:08:15 UTC+0000
. 0x8cbc0030:services.exe                             500    400      7    191 2017-09-25 12:08:15 UTC+0000
.. 0x86f094f8:svchost.exe                             768    500     20    452 2017-09-25 12:08:16 UTC+0000
.. 0x870aa3b8:vmtoolsd.exe                           1684    500      9    288 2017-09-25 12:08:18 UTC+0000
... 0x85730030:cmd.exe                               1956   1684      0 ------ 2017-09-25 12:18:53 UTC+0000
.... 0x86185880:ipconfig.exe                         3096   1956      0 ------ 2017-09-25 12:18:53 UTC+0000
.. 0x86fbd500:spoolsv.exe                            1304    500     13    324 2017-09-25 12:08:17 UTC+0000
.. 0x86f42860:svchost.exe                             924    500     35    910 2017-09-25 12:08:16 UTC+0000
.. 0x86ee49d0:vmacthlp.exe                            680    500      3     53 2017-09-25 12:08:16 UTC+0000
.. 0x86da7a58:svchost.exe                             884    500     19    430 2017-09-25 12:08:16 UTC+0000
... 0x87036030:dwm.exe                               1492    884      5    113 2017-09-25 12:08:17 UTC+0000
.. 0x86fd9538:svchost.exe                            1344    500     20    307 2017-09-25 12:08:17 UTC+0000
.. 0x870ded40:msdtc.exe                              2252    500     14    154 2017-09-25 12:08:29 UTC+0000
.. 0x86c3a7b8:svchost.exe                             716    500      8    251 2017-09-25 12:08:16 UTC+0000
.. 0x86f81030:svchost.exe                            1144    500     15    369 2017-09-25 12:08:16 UTC+0000
.. 0x8722cd40:SearchIndexer.                         2008    500     12    558 2017-09-25 12:08:26 UTC+0000
.. 0x8709c6a8:VGAuthService.                         1636    500      3     87 2017-09-25 12:08:18 UTC+0000
.. 0x85085488:sppsvc.exe                             3808    500      4    151 2017-09-25 12:10:21 UTC+0000
.. 0x86dcb030:svchost.exe                             620    500     11    350 2017-09-25 12:08:15 UTC+0000
... 0x86313800:WmiPrvSE.exe                          1732    620     10    199 2017-09-25 12:08:25 UTC+0000
... 0x872a8848:WmiPrvSE.exe                          2552    620      9    219 2017-09-25 12:08:45 UTC+0000
.. 0x86f71b78:svchost.exe                            1064    500     12    560 2017-09-25 12:08:16 UTC+0000
.. 0x856aea58:svchost.exe                            3844    500     12    350 2017-09-25 12:10:21 UTC+0000
.. 0x870107a0:taskhost.exe                           1400    500      7    150 2017-09-25 12:08:17 UTC+0000
.. 0x871f1480:dllhost.exe                             852    500     15    199 2017-09-25 12:08:25 UTC+0000
. 0x86d2c188:lsass.exe                                508    400      6    538 2017-09-25 12:08:15 UTC+0000
 0x86b11d40:csrss.exe                                 348    336      8    415 2017-09-25 12:08:15 UTC+0000
. 0x8504a7d8:conhost.exe                              476    348      0 ------ 2017-09-25 12:18:53 UTC+0000
 0x8703cc48:explorer.exe                             1508   1476     24    763 2017-09-25 12:08:17 UTC+0000
. 0x87100030:vmtoolsd.exe                            1792   1508      7    198 2017-09-25 12:08:19 UTC+0000
. 0x872a9458:KeePass.exe                             2464   1508      7    304 2017-09-25 12:08:33 UTC+0000
 0x84f4a8e8:System                                      4      0     87    397 2017-09-25 12:08:14 UTC+0000
. 0x8c537930:smss.exe                                 264      4      2     29 2017-09-25 12:08:14 UTC+0000
 0x86bb5d40:csrss.exe                                 408    392     10    192 2017-09-25 12:08:15 UTC+0000
 0x86ca2920:winlogon.exe                              456    392      3    117 2017-09-25 12:08:15 UTC+0000
```

```
johnny:help_500$ vola -f memory.vmem --profile=Win7SP1x86 modules
Volatility Foundation Volatility Framework 2.6
Offset(V)  Name                 Base             Size File
---------- -------------------- ---------- ---------- ----
0x84f41c98 ntoskrnl.exe         0x82839000   0x410000 \SystemRoot\system32\ntkrnlpa.exe
0x84f41c20 hal.dll              0x82802000    0x37000 \SystemRoot\system32\halmacpi.dll
0x84f41ba0 kdcom.dll            0x80ba1000     0x8000 \SystemRoot\system32\kdcom.dll
0x84f41b20 mcupdate.dll         0x82e1c000    0x78000 \SystemRoot\system32\mcupdate_GenuineIntel.dll
0x84f41aa0 PSHED.dll            0x82e94000    0x11000 \SystemRoot\system32\PSHED.dll
0x84f41a20 BOOTVID.dll          0x82ea5000     0x8000 \SystemRoot\system32\BOOTVID.dll
0x84f419a8 CLFS.SYS             0x82ead000    0x42000 \SystemRoot\system32\CLFS.SYS
0x84f41930 CI.dll               0x82eef000    0xab000 \SystemRoot\system32\CI.dll
0x84f418b0 Wdf01000.sys         0x87818000    0x71000 \SystemRoot\system32\drivers\Wdf01000.sys
0x84f41830 WDFLDR.SYS           0x87889000     0xe000 \SystemRoot\system32\drivers\WDFLDR.SYS
0x84f417b8 ACPI.sys             0x87897000    0x48000 \SystemRoot\system32\DRIVERS\ACPI.sys
0x84f41738 WMILIB.SYS           0x878df000     0x9000 \SystemRoot\system32\DRIVERS\WMILIB.SYS
0x84f416b8 msisadrv.sys         0x878e8000     0x8000 \SystemRoot\system32\DRIVERS\msisadrv.sys
0x84f3bca8 pci.sys              0x878f0000    0x2a000 \SystemRoot\system32\DRIVERS\pci.sys
0x84f3bc28 vdrvroot.sys         0x8791a000     0xb000 \SystemRoot\system32\DRIVERS\vdrvroot.sys
0x84f3bba8 partmgr.sys          0x87925000    0x11000 \SystemRoot\System32\drivers\partmgr.sys
0x84f3bb28 compbatt.sys         0x87936000     0x8000 \SystemRoot\system32\DRIVERS\compbatt.sys
0x84f3baa8 BATTC.SYS            0x8793e000     0xb000 \SystemRoot\system32\DRIVERS\BATTC.SYS
0x84f3ba28 volmgr.sys           0x87949000    0x10000 \SystemRoot\system32\DRIVERS\volmgr.sys
0x84f3b9a8 volmgrx.sys          0x87959000    0x4b000 \SystemRoot\System32\drivers\volmgrx.sys
0x84f3b928 intelide.sys         0x879a4000     0x7000 \SystemRoot\system32\DRIVERS\intelide.sys
0x84f3b8a8 PCIIDEX.SYS          0x879ab000     0xe000 \SystemRoot\system32\DRIVERS\PCIIDEX.SYS
0x84f3b830 vmci.sys             0x879b9000    0x15000 \SystemRoot\system32\DRIVERS\vmci.sys
0x84f3b7b0 vsock.sys            0x879ce000    0x13000 \SystemRoot\system32\DRIVERS\vsock.sys
0x84f3b730 mountmgr.sys         0x879e1000    0x16000 \SystemRoot\System32\drivers\mountmgr.sys
0x84f3b6b0 atapi.sys            0x879f7000     0x9000 \SystemRoot\system32\DRIVERS\atapi.sys
0x84f3b630 ataport.SYS          0x82f9a000    0x23000 \SystemRoot\system32\DRIVERS\ataport.SYS
0x84f3b5b0 lsi_sas.sys          0x87800000    0x18000 \SystemRoot\system32\DRIVERS\lsi_sas.sys
0x84f3b530 storport.sys         0x87a0c000    0x47000 \SystemRoot\system32\DRIVERS\storport.sys
0x84f3b4b0 msahci.sys           0x87a53000     0xa000 \SystemRoot\system32\DRIVERS\msahci.sys
0x84f3b430 amdxata.sys          0x87a5d000     0x9000 \SystemRoot\system32\DRIVERS\amdxata.sys
0x84f3b3b0 fltmgr.sys           0x87a66000    0x34000 \SystemRoot\system32\drivers\fltmgr.sys
0x84f3b330 fileinfo.sys         0x87a9a000    0x11000 \SystemRoot\system32\drivers\fileinfo.sys
0x84f3b2b8 Ntfs.sys             0x87aab000   0x12f000 \SystemRoot\System32\Drivers\Ntfs.sys
0x84f3b238 msrpc.sys            0x82fbd000    0x2b000 \SystemRoot\System32\Drivers\msrpc.sys
0x84f3b1b8 ksecdd.sys           0x87bda000    0x13000 \SystemRoot\System32\Drivers\ksecdd.sys
0x84f3b140 cng.sys              0x87c0e000    0x5d000 \SystemRoot\System32\Drivers\cng.sys
0x84f3b0c8 pcw.sys              0x87c6b000     0xe000 \SystemRoot\System32\drivers\pcw.sys
0x84f3b048 Fs_Rec.sys           0x87c79000     0x9000 \SystemRoot\System32\Drivers\Fs_Rec.sys
0x84f42008 ndis.sys             0x87c82000    0xb7000 \SystemRoot\system32\drivers\ndis.sys
0x84f42f88 NETIO.SYS            0x87d39000    0x3e000 \SystemRoot\system32\drivers\NETIO.SYS
0x84f42f08 ksecpkg.sys          0x87d77000    0x25000 \SystemRoot\System32\Drivers\ksecpkg.sys
0x84f42e88 tcpip.sys            0x87e17000   0x149000 \SystemRoot\System32\drivers\tcpip.sys
0x84f42e08 fwpkclnt.sys         0x87f60000    0x31000 \SystemRoot\System32\drivers\fwpkclnt.sys
0x84f42d88 vmstorfl.sys         0x87f91000     0x9000 \SystemRoot\system32\DRIVERS\vmstorfl.sys
0x84f42d08 volsnap.sys          0x87f9a000    0x3f000 \SystemRoot\system32\DRIVERS\volsnap.sys
0x84f42c88 spldr.sys            0x87fd9000     0x8000 \SystemRoot\System32\Drivers\spldr.sys
0x84f42c08 rdyboost.sys         0x87d9c000    0x2d000 \SystemRoot\System32\drivers\rdyboost.sys
0x84f42b90 mup.sys              0x87fe1000    0x10000 \SystemRoot\System32\Drivers\mup.sys
0x84f42b10 hwpolicy.sys         0x87ff1000     0x8000 \SystemRoot\System32\drivers\hwpolicy.sys
0x84f42a90 fvevol.sys           0x87dc9000    0x32000 \SystemRoot\System32\DRIVERS\fvevol.sys
0x84f42a18 disk.sys             0x87e00000    0x11000 \SystemRoot\system32\DRIVERS\disk.sys
0x84f42998 CLASSPNP.SYS         0x8801d000    0x25000 \SystemRoot\system32\DRIVERS\CLASSPNP.SYS
0x84f42918 agp440.sys           0x88042000    0x10000 \SystemRoot\system32\DRIVERS\agp440.sys
0x86224458 cdrom.sys            0x88092000    0x1f000 \SystemRoot\system32\DRIVERS\cdrom.sys
0x86315a88 Null.SYS             0x880b1000     0x7000 \SystemRoot\System32\Drivers\Null.SYS
0x8632a130 Beep.SYS             0x880b8000     0x7000 \SystemRoot\System32\Drivers\Beep.SYS
0x863ad0b0 vmrawdsk.sys         0x880bf000     0xd000 \SystemRoot\system32\DRIVERS\vmrawdsk.sys
0x863f0008 vga.sys              0x880cc000     0xc000 \SystemRoot\System32\drivers\vga.sys
0x863d20b0 VIDEOPRT.SYS         0x880d8000    0x21000 \SystemRoot\System32\drivers\VIDEOPRT.SYS
0x872a50b0 watchdog.sys         0x880f9000     0xd000 \SystemRoot\System32\drivers\watchdog.sys
0x877220b0 RDPCDD.sys           0x88106000     0x8000 \SystemRoot\System32\DRIVERS\RDPCDD.sys
0x863730b0 rdpencdd.sys         0x8810e000     0x8000 \SystemRoot\system32\drivers\rdpencdd.sys
0x86502c80 rdprefmp.sys         0x88116000     0x8000 \SystemRoot\system32\drivers\rdprefmp.sys
0x8637bf90 Msfs.SYS             0x8811e000     0xb000 \SystemRoot\System32\Drivers\Msfs.SYS
0x86375e40 Npfs.SYS             0x88129000     0xe000 \SystemRoot\System32\Drivers\Npfs.SYS
0x863cb0b0 tdx.sys              0x88137000    0x17000 \SystemRoot\system32\DRIVERS\tdx.sys
0x872a5ee8 TDI.SYS              0x8814e000     0xb000 \SystemRoot\system32\DRIVERS\TDI.SYS
0x86340ee8 afd.sys              0x88159000    0x5a000 \SystemRoot\system32\drivers\afd.sys
0x8646f0b0 netbt.sys            0x881b3000    0x32000 \SystemRoot\System32\DRIVERS\netbt.sys
0x865170b8 ws2ifsl.sys          0x881e5000     0x9000 \SystemRoot\system32\drivers\ws2ifsl.sys
0x86432730 wfplwf.sys           0x881ee000     0x7000 \SystemRoot\system32\DRIVERS\wfplwf.sys
0x864b90d0 pacer.sys            0x8f415000    0x1f000 \SystemRoot\system32\DRIVERS\pacer.sys
0x8638b648 netbios.sys          0x8f434000     0xe000 \SystemRoot\system32\DRIVERS\netbios.sys
0x86517b60 serial.sys           0x8f442000    0x1a000 \SystemRoot\system32\DRIVERS\serial.sys
0x86939440 wanarp.sys           0x8f45c000    0x13000 \SystemRoot\system32\DRIVERS\wanarp.sys
0x865a0520 termdd.sys           0x8f46f000    0x10000 \SystemRoot\system32\DRIVERS\termdd.sys
0x86432240 rdbss.sys            0x8f47f000    0x41000 \SystemRoot\system32\DRIVERS\rdbss.sys
0x863cba08 nsiproxy.sys         0x8f4c0000     0xa000 \SystemRoot\system32\drivers\nsiproxy.sys
0x865ca1d8 mssmbios.sys         0x8f4ca000     0xa000 \SystemRoot\system32\DRIVERS\mssmbios.sys
0x865ca328 discache.sys         0x8f4d4000     0xc000 \SystemRoot\System32\drivers\discache.sys
0x865ca2b0 csc.sys              0x8f4e0000    0x64000 \SystemRoot\system32\drivers\csc.sys
0x8c5fe3e0 dfsc.sys             0x8f544000    0x18000 \SystemRoot\System32\Drivers\dfsc.sys
0x8637be68 blbdrive.sys         0x8f55c000     0xe000 \SystemRoot\system32\DRIVERS\blbdrive.sys
0x8637b9d0 tunnel.sys           0x8f56a000    0x21000 \SystemRoot\system32\DRIVERS\tunnel.sys
0x8cdf9638 i8042prt.sys         0x8f58b000    0x18000 \SystemRoot\system32\DRIVERS\i8042prt.sys
0x8640a008 kbdclass.sys         0x8f5a3000     0xd000 \SystemRoot\system32\DRIVERS\kbdclass.sys
0x867c7e98 vmmouse.sys          0x8f5b0000     0x8000 \SystemRoot\system32\DRIVERS\vmmouse.sys
0x8632ab40 mouclass.sys         0x8f5b8000     0xd000 \SystemRoot\system32\DRIVERS\mouclass.sys
0x8c5f4240 serenum.sys          0x8f5c5000     0xa000 \SystemRoot\system32\DRIVERS\serenum.sys
0x863754e8 fdc.sys              0x8f5cf000     0xb000 \SystemRoot\system32\DRIVERS\fdc.sys
0x865a0780 vm3dmp.sys           0x8d802000    0x2c000 \SystemRoot\system32\DRIVERS\vm3dmp.sys
0x8e2c3738 dxgkrnl.sys          0x8d82e000    0xb7000 \SystemRoot\System32\drivers\dxgkrnl.sys
0x8693d600 dxgmms1.sys          0x8d8e5000    0x39000 \SystemRoot\System32\drivers\dxgmms1.sys
0x86725718 usbuhci.sys          0x8d91e000     0xb000 \SystemRoot\system32\DRIVERS\usbuhci.sys
0x872a55a8 USBPORT.SYS          0x8d929000    0x4b000 \SystemRoot\system32\DRIVERS\USBPORT.SYS
0x8662e430 E1G60I32.sys         0x8d974000    0x1d000 \SystemRoot\system32\DRIVERS\E1G60I32.sys
0x86a10888 HDAudBus.sys         0x8d991000    0x1f000 \SystemRoot\system32\DRIVERS\HDAudBus.sys
0x86a6c800 usbehci.sys          0x8d9b0000     0xf000 \SystemRoot\system32\DRIVERS\usbehci.sys
0x8655e7c0 CmBatt.sys           0x8d9bf000     0x4000 \SystemRoot\system32\DRIVERS\CmBatt.sys
0x8655e920 intelppm.sys         0x8d9c3000    0x12000 \SystemRoot\system32\DRIVERS\intelppm.sys
0x8655ea70 CompositeBus.sys     0x8d9d5000     0xd000 \SystemRoot\system32\DRIVERS\CompositeBus.sys
0x867c7210 AgileVpn.sys         0x8d9e2000    0x12000 \SystemRoot\system32\DRIVERS\AgileVpn.sys
0x86bb71f0 rasl2tp.sys          0x8f5da000    0x18000 \SystemRoot\system32\DRIVERS\rasl2tp.sys
0x871ade10 ndistapi.sys         0x8d9f4000     0xb000 \SystemRoot\system32\DRIVERS\ndistapi.sys
0x871ad5d8 ndiswan.sys          0x8fc04000    0x22000 \SystemRoot\system32\DRIVERS\ndiswan.sys
0x8c4f24c0 raspppoe.sys         0x8fc26000    0x18000 \SystemRoot\system32\DRIVERS\raspppoe.sys
0x85e0e5f8 raspptp.sys          0x8fc3e000    0x17000 \SystemRoot\system32\DRIVERS\raspptp.sys
0x86575228 rassstp.sys          0x8fc55000    0x17000 \SystemRoot\system32\DRIVERS\rassstp.sys
0x85dcacb0 rdpbus.sys           0x8fc6c000     0xa000 \SystemRoot\system32\DRIVERS\rdpbus.sys
0x8c5f64a8 swenum.sys           0x8fc76000     0x2000 \SystemRoot\system32\DRIVERS\swenum.sys
0x8c5f6858 ks.sys               0x8fc78000    0x34000 \SystemRoot\system32\DRIVERS\ks.sys
0x8cd8b6d0 umbus.sys            0x8fcac000     0xe000 \SystemRoot\system32\DRIVERS\umbus.sys
0x86a026b8 flpydisk.sys         0x8fcba000     0xa000 \SystemRoot\system32\DRIVERS\flpydisk.sys
0x864b0400 usbhub.sys           0x8fcc4000    0x44000 \SystemRoot\system32\DRIVERS\usbhub.sys
0x862c2b28 NDProxy.SYS          0x8fd08000    0x11000 \SystemRoot\System32\Drivers\NDProxy.SYS
0x86a02af8 HdAudio.sys          0x8fd19000    0x50000 \SystemRoot\system32\drivers\HdAudio.sys
0x871ad270 portcls.sys          0x8fd69000    0x2f000 \SystemRoot\system32\drivers\portcls.sys
0x863e25a8 drmk.sys             0x8fd98000    0x19000 \SystemRoot\system32\drivers\drmk.sys
0x86375d18 crashdmp.sys         0x8fdb1000     0xd000 \SystemRoot\System32\Drivers\crashdmp.sys
0x863ce008 dump_storport.sys    0x8fdbe000     0xa000 \SystemRoot\System32\Drivers\dump_diskdump.sys
0x86ab90e0 dump_LSI_SAS.sys     0x8fdc8000    0x18000 \SystemRoot\System32\Drivers\dump_LSI_SAS.sys
0x862cf008 dump_dumpfve.sys     0x8fde0000    0x11000 \SystemRoot\System32\Drivers\dump_dumpfve.sys
0x86ac0450 win32k.sys           0x94310000   0x24a000 \SystemRoot\System32\win32k.sys
0x8748fca8 Dxapi.sys            0x8fdf1000     0xa000 \SystemRoot\System32\drivers\Dxapi.sys
0x86b08918 monitor.sys          0x8f5f2000     0xb000 \SystemRoot\system32\DRIVERS\monitor.sys
0x86b71e58 TSDDD.dll            0x94570000     0x9000 \SystemRoot\System32\TSDDD.dll
0x86be80e0 cdd.dll              0x945a0000    0x1e000 \SystemRoot\System32\cdd.dll
0x86d3b390 usbccgp.sys          0x88000000    0x17000 \SystemRoot\system32\DRIVERS\usbccgp.sys
0x86dab0d8 USBD.SYS             0x8fdfb000     0x2000 \SystemRoot\system32\DRIVERS\USBD.SYS
0x86ceaa58 hidusb.sys           0x8f400000     0xb000 \SystemRoot\system32\DRIVERS\hidusb.sys
0x86c14c98 HIDCLASS.SYS         0x88052000    0x13000 \SystemRoot\system32\DRIVERS\HIDCLASS.SYS
0x86c14d40 HIDPARSE.SYS         0x8f40b000     0x7000 \SystemRoot\system32\DRIVERS\HIDPARSE.SYS
0x86b11928 mouhid.sys           0x88065000     0xb000 \SystemRoot\system32\DRIVERS\mouhid.sys
0x86c36458 vmusbmouse.sys       0x88070000     0x8000 \SystemRoot\system32\DRIVERS\vmusbmouse.sys
0x86ddbb68 luafv.sys            0x82e00000    0x1b000 \SystemRoot\system32\drivers\luafv.sys
0x86f7a4f0 lltdio.sys           0x88078000    0x10000 \SystemRoot\system32\DRIVERS\lltdio.sys
0x86f7a378 rspndr.sys           0x87bed000    0x13000 \SystemRoot\system32\DRIVERS\rspndr.sys
0x86fb42b8 HTTP.sys             0x94818000    0x85000 \SystemRoot\system32\drivers\HTTP.sys
0x86ff6dd0 bowser.sys           0x9489d000    0x19000 \SystemRoot\system32\DRIVERS\bowser.sys
0x86ff6140 mpsdrv.sys           0x948b6000    0x12000 \SystemRoot\System32\drivers\mpsdrv.sys
0x86d463f8 mrxsmb.sys           0x948c8000    0x23000 \SystemRoot\system32\DRIVERS\mrxsmb.sys
0x86ffcda8 mrxsmb10.sys         0x948eb000    0x3b000 \SystemRoot\system32\DRIVERS\mrxsmb10.sys
0x86ffd500 mrxsmb20.sys         0x94926000    0x1b000 \SystemRoot\system32\DRIVERS\mrxsmb20.sys
0x8702aa30 vmmemctl.sys         0x94959000     0x8000 \SystemRoot\system32\DRIVERS\vmmemctl.sys
0x87082bf0 peauth.sys           0x94961000    0x97000 \SystemRoot\system32\drivers\peauth.sys
0x870869d8 secdrv.SYS           0x94800000     0xa000 \SystemRoot\System32\Drivers\secdrv.SYS
0x84f490e0 srvnet.sys           0x9e02e000    0x21000 \SystemRoot\System32\DRIVERS\srvnet.sys
0x87084890 tcpipreg.sys         0x9e04f000     0xd000 \SystemRoot\System32\drivers\tcpipreg.sys
0x870d0b80 srv2.sys             0x9e05c000    0x4f000 \SystemRoot\System32\DRIVERS\srv2.sys
0x86f228b8 srv.sys              0x9e0ab000    0x51000 \SystemRoot\System32\DRIVERS\srv.sys
0x86f1a1b8 vmhgfs.sys           0x9e0fc000    0x21000 \SystemRoot\system32\DRIVERS\vmhgfs.sys
0x8568a550 DumpIt.sys           0x9e11d000     0xc000 \??\C:\Windows\system32\Drivers\DumpIt.sys
0x8506b8b8 spsys.sys            0x9e129000    0x6a000 \SystemRoot\system32\drivers\spsys.sys
```


dump KeePass memory......
```
FlagDatabase.kdbx
vmx.tools.get_version_status
vmx.tools.get_version_status
copypaste.transport 
KLCT... No-no-no. That would be too easy :)
vmx.tools.get_version_status
vmx.tools.get_version_status
```