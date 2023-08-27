# IPSetup  
  
## IPv4  
```
144.76.116.113
```
  
## IPv6  
  
### Subnet  
```
2a01:4f8:192:7157::/64
```

### Subnet Split  

### traefik
docker network create --ipv6 --subnet fd00::f:0:0/96 traefik

### Docker  
`/etc/docker/daemon.json`  
```
{
  "ipv6": true,
  "fixed-cidr-v6": "fd00::1:0:0/96",
  "experimental": true,
  "ip6tables": true,
  "default-address-pools": [
    {
      "base": "172.17.0.0/16",
      "size": 16
    },
    {
      "base": "172.18.0.0/16",
      "size": 16
    },
    {
      "base": "172.19.0.0/16",
      "size": 16
    },
    {
      "base": "172.20.0.0/14",
      "size": 16
    },
    {
      "base": "172.24.0.0/14",
      "size": 16
    },
    {
      "base": "172.28.0.0/14",
      "size": 16
    },
    {
      "base": "192.168.0.0/16",
      "size": 24
    },
    {
      "base": "fd00::a:0:0/96",
      "size": 112
    }
  ]
}
```