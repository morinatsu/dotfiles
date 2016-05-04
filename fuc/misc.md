MISC
====

```bash
# netstat
$ netstat -lna -f inet
```

```bash
$ grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}'
$ grep -Ei 'fatal|error|warning|failed'
$ grep -E '^(  [15]|19[78]|#)'
```

```bash
# sar
$ sar -s 11:46:00 -e 12:22:00
```

```bash
# cpu core
$ sar -q -s 11:46:00 -e 12:22:00
```

```bash
# memory
$ sar -r -s 11:46:00 -e 12:22:00
```

```bash
# socket
$ sar -n SOCK -s 11:46:00 -e 12:22:00
```

```bash
# packet loss
$ sar -n EDEV | grep -E '(eth|IFACE)' | grep -v '0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00'
```

```bash
# whether dropped
$ sar -n EDEV | grep -E '(eth|IFACE)'
```

```bash
# conntrack
# -E: display a real time event log
$ conntrack -E -s <ip>
$ conntrack -E -d <ip>
$ conntrack -E -s <ip> -p tcp --state SYN_SENT --orig-port-dst 22
```

```bash
# strip from/to address
$ tail -30000 /var/log/maillog | awk '/(from|to)=/ {print $7}' | sort | uniq -c | sort -n | tail
```

```bash
# list interface info
$ ip a show dev eth0

# up/down
$ ip l set eth1 up
$ ip l set eth1 down
$ nmcli c down eth1
$ nmcli c up eth1

# list routing table
$ ip r

# set default gateway
$ ip route add default via 192.168.0.1
$ ip route del default via 192.168.0.1

# list packets
$ netstat -i
$ ip -s l

# list socket
$ netstat -natu
$ ss -natu

# list arp table
$ arp -n
$ ip n

# disable arp table
$ arp -d 192.168.0.1 -i eth0
$ ip n flush 192.168.0.1 dev eth0
$ ip n del 192.168.0.1 dev eth0
```

```bash
# search keyword
# y: look, n: skip, q: stop
man -K h_name
```
