strange enough after booting up puppet doesn't apply all the configuration correctly,
so you must provision the box again, eg:

```
vagrant up web1
vagrant provision web1
vagrant up web2
vagrant provision web2
```

after that you can connect to web1 to check the setup with:

```
vagrant ssh web1
crm_mon -1
ip addr
curl http://33.33.33.50/
```

from either box, you can see the ip address asigned. Try stopping peacemaker, killing apache, etc... and run the commands again.

