version: '3'
services:
  homeassistant:
    container_name: home-assistant
    image: homeassistant/home-assistant
    volumes:
      - nfs:/config
      - /etc/localtime:/etc/localtime:ro
    devices:
      - /dev/ttyUSB0:/dev/ttyUSB0
      - /dev/ttyUSB1:/dev/ttyUSB1
      - /dev/ttyACM0:/dev/ttyACM0
    restart: always
    network_mode: host   
volumes:
  nfs:
    driver: rancher-nfs
    driver_opts:
      host: ${NFS_SERVER} 
      export: ${NFS_SHARE}
      onRemove: retain

