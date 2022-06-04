
------------
Provisioning scripts
------------


## PDANet+ proxy settings:
---------

- Settings
```
192.168.49.1
8000
```

- /etc/apt/apt.conf.d/proxy.conf
```
Acquire {
  HTTP::proxy "http://192.168.49.1:8000/";
  HTTPS::proxy "http://192.168.49.1:8000/";
}
```

- snap
```
sudo snap unset system proxy.http="http://192.168.49.1:8000"
sudo snap unset system proxy.https="http://192.168.49.1:8000"
```

- /etc/gai.conf
```
precedence ::ffff:0:0/96 100
```


- /etc/wgetrc
```
use_proxy = on
http_proxy=192.168.49.1:8000
https_proxy=192.168.49.1:8000
```
