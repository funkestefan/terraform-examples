#cloud-config

users:
  - name: stefan
    gecos: Stefan Funke
    lock-passwd: true
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh-authorized-keys:
      - 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC9UGfpRQ1juRDlsMfGM2lXTeQXSn3cFBmWHCdMya0DAtWNxKRT6O6R62bZOGI4wSQVR3ICKMfij9YAD4AnkYl4HkibYnm2fmD8vQphCdlv7vQnKv5IYYv+KNPpoLB/RQthG1SbIaf8GMNoPiA+8YABapdSgEAbqAoX4WBA2qPNG5VKHYy1lqGh/CJLzSf/PhbjAz7+7Xg3Y+BOz8R+zO+XpAGVqbS6CIIP/x5wvqy7hOmeV2TaqA7jtnx++gWDDQUAUpSalV6T7XIZo6s3+bqhse1uWFKpXmQlqs1ZvEi0wAE6feftbdId9K2KBMyHXiLL+0ds/QWwfb6AYeMp6IHp/5nafVW2gIKKBah0bwdzjMuNr/SMwdYjM6YjB8NJkDqcsLNFkduvvjsGgpr66O+FhacsR9X2ZD1kFCo9fwOqjHWsAlt62P0EaVQ1tuwveHz7U35tJCS+3AFMox5L4pcRc3zKzN3OSkklt+lWpKqQsXlvwvEnSSFayIy9zDGnNkh0Megh2W++yGr9U7h4Ns/LV7P8+uFcHtfZ4zRCrf/SxGEcxDfJHZHqlmRD/gOeJYED2d4X50FCFpogdkE7cc/oEyxyVR10R/G7YPxeqLxINwFMjybOgdo2f4A4VlTwy9qQ10yqS87eP/ycCVhxOm//iu0f5KkNQ28VRebK0Wuq4Q== bundy@wasp'
      - 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDzJ51cNXJJWfW+EehZFt9YoUi+dNmXaAjoi6vqPhEZHNXzYRpwy/iyR+y2S1ItGdaypMutehPIuXK6RtBdpTG/blnlmmA9ASrYuqh5qsI5b78eSITMfDKnMd55ccjqZ8sIC/DZAaPVv5VOEJEmZniO+6JwDq0+A9tSOf/ZHWDVhrbKTN4O55WYnrPvJupuA1xP5YEOwF86atx8AwSDELiecZh34o6V0EbkQCvaRAMluph4EoDPqbE0RxdcHF0XueME3P2MDdV813UCdl7ka6qaoKkPJTM7Or0xOlqtQybXTLgebR9JgeihRZgnio/K06eSmK4p2aPm0p5SV93WcxkW/XM2U+lXEL21bjbYXL5nr7UzBptsqG7/GHCJD7PqssYZdXV+l/rKR50PqGsKBhbiImk0T8IVvznt/H9f35YLADiRt9VlRe7uURMO5VkWnY9aYsvvxv/Z3H2hqssbPT1H+zqqWI4EZi6++GpeRbL/aLNz0s6e53yerhZHNZtN1CkRmO2YI83I4BtbeO8rIuxZM8AOJ+vMdXJbtQFZT8cHPfB8grt6rCUf/HderR8eulXgkmRROchXAAm9uK1Dm5O07up8qVu9ODWajVUD+X2uYFYf3wQ1w5y3Hdx3rZrH2Cs3qjL3VhYyG84NoJZBdTPPp80MaAWdaRNtoHOfVZY3KQ== SFunke'

package_update: true
package_upgrade: true

hostname: terra-wordpress-lb0
manage_etc_hosts: true

packages:
  - nginx
  - curl
  - unzip
  - dnsmasq

write_files:
  - content: |
      #!/usr/bin/env bash
      export DEBIAN_FRONTEND=noninteractive
      mv /etc/nginx/nginx_template.conf /etc/nginx/nginx.conf
      wget https://raw.githubusercontent.com/funkestefan/terraform-examples/master/wordpress-setup/conf/nginx-lb.default -O /etc/nginx/sites-enabled/default
      # configure core nginx
      cat <<EOF> /etc/nginx/nginx.conf
      user www-data;
      worker_processes auto;
      pid /run/nginx.pid;

      events {
        worker_connections 768;
      }

      http {
        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 65;
        types_hash_max_size 2048;
        include /etc/nginx/mime.types;
        default_type application/octet-stream;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
        ssl_prefer_server_ciphers on;
        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;
        gzip on;
        gzip_disable "msie6";

        include /etc/nginx/upstream.conf;
        include /etc/nginx/sites-enabled/*;
      }
      EOF
      service nginx restart
      /tmp/consul-install.sh
      /tmp/consul-template-install.sh
      until consul join 192.168.42.2 192.168.42.3 192.168.42.4; do sleep 2; done
      # setup dnsmasq to communicate via consul
      echo "server=/consul./127.0.0.1#8600" > /etc/dnsmasq.d/10-consul
      systemctl restart dnsmasq
      echo "${foobar}" >/tmp/testfall
    permissions: 0700
    path: /tmp/install_lb.sh
  - content: |
       #!/usr/bin/env bash
       until id stefan > /dev/null; do sleep 2; done
       url="https://releases.hashicorp.com/consul/0.7.0/consul_0.7.0_linux_amd64.zip"
       bin="/usr/local/bin"
       tmp="/tmp/consul.zip"
       /bin/mkdir -p $bin
       /usr/bin/curl -s -o $tmp $url
       /usr/bin/unzip -q $tmp -d $bin
       /bin/chown root:root $bin/consul
       if [ -f $tmp ]; then rm $tmp; fi
       if [ ! -x $bin/consul ]; then exit 99; fi
       mkdir -p /etc/consul.d
       cat <<EOF> /etc/consul.d/consul.json
       {
             "datacenter": "cbk1",
             "data_dir": "/tmp/consul",
             "bootstrap_expect": 3,
             "server": true
       }
       EOF
       
       cat <<EOF> /etc/systemd/system/consul.service
       [Unit]
       Description=consul agent
       Requires=network-online.target
       After=network-online.target
       
       [Service]
       User=root
       EnvironmentFile=-/etc/default/consul
       Environment=GOMAXPROCS=2
       Restart=on-failure
       ExecStart=/usr/local/bin/consul agent \$OPTIONS -config-dir=/etc/consul.d
       ExecReload=/bin/kill -HUP \$MAINPID
       KillSignal=SIGINT
       
       [Install]
       WantedBy=multi-user.target
       EOF
       
       systemctl enable consul
       systemctl restart consul
    path: /tmp/consul-install.sh
    owner: root
    permissions: 0700
  - content: |
       #!/usr/bin/env bash
       until id stefan > /dev/null; do sleep 2; done
       url="https://releases.hashicorp.com/consul-template/0.16.0/consul-template_0.16.0_linux_amd64.zip"
       bin="/usr/local/bin"
       tmp="/tmp/consul-template.zip"
       /bin/mkdir -p $bin
       /usr/bin/curl -s -o $tmp $url
       /usr/bin/unzip -q $tmp -d $bin
       /bin/chown root:root $bin/consul-template
       if [ -f $tmp ]; then rm $tmp; fi
       if [ ! -x $bin/consul ]; then exit 99; fi
       mkdir -p /etc/consul.d
       # generate a upstream-template used by consul-template
       cat <<EOF> /opt/consul-http-upstreams.ctpl
       upstream wp-appserver  {
         least_conn;
         {{range service "nginx"}}server {{.Address}}:{{.Port}} max_fails=3 fail_timeout=60 weight=1;
         {{else}}server 127.0.0.1:65535; # force a 502{{end}}
       }
       EOF
       
       # configure and run consul-template for nginx:
       
       cat <<EOF> /etc/systemd/system/consultemplate-upstreams.service
       [Unit]
       Description=consul-template for nginx upstreams
       Requires=network-online.target
       After=network-online.target
       
       [Service]
       User=root
       EnvironmentFile=-/etc/default/consul-template
       Environment=GOMAXPROCS=2
       Restart=on-failure
       ExecStart=/usr/local/bin/consul-template -template "/opt/consul-http-upstreams.ctpl:/etc/nginx/upstream.conf:service nginx restart"
       ExecReload=/bin/kill -HUP \$MAINPID
       KillSignal=SIGINT
       
       [Install]
       WantedBy=multi-user.target
       EOF
       
       systemctl enable consultemplate-upstreams
       systemctl restart consultemplate-upstreams
    path: /tmp/consul-template-install.sh
    owner: root
    permissions: 0700

runcmd:
   - /tmp/install_lb.sh
