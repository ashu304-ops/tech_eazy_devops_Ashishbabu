#!/bin/bash

JAR_NAME="app.jar"
BUCKET_URL="https://${var.storage_account_name}.blob.core.windows.net/${var.container_name}"

APP_DIR="/home/azureuser/app"
mkdir -p $APP_DIR
cd $APP_DIR

while true; do
    echo "Checking for new app.jar..."
    azcopy copy "${BUCKET_URL}/${JAR_NAME}" "./${JAR_NAME}" --overwrite=true

    if pgrep -f "java -jar"; then
        echo "Killing old process..."
        pkill -f "java -jar"
    fi

    echo "Starting new app..."
    nohup java -jar ${JAR_NAME} > app.log 2>&1 &

    echo "Sleeping for 60 seconds..."
    sleep 60
done
