#!/bin/bash
#set -xe
rep_name=$(helm repo list | awk '{print $1}' | grep metallb)
if [[ $rep_name != 'metallb' ]]; then
	echo "Adding metallb in helm repo" 
	helm repo add metallb https://metallb.github.io/metallb
	helm repo update
else
	echo "Repo is alreday added."
fi		

metalns=$(kubectl get ns | awk '{print $1}'| grep metallb)

if [[ $metalns != 'metallb' ]]; then
	echo "Creating metallb namespace..."
	kubectl create ns metallb
else	
	echo "metallb namespace is already created."
fi
echo ">>>> Deploying MetalLB"
helm install metallb metallb/metallb -n metallb --wait --timeout 3m
echo "==================================================================================="
echo ">>>> Creating metalLB IP Pool"
kubectl create -f mlb.yaml
kubectl create -f mlb-l2.yaml
