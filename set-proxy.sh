#! /bin/bash

wget -O clash.gz https://ghproxy.com/https://github.com/Dreamacro/clash/releases/download/v1.10.0/clash-linux-amd64-v1.10.0.gz
gzip -dc clash.gz > /usr/local/bin/clash
chmod +x /usr/local/bin/clash
rm -f clash.gz

mkdir /etc/clash
wget -O /etc/clash/Country.mmdb https://ghproxy.com/https://github.com/Dreamacro/maxmind-geoip/releases/latest/download/Country.mmdb

cat>/etc/systemd/system/clash.service<<EOF
[Unit]
Description=clash daemon

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/clash -d /etc/clash/
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
#可修改订阅地址【https://acl4ssr-sub.github.io/】
wget -O /etc/clash/config.yaml https://suo.yt/olkYofI

cat>/etc/profile.d/proxy.sh<<EOF
export http_proxy="127.0.0.1:7890"
export https_proxy="127.0.0.1:7890"
export no_proxy="localhost, 127.0.0.1"
EOF

source /etc/profile

systemctl start clash
systemctl enable clash