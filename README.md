
------------
Provisioning scripts
------------


## Extra settings:
---------
- in `/etc/gai.conf` uncomment `precedence ::ffff:0:0/96 100`

- in `/etc/wgetrc` uncomment `use_proxy = on` and add:
```
http_proxy=192.168.49.1:8000
https_proxy=192.168.49.1:8000
```
