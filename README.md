# devops-app-infra
This repository is the infrastructure for the Devops-app Project.


# Observability
In this part, we will focus on the three pillars of Observability:

## 1. Metrics
We used Prometheus to collect metrics from the FastAPI application with the use of Prometheus Client that helps you to get metrics from the endpoint /metrics, then we can use Grafana to visualize the metrics stream in real-time a time series database.
![prometheus](https://user-images.githubusercontent.com/60546216/213249096-e29606f5-61cb-4d15-81ed-1f04e4b974d5.png)


## 2. Logs
In order to enable logging in our application, DataDog was the primary choice as it allowed an intuitive User Interface and setting the agent was fairly simple as it was packaged in a Helm Chart with basic configuration.
We also made sure to add the ``request_id`` in every log so that it can help us while debugging.
![log](https://user-images.githubusercontent.com/60546216/213249870-2947b422-f76a-456b-8d18-3a6a887e4580.png)


## 3. Traces
We opted for DataDog as it was natively adapted for such task and the agent was aleady deployed for logs collection. 

# Automation

## 1. Automated infrastructure provisioning using well isolated and maintainable infrastructure layers (Microstacks)
We used **Terraform** to build 3 microstacks:

1. **First Stack : Kubernetes Cluster :** We provisioned in this stack an AKS cluster and of course a resource group as well.

2. **Second Stack : Monitoring Setup :** We created the monitoring setup for our application using Kubernetes provider as well as Helm provider. 
We split those different charts into 3 ``modules`` : argocd, datadog and prometheus so we can reuse them whenever.

3. **Third Stack : Storage :** here we provisioned the **Azure Storage Blob** in which we will store the treated images after the inference process.


## 2. Automated Deployment

To automate the deployment, we created a **Helm Chart** for it which will be used by **Argo CD**. Basically each time argo cd detects a change in the chart in this repo, it will automatically synchronize the application thus resulting in automated deployment.

To be noted, we can multiple additional labels to a deployment, we can change the image name and/or tag, we can specify the number of replicas,... The values that you can change can be visualized in the ``values.yaml`` file.

We used **Argo CD** to automate deployment of my chart from my github repo.
![argocd](https://user-images.githubusercontent.com/60546216/213249199-8cdb980f-e496-4a1b-9a92-b04b24287ff3.png)

## 3. Multi-environment setup

To be able to use multiple environments, we created three files : ``values-pre-prod.yaml``, ``values-prod.yaml`` and ``values.yaml`` for the development environment in order to patch the environment name.


# Deployment
We built both training and inference images using Docker then we will use Kubernetes to deploy the cluster in Microsoft Azure.
![azure](https://user-images.githubusercontent.com/60546216/213249154-0519dab3-7ff8-4cfd-bdd5-699da4d4cc09.png)

## Deployment architecture

This is the architecture for the Monitoring setup :
![architecture](https://user-images.githubusercontent.com/60546216/213249064-fe08696f-0e09-456d-986d-244d9d8764f2.png)


We used Helm Charts to deploy the inference process.

## Deployment strategy
We decided to use the Blue/Green deployment strategy since it gives us instant rollout and rollback.
We created two yaml files: values-blue.yaml and values-green.yaml, then we created a rollout because it can easily work with Argo CD: when we change the version and synch the application it will create all the kubernetes resources with the new version.
