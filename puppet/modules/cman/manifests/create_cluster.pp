# http://clusterlabs.org/quickstart-redhat.html
# this just produced the file /etc/cluster/cluster.conf already provided
ccs -f /etc/cluster/cluster.conf --createcluster web
ccs -f /etc/cluster/cluster.conf --addnode web1
ccs -f /etc/cluster/cluster.conf --addnode web2

ccs -f /etc/cluster/cluster.conf --addfencedev pcmk agent=fence_pcmk
ccs -f /etc/cluster/cluster.conf --addmethod pcmk-redirect web1
ccs -f /etc/cluster/cluster.conf --addmethod pcmk-redirect web2

ccs -f /etc/cluster/cluster.conf --addfenceinst pcmk web1 pcmk-redirect port=web1
ccs -f /etc/cluster/cluster.conf --addfenceinst pcmk web2 pcmk-redirect port=web2
