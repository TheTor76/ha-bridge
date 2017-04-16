# ha-bridge
ha-bridge docker container similar to this [ha-bridge image](https://github.com/aptalca/docker-ha-bridge) but not running as root, using ubuntu as it's base image, and it allows you to run the container as read only and have the bridge configuration reset (either blank config or using the config files included in the startup-config directory) on the container restarting

also includes scripts in /ha-bridge-scripts to send off/on command to [hs100/hs110 api](https://hub.docker.com/r/snipzwolf/hs100-api-endpoint/)

## Example usage
```
docker run -d --read-only --restart=always \
       --tmpfs=/config/data/:uid=99,gid=100 \
       -e SERVERIP="192.168.86.100" -p 80:80 \
       --net="host" \
       -v /etc/localtime:/etc/localtime:ro \
       -v /etc/timezone:/etc/timezone:ro \
       -v /some_path/device.db:/config/startup-config/device.db:ro \
       -v /some_path/habridge.config:/config/startup-config/habridge.config:ro \
       --name ha-bridge ha-bridge
```
