FROM informationsea/centos6-buildessentials
MAINTAINER OKAMURA Yasunobu <okamura@informaitonsea.info>

RUN yum install -y glibc-devel.i686 glibc-devel
ENV LD_LIBRARY_PATH /usr/local/lib

RUN expr `grep processor /proc/cpuinfo|tail -n1|cut -f 2 -d :` + 1|tee /tmp/cpunum.txt

WORKDIR /tmp
COPY binutils-2.24.tar.bz2 /tmp/binutils-2.24.tar.bz2
RUN tar xjf binutils-2.24.tar.bz2
WORKDIR /tmp/binutils-2.24
RUN ./configure --disable-nls --with-build-sysroot=/
RUN make -j `cat /tmp/cpunum.txt`
RUN make install

WORKDIR /tmp
COPY gmp-6.0.0a.tar.bz2 /tmp/gmp-6.0.0a.tar.bz2
RUN tar xjf gmp-6.0.0a.tar.bz2
WORKDIR /tmp/gmp-6.0.0
RUN ./configure
RUN make -j `cat /tmp/cpunum.txt`
RUN make install

WORKDIR /tmp
COPY mpfr-3.1.2.tar.bz2 /tmp/mpfr-3.1.2.tar.bz2
RUN tar xjf mpfr-3.1.2.tar.bz2
WORKDIR /tmp/mpfr-3.1.2
RUN ./configure --with-gmp=/usr/local
RUN make -j `cat /tmp/cpunum.txt`
RUN make install

WORKDIR /tmp
COPY mpc-1.0.2.tar.gz /tmp/mpc-1.0.2.tar.gz
RUN tar xzf mpc-1.0.2.tar.gz
WORKDIR /tmp/mpc-1.0.2
RUN ./configure --with-gmp=/usr/local --with-mpfr=/usr/local
RUN make -j `cat /tmp/cpunum.txt`
RUN make install

WORKDIR /tmp
COPY isl-0.12.2.tar.bz2 /tmp/isl-0.12.2.tar.bz2
RUN tar xjf isl-0.12.2.tar.bz2
WORKDIR /tmp/isl-0.12.2
RUN ./configure --with-gmp=/usr/local --with-mpfr=/usr/local
RUN make -j `cat /tmp/cpunum.txt`
RUN make install

WORKDIR /tmp
COPY cloog-0.18.1.tar.gz /tmp/cloog-0.18.1.tar.gz
RUN tar xzf cloog-0.18.1.tar.gz
WORKDIR /tmp/cloog-0.18.1
RUN ./configure --with-gmp=/usr/local --with-mpfr=/usr/local
RUN make -j `cat /tmp/cpunum.txt`
RUN make install

WORKDIR /tmp
COPY gcc-4.8.3.tar.bz2 /tmp/gcc-4.8.3.tar.bz2
RUN tar xjf gcc-4.8.3.tar.bz2
WORKDIR /tmp/gcc-4.8.3
RUN ./configure --enable-languages=c,c++,fortran,go --with-gmp=/usr/local --with-mpfr=/usr/local --with-mpc=/usr/local --disable-nls --with-isl=/usr/local --with-cloog=/usr/local
RUN make -j `cat /tmp/cpunum.txt`
RUN make install

WORKDIR /tmp
COPY gdb-7.8.tar.xz /tmp/gdb-7.8.tar.xz
RUN tar xJf gdb-7.8.tar.xz
WORKDIR /tmp/gdb-7.8
RUN yum install -y ncurses-devel
RUN ./configure --enable-languages=c,c++,fortran,go  --with-gmp=/usr/local --with-mpfr=/usr/local --with-mpc=/usr/local --disable-nls --with-isl=/usr/local --with-cloog=/usr/local
RUN make -j `cat /tmp/cpunum.txt`
RUN make install


# Clean up
RUN rm -rf /tmp/binutils-2.24
RUN rm -rf /tmp/gmp-6.0.0
RUN rm -rf /tmp/mpfr-3.1.2
RUN rm -rf /tmp/mpc-1.0.2
RUN rm -rf /tmp/isl-0.12.2
RUN rm -rf /tmp/cloog-0.18.1
RUN rm -rf /tmp/gcc-4.8.3
RUN rm -rf /tmp/gdb-7.8
