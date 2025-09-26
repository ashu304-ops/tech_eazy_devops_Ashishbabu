#!/bin/bash
yum install -y aws-cli

# Dummy app log
echo "App log - $(date)" > /var/log/app.log

# Upload logs script
cat <<EOF > /opt/upload_logs.sh
#!/bin/bash
aws s3 cp /var/log/cloud-init.log s3://$${bucket_name}/ec2-logs/cloud-init.log
aws s3 cp /var/log/app.log s3://$${bucket_name}/app/logs/app.log
EOF

chmod +x /opt/upload_logs.sh

# Systemd unit to upload logs at shutdown
cat <<EOF > /etc/systemd/system/upload-logs.service
[Unit]
Description=Upload logs to S3
DefaultDependencies=no
Before=shutdown.target

[Service]
ExecStart=/opt/upload_logs.sh
Type=oneshot
RemainAfterExit=true

[Install]
WantedBy=multi-user.target
EOF

systemctl enable upload-logs.service
