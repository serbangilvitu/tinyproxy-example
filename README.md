# tinyproxy example

## Building the image
```
docker build . -t tinyproxy:local
```

## Running the proxy
By default, the proxy will allow connections from 192.168.0.0/16 172.16.0.0/12 as specified in the ALLOW_LIST environment variable.
```
docker run -d -p 8888:8888 --name tiny tinyproxy:local
```
To allow different IP ranges, overwrite the ALLOW_LIST variable
```
docker run -d -p 8888:8888 \
  --name tiny \
  -e ALLOW_LIST="10.0.0.0/16" \
  tinyproxy:local
```

## Testing the proxy

```
curl -vI -x http://localhost:8888 https://www.example.com
```
Partial output
```
*   Trying 127.0.0.1:8888...
* TCP_NODELAY set
* Connected to localhost (127.0.0.1) port 8888 (#0)
* allocate connect buffer!
* Establish HTTP proxy tunnel to www.example.com:443
> CONNECT www.example.com:443 HTTP/1.1
> Host: www.example.com:443
> User-Agent: curl/7.68.0
> Proxy-Connection: Keep-Alive
> 
< HTTP/1.0 200 Connection established
HTTP/1.0 200 Connection established
< Proxy-agent: tinyproxy/1.10.0
Proxy-agent: tinyproxy/1.10.0
< 

* Proxy replied 200 to CONNECT request
* CONNECT phase completed!
```