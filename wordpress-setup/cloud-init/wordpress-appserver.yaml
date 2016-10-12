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

manage_etc_hosts: true

packages:
  - nginx
  - curl
  - unzip
  - attr
  - glusterfs-client
  - php-fpm
  - php-mysql

write_files:
  - content: |
      #!/usr/bin/env bash
      export DEBIAN_FRONTEND=noninteractive
      apt-get install -y python-software-properties;
      add-apt-repository -y ppa:gluster/glusterfs-3.5;
      /tmp/consul-install-client.sh
      sleep 60;
      sed -i s/\;cgi\.fix_pathinfo\=1/cgi\.fix_pathinfo\=0/g /etc/php/7.0/fpm/php.ini
      mkdir /gluster
      export master=$(dig +short @127.0.0.1 -p 8600 terra-wordpress-storage-master0.node.consul)
      mount -t glusterfs $master:/file_store /gluster
      mkdir /gluster/www
      mkdir -p /etc/nginx/sites-enabled/
      wget https://raw.githubusercontent.com/funkestefan/terraform-examples/master/wordpress-setup/conf/nginx-appserver.default -O /etc/nginx/sites-enabled/default
      service nginx restart
      /tmp/install_wp.sh

    permissions: 0700
    path: /tmp/install_appserver.sh
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
             "start_join": ["192.168.42.2", "192.168.42.3", "192.168.42.4"],
             "server": false
       }
       EOF
       cat <<EOF> /etc/consul.d/app-service.json
       {
             "service": {
               "name": "nginx",
               "tags": ["nginx", "web"],
               "port": 80,
               "checks": [
                 {
                   "tcp": "localhost:80",
                   "interval": "10s"
                 }
               ]
             }
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
    path: /tmp/consul-install-client.sh
    owner: root
    permissions: 0700
  - content: |
      #!/usr/bin/env bash

      if [ ! -e /gluster/www/wp-config.php ]; then

      export dbhost=$(dig +short @127.0.0.1 -p 8600 terra-wordpress-db.node.consul)

      wget https://wordpress.org/latest.tar.gz -O /root/wp.tar.gz;
      tar -zxf /root/wp.tar.gz -C /root/;
      cp -Rf /root/wordpress/* /gluster/www/.;
      cp /gluster/www/wp-config-sample.php /gluster/www/wp-config.php;
      sed -i "s/'DB_NAME', 'database_name_here'/'DB_NAME', 'wordpress'/g" /gluster/www/wp-config.php;
      sed -i "s/'DB_USER', 'username_here'/'DB_USER', 'wordpress'/g" /gluster/www/wp-config.php;
      sed -i "s/'DB_PASSWORD', 'password_here'/'DB_PASSWORD', 'mysql_password'/g" /gluster/www/wp-config.php;
      sed -i "s/'DB_HOST', 'localhost'/'DB_HOST', '$dbhost'/g" /gluster/www/wp-config.php;
      chown -Rf www-data:www-data /gluster/www;

      fi

    permissions: 0700
    path: /tmp/install_wp.sh

runcmd:
   - /tmp/install_appserver.sh
