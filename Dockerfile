# using pihole docker image
FROM pihole/pihole:2025.02.2
# install unbound
RUN apk update && apk add unbound

# download root.hints files
RUN mkdir -p /var/lib/unbound
RUN curl -o /var/lib/unbound/root.hints https://www.internic.net/domain/named.root

# copy unbound setup
COPY lighttpd-external.conf /etc/lighttpd/external.conf 
COPY unbound-pihole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
COPY 99-edns.conf /etc/dnsmasq.d/99-edns.conf
#RUN mkdir -p /etc/services.d/unbound
#COPY unbound-run /etc/services.d/unbound/run
#RUN chmod +x /etc/services.d/unbound/run

COPY custom-entrypoint.sh /custom-entrypoint.sh
RUN chmod +x /custom-entrypoint.sh

ENTRYPOINT ["/custom-entrypoint.sh"]
