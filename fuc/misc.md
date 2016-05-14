MISC
====

```bash
# log directory
$ pushd /var/log
```

```bash
# arp-scan
$ arp-scan -I wlp1s0 -l
```

```bash
# purge old linux-image
$ dpkg --get-selections | grep linux-image
$ sudo aptitude purge linux-image-?.?.?-??-generic linux-image-extra-?.?.?-??-generic
```

```bash
# ansible
$ ansible-playbook playbook.yml -i ./hosts -C --ask-vault-pass
```
