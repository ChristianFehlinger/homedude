# Setup
This all runs on a rpi 4.


# Home Assistant
The [Home assistant](https://www.home-assistant.io/) is running in a container, becuase i wanted to use the pi for other projects as well.  


```yaml
# HomeAssistant
  homeassistant:
    container_name: home-assistant
    image: ghcr.io/home-assistant/raspberrypi3-homeassistant:stable
    logging:
      driver: "json-file"
      options:
        max-size: "2g"
        max-file: "3"
    volumes:
      # Local path to the ha config
      - /home/pi/homeassistant/config:/config
      - /etc/localtime:/etc/localtime:ro
      - /var/run/docker.sock:/var/run/docker.sock
    privileged: true
    devices:
    # JeeLink USB-Stick
    - /dev/ttyUSB0:/dev/ttyUSB0
    restart: unless-stopped
    network_mode: host
```

# AppDaemon

```yaml
# AppDaemon
  appdaemon:
    container_name: appdaemon
    image: acockburn/appdaemon:latest  
    environment:
      - HA_URL
      - TOKEN=$APPDAEMONTOKEN
      - DASH_URL
      - TZ=Europe/Berlin
    volumes:
      - /home/pi/homeassistant/appdaemon/conf:/conf
      - /etc/localtime:/etc/localtime:ro
    ports:
      - 5050:5050
```

# Mosquitto

```yaml
# MQTT
  mosquitto:
    container_name: mosquitto
    image: eclipse-mosquitto:2
    volumes:
      - /home/pi/homeassistant/mosquitto:/mosquitto/:rw
    ports:
      - 1883:1883
      - 9001:9001


# Links
- [Home assistant](https://www.home-assistant.io/)
