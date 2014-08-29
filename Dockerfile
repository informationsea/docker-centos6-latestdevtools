FROM informationsea/centos6-buildessentials
MAINTAINER OKAMURA Yasunobu <okamura@informaitonsea.info>

RUN yum install -y glibc-devel.i686 glibc-devel
ENV LD_LIBRARY_PATH /usr/local/lib

WORKDIR /tmp
COPY binutils-2.24.tar.bz2 /tmp/binutils-2.24.tar.bz2
RUN tar xjf binutils-2.24.tar.bz2
WORKDIR /tmp/binutils-2.24
RUN ./configure
RUN make
RUN make install

WORKDIR /tmp
COPY gmp-6.0.0a.tar.bz2 /tmp/gmp-6.0.0a.tar.bz2
RUN tar xjf gmp-6.0.0a.tar.bz2
WORKDIR /tmp/gmp-6.0.0
RUN ./configure --disable-nls --with-build-sysroot=/
RUN make
RUN make install

WORKDIR /tmp
COPY mpfr-3.1.2.tar.bz2 /tmp/mpfr-3.1.2.tar.bz2
RUN tar xjf mpfr-3.1.2.tar.bz2
WORKDIR /tmp/mpfr-3.1.2
RUN ./configure --with-gmp=/usr/local
RUN make
RUN make install
WORKDIR /tmp

COPY mpc-1.0.2.tar.gz /tmp/mpc-1.0.2.tar.gz
RUN tar xzf mpc-1.0.2.tar.gz
WORKDIR /tmp/mpc-1.0.2
RUN ./configure --with-gmp=/usr/local --with-mpfr=/usr/local
RUN make
RUN make install

WORKDIR /tmp
COPY gcc-4.8.3.tar.bz2 /tmp/gcc-4.8.3.tar.bz2
RUN tar xjf gcc-4.8.3.tar.bz2
WORKDIR /tmp/gcc-4.8.3
RUN ./configure --enable-languages=c,c++  --with-gmp=/usr/local --with-mpfr=/usr/local --with-mpc=/usr/local --disable-nls
RUN make
RUN make install
