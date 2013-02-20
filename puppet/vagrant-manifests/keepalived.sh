rpm -Uvh http://svn.riviera.org.uk/repo/RPMS/keepalived/RPMS/x86_64/keepalived-1.2.1-5.el5.x86_64.rpm

/etc/keepalived/keepalived.conf:

# Configuration File for keepalived
global_defs {
   router_id LVS_TEST
}

vrrp_instance VI_1 {
    state MASTER
    interface eth1
    virtual_router_id 51
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    virtual_ipaddress {
        33.33.22.10 dev eth1
    }
}

virtual_server 33.33.22.10 80 {
    delay_loop 3
    lb_algo rr
    lb_kind DR
    nat_mask 255.255.255.0
    persistence_timeout 9600
    protocol TCP

    real_server 33.33.22.11 80 {
        weight 50
        TCP_CHECK {
          connect_timeout 3
          connect_port    80
        }
    }

    real_server 33.33.22.12 80 {
        weight 50
        TCP_CHECK {
          connect_timeout 3
          connect_port    80
        }
    }

}
