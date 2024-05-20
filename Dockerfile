# using pihole docker image
FROM pihole/pihole:2024.05.0
# install unbound
RUN apt update && apt install -y unbound

# copy unbound setup
COPY lighttpd-external.conf /etc/lighttpd/external.conf 
COPY unbound-pihole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
COPY 99-edns.conf /etc/dnsmasq.d/99-edns.conf
RUN mkdir -p /etc/services.d/unbound
COPY unbound-run /etc/services.d/unbound/run
RUN chmod +x /etc/services.d/unbound/run

ENTRYPOINT ./s6-init
