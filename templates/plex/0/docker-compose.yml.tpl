version: '2'
services:
  plex:
    container_name: plex
    image: plexinc/pms-docker
    restart: unless-stopped
    ports:
      - 32400:32400/tcp
      - 3005:3005/tcp
      - 8324:8324/tcp
      - 32469:32469/tcp
      - 1900:1900/udp
      - 32410:32410/udp
      - 32412:32412/udp
      - 32413:32413/udp
      - 32414:32414/udp
    environment:
      TZ: ${TZ}
      PLEX_CLAIM: ${claimToken}
      ADVERTISE_IP: ${Advertise_IP}/
    volumes:
      - ${CONFIG_PATH}:/config
      - ${TRANSCODE}:/transcode
      - nfsmedia:/data
volumes:
  nfsmedia:
    driver: rancher-nfs
    driver_opts:
      host: ${NFS_SERVER} 
      export: ${NFS_SHARE}
      onRemove: retain

