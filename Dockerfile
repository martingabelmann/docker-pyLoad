FROM greyltc/archlinux
MAINTAINER martin@gabelmann.biz

RUN pacman -Syyu --noconfirm &&\
    pacman -S openssl python2 python2-crypto python2-imaging\
              python2-pycurl tesseract python2-pyopenssl js \
              python2-jinja python2-pycurl python2-beaker thrift\
              python2-beautifulsoup4 python2-funcsigs unrar git --noconfirm --needed &&\
    pacman -Sc --noconfirm &&\
    ln -s /usr/bin/js24 /usr/bin/js &&\
    git clone https://github.com/pyload/pyload.git /pyload &&\
    sed -i 's_#!/usr/bin/env python$_#!/usr/bin/env python2_' /pyload/pyLoad*.py &&\
    sed -i '/^import os$/a if os.path.isfile('\"/conf/pyload.pid\"'): os.remove('\"/conf/pyload.pid\"')' /pyload/pyLoadCore.py &&\
    /usr/sbin/useradd -u 9666  pyload &&\
    /usr/bin/install -g pyload -o pyload -m 775 -d /dl &&\
    /usr/bin/install -g pyload -o pyload -m 775 -d /conf
    
VOLUME ["/dl", "/conf"]

EXPOSE 8000
EXPOSE 433
EXPOSE 9666

USER pyload
WORKDIR /conf
ENTRYPOINT ["/pyload/pyLoadCore.py", "--configdir=/conf"]

