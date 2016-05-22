FROM greyltc/archlinux
MAINTAINER martin@gabelmann.biz

ENV PY_USER=root \
    PY_PASS=root
    
RUN pacman -Syyu --noconfirm &&\
    pacman -S openssl python2 python2-crypto python2-imaging\
              python2-pycurl tesseract python2-pyopenssl js \
              python2-jinja python2-pycurl python2-beaker thrift\
              python2-beautifulsoup4 git --noconfirm --needed &&\
    ln -s /usr/bin/js24 /usr/bin/js &&\
    git clone https://github.com/pyload/pyload.git /pyload &&\
    sed -i 's_#!/usr/bin/env python$_#!/usr/bin/env python2_' /pyload/pyLoad*.py &&\
    /usr/sbin/useradd pyload &&\
    /usr/bin/install -g pyload -o pyload -m 775 -d /dl &&\
    /usr/bin/install -g pyload -o pyload -m 775 -d /conf

VOLUME ["/dl", "/conf"]

EXPOSE 8000
EXPOSE 433
EXPOSE 9666

WORKDIR /conf

CMD ["/usr/bin/su", "-", "pyload", "-c /pyload/pyLoadCore.py --configdir=/conf"]
