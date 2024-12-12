#!/bin/bash

echo "=========================================================="
echo "Stopping app on k8"
echo "=========================================================="

#echo "----------------------------------------------------------"
#echo "kubectl -n orders delete deploy browser-traffic"
#echo "----------------------------------------------------------"
#kubectl -n orders delete deploy browser-traffic

echo "----------------------------------------------------------"
echo "kubectl -n orders delete deploy load-traffic"
echo "----------------------------------------------------------"
kubectl -n orders delete deploy load-traffic

echo "----------------------------------------------------------"
echo "kubectl -n orders delete deploy frontend"
echo "----------------------------------------------------------"
kubectl -n orders delete deploy frontend

echo "----------------------------------------------------------"
echo "kubectl -n orders delete deploy catalog"
echo "----------------------------------------------------------"
kubectl -n orders delete deploy catalog

echo "----------------------------------------------------------"
echo "kubectl -n orders delete deploy customer"
echo "----------------------------------------------------------"
kubectl -n orders delete deploy customer

echo "----------------------------------------------------------"
echo "kubectl -n orders delete deploy order"
echo "----------------------------------------------------------"
kubectl -n orders delete deploy order

sleep 10

echo "----------------------------------------------------------"
echo "kubectl -n orders get pods"
echo "----------------------------------------------------------"
kubectl -n orders get pods