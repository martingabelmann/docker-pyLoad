#Dockerized PyLoad
_Based on [lgreyltc/docker-archlinux](https://github.com/greyltc/docker-archlinux)_

##Install

* pull the image:
  ```
  docker pull martingabelmann/pyload
  ```
 * If you already have a working pyload configuration skip the following step:
 * run the pyload setup to create a proper config at your mountpoint ``/srv/pyload``. Set the Download dir to /dl when the setup asks for it.:
  ```
  mkdir /srv/pyload; chown 9666 /srv/pyload
  docker run -ti --rm -v /srv/pyload:/conf martingabelmann/pyload
  ```
 * now, that you have configs at ``/srv/pyload`` owned by uid 9996, run pyload:
  ```
  docker run -d --name=pyload -v /srv/pyload:/conf -v ~/Downloads:/dl -p 80:8000 -p 9666:9666 martingabelmann/pyload
  ```
 * done!

Dont forget to make ``~/Downloads`` writeable for uid 9666 (or choose another mountpoint of your choice).
  
  
Have fun!

