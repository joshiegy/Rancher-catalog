version: '2'

services:
  plex:
    container_name: plex
    image: plexinc/pms-docker
    restart: unless-stopped
    ports:
      - 1900:1900/udp 
      - 3005:3005/tcp
      - 8324:8324/tcp
      - 32469:32469/tcp
      - 32410:32410/udp
      - 32412:32412/udp
      - 32413:32413/udp
      - 32414:32414/udp
    environment:
      TZ: ${TZ}
      PLEX_CLAIM: ${claimToken}
    volumes:
      - ${CONFIG_PATH}:/config
      - ${TRANSCODE}:/transcode
      - nfsmedia:/data
  plex-lb:
  scale: 1
  lb_config:
    port_rules:
      - source_port: ${PLEX_PUBLIC_PORT}
        target_port: 32400
        service: plex
        protocol: tcp
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
      strategy: recreate
volumes:
  nfsmedia:
    driver: rancher-nfs
    driver_opts:
      host: ${NFS_SERVER} 
      export: ${NFS_SHARE}
      onRemove: retain

