# xh
Friendly and fast tool for sending HTTP requests. https://github.com/ducaale/xh
```bash
# Send a GET request
xh httpbin.org/json

# Send a POST request with body {"name": "ahmed", "age": 24}
xh httpbin.org/post name=ahmed age:=24

# Send a GET request with querystring id=5&sort=true
xh get httpbin.org/json id==5 sort==true

# Send a GET request and include a header named x-api-key with value 12345
xh get httpbin.org/json x-api-key:12345

# Send a POST request with body read from stdin.
echo "[1, 2, 3]" | xh post httpbin.org/post

# Send a PUT request and pipe the result to less
xh put httpbin.org/put id:=49 age:=25 | less

# Download and save to res.json
xh -d httpbin.org/json -o res.json

# Make a request with a custom user agent
xh httpbin.org/get user-agent:foobar
```
