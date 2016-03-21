# build-capi-native

[![](https://badge.imagelayers.io/gmacario/build-capi-native:latest.svg)](https://imagelayers.io/?images=gmacario/build-capi-native:latest 'Get your own badge on imagelayers.io')

This subproject of [easy-build](https://github.com/gmacario/easy-build) provides a Docker image useful for building from sources the GENIVI [Common API C](http://git.projects.genivi.org/common-api/c-poc.git) project.

## Prerequisites

* A machine with [Docker](https://www.docker.com/) version 1.10 or later installed
  - Tested on Ubuntu 16.04.4 LTS 64-bit

## Step-by-step instructions

### Build the Docker image

```
$ cd easy-build
$ docker build -t gmacario/build-capi-native build-capi-native/
```

### Build common-api/c-poc inside a container

Run the container to prepare a proper development environment

```
$ docker run -ti -u build -w /home/build gmacario/build-capi-native
```

Logged as _build@container_, execute the commands as explained in toplevel `README.adoc`

```
$ git clone git://git.projects.genivi.org/common-api/c-poc.git
$ cd c-poc
$ autoreconf -i && ./configure && make && sudo make install
```

To verify that the build was successful you may inspect the resulting files, or analyze the messages on stdout:

```
build@2f59052167d9:~/c-poc$ autoreconf -i && ./configure && make && sudo make install
libtoolize: putting auxiliary files in '.'.
libtoolize: copying file './ltmain.sh'
libtoolize: Consider adding 'AC_CONFIG_MACRO_DIRS([m4])' to configure.ac,
libtoolize: and rerunning libtoolize and aclocal.
libtoolize: Consider adding '-I m4' to ACLOCAL_AMFLAGS in Makefile.am.
configure.ac:18: installing './ar-lib'
configure.ac:17: installing './compile'
configure.ac:21: installing './config.guess'
configure.ac:21: installing './config.sub'
configure.ac:16: installing './install-sh'
configure.ac:16: installing './missing'
Makefile.am: installing './depcomp'
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... no
checking for mawk... mawk
checking whether make sets $(MAKE)... yes
checking whether make supports nested variables... yes
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking whether gcc understands -c and -o together... yes
checking for style of include used by make... GNU
checking dependency style of gcc... gcc3
checking for ar... ar
checking the archiver (ar) interface... ar
checking build system type... x86_64-pc-linux-gnu
checking host system type... x86_64-pc-linux-gnu
checking how to print strings... printf
checking for a sed that does not truncate output... /bin/sed
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for fgrep... /bin/grep -F
checking for ld used by gcc... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
checking the name lister (/usr/bin/nm -B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking how to convert x86_64-pc-linux-gnu file names to x86_64-pc-linux-gnu format... func_convert_file_noop
checking how to convert x86_64-pc-linux-gnu file names to toolchain format... func_convert_file_noop
checking for /usr/bin/ld option to reload object files... -r
checking for objdump... objdump
checking how to recognize dependent libraries... pass_all
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for archiver @FILE support... @
checking for strip... strip
checking for ranlib... ranlib
checking command to parse /usr/bin/nm -B output from gcc object... ok
checking for sysroot... no
checking for a working dd... /bin/dd
checking how to truncate binary pipes... /bin/dd bs=4096 count=1
checking for mt... no
checking if : is a manifest tool... no
checking how to run the C preprocessor... gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking for dlfcn.h... yes
checking for objdir... .libs
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC -DPIC
checking if gcc PIC flag -fPIC -DPIC works... yes
checking if gcc static flag -static works... yes
checking if gcc supports -c -o file.o... yes
checking if gcc supports -c -o file.o... (cached) yes
checking whether the gcc linker (/usr/bin/ld -m elf_x86_64) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
checking for pkg-config... /usr/bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
checking for LIBSYSTEMD... yes
checking for sd_bus_open in -lsystemd... yes
checking for sd_bus_get_scope in -lsystemd... yes
checking whether SD_EVENT_INITIAL is declared... yes
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating Makefile
config.status: creating capic.pc
config.status: creating config.h
config.status: executing depfiles commands
config.status: executing libtool commands
make  all-am
make[1]: Entering directory '/home/build/c-poc'
/bin/bash ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -I./src -I.  -Wall -Werror -fvisibility=hidden -g -O2 -MT src/libcapic_la-backend.lo -MD -MP -MF src/.deps/libcapic_la-backend.Tpo -c -o src/libcapic_la-backend.lo `test -f 'src/backend.c' || echo './'`src/backend.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I./src -I. -Wall -Werror -fvisibility=hidden -g -O2 -MT src/libcapic_la-backend.lo -MD -MP -MF src/.deps/libcapic_la-backend.Tpo -c src/backend.c  -fPIC -DPIC -o src/.libs/libcapic_la-backend.o
mv -f src/.deps/libcapic_la-backend.Tpo src/.deps/libcapic_la-backend.Plo
/bin/bash ./libtool  --tag=CC   --mode=link gcc -I./src -I.  -Wall -Werror -fvisibility=hidden -g -O2 -no-undefined -version-info 0:0:0  -o libcapic.la -rpath /usr/local/lib  src/libcapic_la-backend.lo
libtool: link: gcc -shared  -fPIC -DPIC  src/.libs/libcapic_la-backend.o    -g -O2   -Wl,-soname -Wl,libcapic.so.0 -o .libs/libcapic.so.0.0.0
libtool: link: (cd ".libs" && rm -f "libcapic.so.0" && ln -s "libcapic.so.0.0.0" "libcapic.so.0")
libtool: link: (cd ".libs" && rm -f "libcapic.so" && ln -s "libcapic.so.0.0.0" "libcapic.so")
libtool: link: ( cd ".libs" && rm -f "libcapic.la" && ln -s "../libcapic.la" "libcapic.la" )
make[1]: Leaving directory '/home/build/c-poc'
make[1]: Entering directory '/home/build/c-poc'
 /bin/mkdir -p '/usr/local/lib'
 /bin/bash ./libtool   --mode=install /usr/bin/install -c   libcapic.la '/usr/local/lib'
libtool: install: /usr/bin/install -c .libs/libcapic.so.0.0.0 /usr/local/lib/libcapic.so.0.0.0
libtool: install: (cd /usr/local/lib && { ln -s -f libcapic.so.0.0.0 libcapic.so.0 || { rm -f libcapic.so.0 && ln -s libcapic.so.0.0.0 libcapic.so.0; }; })
libtool: install: (cd /usr/local/lib && { ln -s -f libcapic.so.0.0.0 libcapic.so || { rm -f libcapic.so && ln -s libcapic.so.0.0.0 libcapic.so; }; })
libtool: install: /usr/bin/install -c .libs/libcapic.lai /usr/local/lib/libcapic.la
libtool: finish: PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/sbin" ldconfig -n /usr/local/lib
----------------------------------------------------------------------
Libraries have been installed in:
   /usr/local/lib

If you ever happen to want to link against installed libraries
in a given directory, LIBDIR, you must either use libtool, and
specify the full pathname of the library, or use the '-LLIBDIR'
flag during linking and do at least one of the following:
   - add LIBDIR to the 'LD_LIBRARY_PATH' environment variable
     during execution
   - add LIBDIR to the 'LD_RUN_PATH' environment variable
     during linking
   - use the '-Wl,-rpath -Wl,LIBDIR' linker flag
   - have your system administrator add LIBDIR to '/etc/ld.so.conf'

See any operating system documentation about shared libraries for
more information, such as the ld(1) and ld.so(8) manual pages.
----------------------------------------------------------------------
 /bin/mkdir -p '/usr/local/lib/pkgconfig'
 /usr/bin/install -c -m 644 capic.pc '/usr/local/lib/pkgconfig'
 /bin/mkdir -p '/usr/local/include/capic'
 /usr/bin/install -c -m 644 src/capic/backend.h src/capic/log.h src/capic/dbus-private.h '/usr/local/include/capic'
make[1]: Leaving directory '/home/build/c-poc'
build@2f59052167d9:~/c-poc$
```

<!-- EOF -->
