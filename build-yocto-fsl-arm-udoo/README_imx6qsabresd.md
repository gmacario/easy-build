## Getting familiar with i.MX6 SabreSD

### Get U-Boot prompt
Power up board, press <SPACE> to get U-Boot prompt

```
U-Boot 2014.01 (Jun 16 2014 - 04:20:26)

CPU:   Freescale i.MX6Q rev1.2 at 792 MHz
Reset cause: WDOG
Board: MX6-SabreSD
DRAM:  1 GiB
MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
*** Warning - bad CRC, using default environment

auto-detected panel HDMI
Display: HDMI (1024x768)
In:    serial
Out:   serial
Err:   serial
Net:   FEC [PRIME]
Hit any key to stop autoboot:  0
=>
```

### Show U-Boot available commands
```
=> help
?       - alias for 'help'
base    - print or set address offset
bdinfo  - print Board Info structure
bmode   - sd2|sd3|emmc|normal|usb|sata|escpi1:0|escpi1:1|escpi1:2|escpi1:3|esdhc1|esdhc2|esdhc3|esdhc4 [noreset]
boot    - boot default, i.e., run 'bootcmd'
bootd   - boot default, i.e., run 'bootcmd'
bootm   - boot application image from memory
bootp   - boot image via network using BOOTP/TFTP protocol
bootz   - boot Linux zImage image from memory
clocks  - display clocks
clrlogo - fill the boot logo area with black
cmp     - memory compare
coninfo - print console devices and information
cp      - memory copy
crc32   - checksum calculation
dcache  - enable or disable data cache
dhcp    - boot image via network using DHCP/TFTP protocol
echo    - echo args to console
editenv - edit environment variable
env     - environment handling commands
erase   - erase FLASH memory
exit    - exit script
ext2load- load binary file from a Ext2 filesystem
ext2ls  - list files in a directory (default /)
false   - do nothing, unsuccessfully
fatinfo - print information about filesystem
fatload - load binary file from a dos filesystem
fatls   - list files in a directory (default /)
fdt     - flattened device tree utility commands
flinfo  - print FLASH memory information
fuse    - Fuse sub-system
go      - start application at address 'addr'
help    - print command description/usage
icache  - enable or disable instruction cache
iminfo  - print header information for application image
imxtract- extract a part of a multi-image
itest   - return true/false on integer compare
loadb   - load binary file over serial line (kermit mode)
loads   - load S-Record file over serial line
loadx   - load binary file over serial line (xmodem mode)
loady   - load binary file over serial line (ymodem mode)
loop    - infinite loop on address range
md      - memory display
mdio    - MDIO utility commands
mii     - MII utility commands
mm      - memory modify (auto-incrementing address)
mmc     - MMC sub system
mmcinfo - display MMC info
mw      - memory write (fill)
nfs     - boot image via network using NFS protocol
nm      - memory modify (constant address)
ping    - send ICMP ECHO_REQUEST to network host
printenv- print environment variables
protect - enable or disable FLASH write protection
reset   - Perform RESET of the CPU
run     - run commands in an environment variable
saveenv - save environment variables to persistent storage
setenv  - set environment variables
setexpr - set environment variable as the result of eval expression
sf      - SPI flash sub-system
showvar - print local hushshell variables
sleep   - delay execution for some time
source  - run script from memory
test    - minimal test like /bin/sh
tftpboot- boot image via network using TFTP protocol
true    - do nothing, successfully
version - print monitor, compiler and linker version
=>
```

### Print U-Boot version
```
=> version

U-Boot 2014.01 (Jun 16 2014 - 04:20:26)
arm-poky-linux-gnueabi-gcc (GCC) 4.8.2
GNU ld (GNU Binutils) 2.24
=>
```

### Inspect U-Boot environment variables
```
=> printenv
baudrate=115200
boot_fdt=try
bootcmd=mmc dev ${mmcdev};if mmc rescan; then if run loadbootscript; then run bootscript; else if run loaduimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi
bootdelay=1
bootscript=echo Running bootscript from mmc ...; source
console=ttymxc0
emmcdev=2
ethact=FEC
ethaddr=00:04:9f:02:b0:36
ethprime=FEC
fdt_addr=0x18000000
fdt_file=imx6q-sabresd-ldo.dtb
fdt_high=0xffffffff
initrd_high=0xffffffff
ip_dyn=yes
loadaddr=0x12000000
loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}
loaduimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${uimage}
mmcargs=setenv bootargs console=${console},${baudrate} root=${mmcroot}
mmcboot=echo Booting from mmc ...; run mmcargs; if test ${boot_fdt} = yes || test ${boot_fdt} = try; then if run loadfdt; then bootm ${loadaddr} - ${fdt_addr}; else if test ${boot_fdt} = try; then bootm; else echo WARN: Cannot load the DT; fi; fi; else bootm; fi;
mmcdev=1
mmcpart=1
mmcroot=/dev/mmcblk0p2 rootwait rw
netargs=setenv bootargs console=${console},${baudrate} root=/dev/nfs ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
netboot=echo Booting from net ...; run netargs; if test ${ip_dyn} = yes; then setenv get_cmd dhcp; else setenv get_cmd tftp; fi; ${get_cmd} ${uimage}; if test ${boot_fdt} = yes || test ${boot_fdt} = try; then if ${get_cmd} ${fdt_addr} ${fdt_file}; then bootm ${loadaddr} - ${fdt_addr}; else if test ${boot_fdt} = try; then bootm; else echo WARN: Cannot load the DT; fi; fi; else bootm; fi;
script=boot.scr
uimage=uImage
update_emmc_firmware=if test ${ip_dyn} = yes; then setenv get_cmd dhcp; else setenv get_cmd tftp; fi; if ${get_cmd} ${update_sd_firmware_filename}; then if mmc dev ${emmcdev} && mmc open ${emmcdev} 1; then setexpr fw_sz ${filesize} / 0x200; setexpr fw_sz ${fw_sz} + 1; mmc write ${loadaddr} 0x2 ${fw_sz}; mmc close ${emmcdev} 1; fi; fi
update_sd_firmware=if test ${ip_dyn} = yes; then setenv get_cmd dhcp; else setenv get_cmd tftp; fi; if mmc dev ${mmcdev}; then if ${get_cmd} ${update_sd_firmware_filename}; then setexpr fw_sz ${filesize} / 0x200; setexpr fw_sz ${fw_sz} + 1; mmc write ${loadaddr} 0x2 ${fw_sz}; fi; fi

Environment size: 2284/8188 bytes
=>
```

EOF
