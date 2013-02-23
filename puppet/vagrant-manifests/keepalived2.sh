rpm -Uvh http://svn.riviera.org.uk/repo/RPMS/keepalived/RPMS/x86_64/keepalived-1.2.1-5.el5.x86_64.rpm

/etc/keepalived/keepalived.conf:

vrrp_script chk_haproxy {
    script "killall -0 haproxy" # verify the pid is exist or not
    interval 1                      # check every 2 seconds
    weight 2                        # add 2 points of prio if OK
}

vrrp_instance VI_1 {
    interface eth1
    state MASTER
    virtual_router_id 51
    priority 100
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    virtual_ipaddress {
        33.33.22.10
    }
    track_script {
        chk_haproxy
    }
}
