#!/bin/bash

echo "=========================================================="
echo "Starting app on k8"
echo "=========================================================="

echo "----------------------------------------------------------"
echo "kubectl create namespace orders"
echo "----------------------------------------------------------"
kubectl create ns orders

#echo "----------------------------------------------------------"
#echo "kubectl create -f manifests/dynatrace-oneagent-metadata-viewer.yaml"
#echo "----------------------------------------------------------"
#kubectl create -f manifests/dynatrace-oneagent-metadata-viewer.yaml

echo "----------------------------------------------------------"
echo "kubectl -n orders apply -f catalog-service.yml"
echo "----------------------------------------------------------"
kubectl -n orders apply -f manifests/catalog-service.yml

echo "----------------------------------------------------------"
echo "kubectl -n orders apply -f manifests/customer-service.yml"
echo "----------------------------------------------------------"
kubectl -n orders apply -f manifests/customer-service.yml

echo "----------------------------------------------------------"
echo "kubectl -n orders apply -f manifests/order-service.yml"
echo "----------------------------------------------------------"
kubectl -n orders apply -f manifests/order-service.yml

echo "----------------------------------------------------------"
echo "kubectl -n orders apply -f manifests/frontend.yml"
echo "----------------------------------------------------------"
kubectl -n orders apply -f manifests/frontend.yml

#echo "----------------------------------------------------------"
#echo "kubectl -n orders apply -f manifests/browser-traffic.yml"
#echo "----------------------------------------------------------"
#kubectl -n orders apply -f manifests/browser-traffic.yml

echo "----------------------------------------------------------"
echo "kubectl -n orders apply -f manifests/load-traffic.yml"
echo "----------------------------------------------------------"
kubectl -n orders apply -f manifests/load-traffic.yml

echo "----------------------------------------------------------"
echo "kubectl -n orders get pods"
echo "----------------------------------------------------------"
sleep 5
kubectl -n orders get pods