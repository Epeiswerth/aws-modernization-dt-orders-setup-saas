#!/bin/bash

HOST_TYPE=$1
if [ -z "$HOST_TYPE" ]
then
    echo "Missing HOST_TYPE argument"
    exit 1
fi

APP_SCRIPTS_FULL_PATH=/home/dtu_training/aws-modernization-dt-orders-setup/app-scripts

setup_monolith() {
    echo "----------------------------------------------------"
    echo "Setup Monolith Tools"
    echo "----------------------------------------------------"
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io
    apt-get install -y jq
    apt install -y docker-compose

    echo "----------------------------------------------------"
    echo "Start Monolith App"
    echo "----------------------------------------------------"
    . $APP_SCRIPTS_FULL_PATH/start-monolith.sh
}

setup_services() {
    echo "----------------------------------------------------"
    echo "Setup Services Tools"
    echo "----------------------------------------------------"
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io
    apt-get install -y jq
    apt install -y docker-compose
  
    echo "----------------------------------------------------"
    echo "Start Services App"
    echo "----------------------------------------------------"
    . $APP_SCRIPTS_FULL_PATH/start-services.sh
}

setup_k3s() {
    echo "----------------------------------------------------"
    echo "Setup Services Tools"
    echo "----------------------------------------------------"
    apt-get update
    apt-get install -y jq
}

case "$HOST_TYPE" in
    "dt-orders-monolith") 
        echo "===================================================="
        echo "Setting up: $HOST_TYPE" 
        echo "===================================================="
        setup_monolith
        ;;
    "dt-orders-services") 
        echo "===================================================="
        echo "Setting up: $HOST_TYPE" 
        echo "===================================================="
        setup_services
        ;;
    "dt-orders-k3s")
        echo "===================================================="
        echo "Setting up: $HOST_TYPE"
        echo "===================================================="
        setup_services
        ;;
    *) 
        echo "Invalid HOST_TYPE: $HOST_TYPE"
        exit 1
        ;;
esac

echo "===================================================="
echo "Setup Complete" 
echo "===================================================="
echo ""
