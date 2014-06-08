## Building container

    ./build.sh

## Running container

    ./run.sh

## Building the Yocto-based distribution for the Wandboard dual

Precondition: logged into the container.

Create an environment variable

    export YOCTO=/opt/yocto

Configure SHA for each layer

    #TODO: poky
    #TODO: meta-fsl
    
Create the build environment

    cd $YOCTO/fsl-community-bsp
    ln -sf ~/work/build-wandboard-dual
    MACHINE=wandboard-dual \
        source ./setup-environment \
        build-wandboard-dual
        
Verify (and if necessary update) the build configuration under conf/

    touch conf/sanity.conf
    #TODO
    
Workaround: edit conf/bblayer.conf and replace BSPDIR with

    BSPDIR := "/opt/yocto/fsl-community-bsp"
    
Start the build

    bitbake -k core-image-sato

The resulting image `core-image-sato-wandboard-dual.sdcard` will be available under `$PWD/work/build-wandboard-dual/tmp/deploy/images/wandboard-dual`.

## Mirroring wandboard image

    ./do_mirror.sh
    
## Flashing wandboard image

### From Linux

Plug the uSDHC inside the host, use `dmesg` to verify the name of the device (example: `/dev/sdX`).
Write the image with the following command (replace `/dev/sdX` appropriately):

    sudo dd if=core-image-sato-wandboard-dual.sdcard of=/dev/sdX

### From MS Windows
From MS Windows, you may use [Win32 Disk Imager](http://sourceforge.net/projects/win32diskimager/) to burn a uSDHC
with the contents of `core-image-sato-wandboard-dual.sdcard`.

## Sample boot log

```
gmacario@ITM-GMACARIO-W7 ~
$ ssh root@192.168.64.107
root@wandboard-dual:~# uname -a
Linux wandboard-dual 3.10.17-1.0.0-wandboard+g9d567e4 #1 SMP PREEMPT Sun Jun 1 21:42:03 UTC 2014 armv7l GNU/Linux
root@wandboard-dual:~# df -h
Filesystem                Size      Used Available Use% Mounted on
/dev/root               278.9M    180.7M     83.8M  68% /
devtmpfs                372.8M      4.0K    372.8M   0% /dev
tmpfs                    40.0K         0     40.0K   0% /mnt/.psplash
tmpfs                   500.9M    192.0K    500.7M   0% /run
tmpfs                   500.9M     84.0K    500.8M   0% /var/volatile
/dev/mmcblk0p1            8.0M      5.1M      2.9M  64% /media/mmcblk0p1
root@wandboard-dual:~# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:1F:7B:B2:05:02
          inet addr:192.168.64.107  Bcast:192.168.64.255  Mask:255.255.255.0
          inet6 addr: fe80::21f:7bff:feb2:502/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:193 errors:0 dropped:0 overruns:0 frame:0
          TX packets:217 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:24691 (24.1 KiB)  TX bytes:28336 (27.6 KiB)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

root@wandboard-dual:~# ls -la /media/mmcblk0p1/
drwxrwx---    2 root     disk         16384 Jan  1  1970 .
drwxr-xr-x    3 root     root          1024 Jan  1  1970 ..
-rwxrwx---    1 root     disk         41322 Jun  2 08:19 imx6dl-wandboard.dtb
-rwxrwx---    1 root     disk       5301312 Jun  2 08:19 zImage
root@wandboard-dual:~# cat /proc/cmdline
console=ttymxc0,115200 root=/dev/mmcblk0p2 rootwait rw
root@wandboard-dual:~#
```
