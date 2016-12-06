FROM fedora
RUN dnf update -y && dnf install -y wget && dnf install -y gcc
RUN dnf install -y tar && dnf install -y gcc-c++
RUN dnf install -y make
RUN dnf install -y perl && dnf install -y 'perl(Getopt::Long)'
WORKDIR '/build'
RUN  wget --no-check-certificate ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.39.tar.gz
RUN tar zxf pcre-8.39.tar.gz
WORKDIR '/build/pcre-8.39'
RUN ./configure && make && make install
WORKDIR /build
RUN  wget http://zlib.net/zlib-1.2.8.tar.gz
RUN  tar zxf zlib-1.2.8.tar.gz
WORKDIR '/build/zlib-1.2.8'
RUN  ./configure && make && make install
WORKDIR /build
RUN   wget http://www.openssl.org/source/openssl-1.0.2f.tar.gz
RUN tar zxf openssl-1.0.2f.tar.gz
WORKDIR '/build/openssl-1.0.2f'
RUN   ./config --prefix=/usr && make && make install
WORKDIR /build
RUN  wget http://nginx.org/download/nginx-1.10.2.tar.gz
RUN tar zxf nginx-1.10.2.tar.gz
WORKDIR '/build/nginx-1.10.2'
RUN   ./configure \
     --sbin-path=/usr/local/nginx/nginx \
     --conf-path=/usr/local/nginx/nginx.conf \
     --pid-path=/usr/local/nginx/nginx.pid \
     --with-pcre=/pcre-8.39 \
     --with-zlib=/pcre-8.39/zlib-1.2.8 \
     --with-http_ssl_module \
     --with-debug && make && make install
CMD ["/usr/local/nginx/nginx"]

