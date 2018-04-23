version: '2'
services:
  gitea:
    networks:
      - gitea
    image: gitea/gitea:1.3.0
    expose:
      - "22"
      - "3000"
    volumes:
      - gitea-data:/data
{{- if ne .Values.db_link ""}}
    external_links:
      - ${db_link}:db
{{- else}}
    links:
      - db:db
  db:
    image: mariadb:10
    networks:
      - gitea
    environment:
      MYSQL_ROOT_PASSWORD: ${mysql_password}
      MYSQL_DATABASE: 'gitea'
    volumes:
      - gitea-db:/var/lib/mysql
{{- end}}
  lb:
    image: rancher/lb-service-haproxy:v0.7.9
    networks:
      - gitea
    ports:
    - ${http_port}:${http_port}:/tcp
    - ${ssh_port}:${ssh_port}:/tcp
volumes:
  gitea-data:
    driver: ${volume_driver}
{{- if eq .Values.db_link ""}}
  gitea-db:
    driver: ${volume_driver}
{{- end}}

networks:
  gitea:
