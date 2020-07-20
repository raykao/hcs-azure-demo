curl -L https://getenvoy.io/cli | sudo bash -s -- -b /usr/local/bin
getenvoy run standard:1.13.0 -- --version
sudo cp ~/.getenvoy/builds/standard/1.13.0/linux_glibc/bin/envoy /usr/local/bin/