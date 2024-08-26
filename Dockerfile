# using pihole docker image
FROM pihole/pihole:2024.07.0
# install unbound
RUN apt update && apt install -y unbound

# download root.hints files
RUN curl -o /var/lib/unbound/root.hints https://www.internic.net/domain/named.root

# copy unbound setup
COPY lighttpd-external.conf /etc/lighttpd/external.conf 
COPY unbound-pihole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
COPY 99-edns.conf /etc/dnsmasq.d/99-edns.conf
RUN mkdir -p /etc/services.d/unbound
COPY unbound-run /etc/services.d/unbound/run
RUN chmod +x /etc/services.d/unbound/run

ENTRYPOINT ./s6-init
