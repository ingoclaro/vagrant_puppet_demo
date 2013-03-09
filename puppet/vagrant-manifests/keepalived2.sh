rpm -Uvh http://svn.riviera.org.uk/repo/RPMS/keepalived/RPMS/x86_64/keepalived-1.2.1-5.el5.x86_64.rpm

# http://www.sebastien-han.fr/blog/2012/04/15/active-passive-failover-cluster-on-a-mysql-galera-cluster-with-haproxy-lsb-agent/
# http://www.sebastien-han.fr/blog/2012/05/13/active-passive-failover-using-keepalived-on-a-galera-cluster-with-haproxy/

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
