version: '2'
services:
  homeassistant:
    container_name: home-assistant
    image: homeassistant/home-assistant
    volumes:
      - nfs:/config
      - /etc/localtime:/etc/localtime:ro
    devices:
{{ if eq .Values.ttyUSB0 "true" }}      - /dev/ttyUSB0:/dev/ttyUSB0 {{ end }}
{{ if eq .Values.ttyUSB1 "true" }}      - /dev/ttyUSB1:/dev/ttyUSB1 {{ end }}
{{ if eq .Values.ttyACM0 "true" }}      - /dev/ttyACM0:/dev/ttyACM0 {{ end }}
    restart: always
    network_mode: host   
volumes:
  nfs:
    driver: rancher-nfs
    driver_opts:
      host: ${NFS_SERVER} 
      export: ${NFS_SHARE}
      onRemove: retain

