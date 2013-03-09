rpm -Uvh http://svn.riviera.org.uk/repo/RPMS/keepalived/RPMS/x86_64/keepalived-1.2.1-5.el5.x86_64.rpm

# http://www.keepalived.org/LVS-NAT-Keepalived-HOWTO.html

/etc/keepalived/keepalived.conf:

# Configuration File for keepalived

vrrp_sync_group VG1 {
   group {
      VI_1
      VI_GATEWAY
   }
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
        33.33.22.10
    }
}

vrrp_instance VI_GATEWAY {
    state MASTER
    interface eth2
    virtual_router_id 51
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    virtual_ipaddress {
        33.33.33.1
    }
}


virtual_server 33.33.22.10 80 {
    delay_loop 3
    lb_algo rr
    lb_kind NAT
    nat_mask 255.255.255.0
    persistence_timeout 9600
    protocol TCP

    virtualhost www.example.com

    real_server 33.33.33.51 80 {
        weight 50
        HTTP_GET {
            url {
                    path /heartbeat.txt
                    digest 422834d1d2b972eee9e5b875e4bd8c33
            }
            connect_timeout 10
            nb_get_retry 3
            delay_before_retry 10
            connect_port 80
        }
    }

    real_server 33.33.33.52 80 {
        weight 50
        HTTP_GET {
            url {
                    path /heartbeat.txt
                    digest 422834d1d2b972eee9e5b875e4bd8c33
            }
            connect_timeout 10
            nb_get_retry 3
            delay_before_retry 10
            connect_port 80
        }
    }

}
