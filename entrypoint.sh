#!/bin/sh

cd /v2ray

cat <<-EOF>config.json
{
  "log": {
    "access": "",
    "error": "",
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "protocol": "${PROTO}",
      "port": ${PORT},
      "settings": {
        "clients": [
          {
            "$([ "${PROTO}" = "trojan" ] && echo -n password || echo -n id)": "${UUID}"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws"$([ ${DOMAIN} ] && [ -e cert.pem -a -e key.pem ] && cat <<-EOB
,
        "security": "tls",
        "tlsSettings": {
          "serverName": "${DOMAIN}",
          "certificates": [
            {
              "certificateFile": "cert.pem",
              "keyFile": "key.pem"
            }
          ]
        }
EOB
        )
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
EOF

exec /v2ray/v2ray -config config.json

