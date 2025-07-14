# Rapyd Sentinel: EKS Multi-VPC Microservices Proof of Concept
_Isolated microservice-to-microservice communication over VPC peering using EKS and Terraform_

## **Overview**

This repository demonstrates a secure, scalable proof-of-concept (PoC) deployment of two isolated microservices using:
* AWS EKS clusters in separate VPCs
* VPC Peering between VPCs
* Terraform for infrastructure as code
* GitHub Actions for CI/CD
* A minimal Kubernetes setup without Ingress controllers

## **Getting Started**
**Prerequisites**
* AWS account
* Terraform >= 1.0
* kubectl configured

<br>

**Clone and Initialize**
```
git clone https://github.com/leonchik1976/rapyd.git
cd rapyd
```

<br>

**Configure AWS Credentials**
* Set AWS_ACCESS_KEY_ID + AWS_SECRET_ACCESS_KEY
```
aws configure
```

<br>

**Run Terraform**
```
cd terraform/layers
terraform init
terraform plan
terraform apply
```

<br><br>

## **Architecture**
**VPC and Cluster Layout**
* Two isolated VPCs: vpc-gateway (10.1.0.0/16) and vpc-backend (10.2.0.0/16)
* Two EKS clusters: eks-gateway and eks-backend
* Each cluster has private and public subnets (2 AZs)
* VPC Peering is configured for cross-VPC communication

<br>

**Microservice Setup**
* ```backend:``` Echo service on NodePort 30080
* ```gateway:``` NGINX reverse proxy with LoadBalancer Service, routing to backend over peering

<br>

**Communication Flow**

```[Client] --> [LB Service in Gateway VPC] --> [NGINX Pod] --> [Backend NodePort via Peering]```

<br><br>

## **Networking & Security**
**VPC Peering**
* Bidirectional routing added to each VPC's route tables
* Node security group in backend allows traffic from gateway CIDR to port 30080

<br>

**Security Best Practices**
* Public EKS access temporarily enabled for CI/CD (should be disabled in production)
* Security Groups restrict backend service access to only gateway

<br>

**Kubernetes NetworkPolicy**
* ```NetworkPolicy``` can be used to restrict pod-to-pod communication **within a single EKS cluster**
* However, **cross-cluster traffic (e.g., from ```gateway``` to ```backend```) cannot be restricted** using NetworkPolicy because Kubernetes policies do not span multiple clusters
* In this PoC, ```NetworkPolicy``` is not applied, but could be added within ```eks-backend``` to further limit internal pod access

<br><br>

## **CI/CD Pipeline**
Implemented using GitHub Actions:
* Terraform job: Format, lint, validate, and plan
* Kubernetes job: Validate manifests via kubeval and dry-run kubectl apply

<br><br>

## **Trade-offs and Limitations (due to 3-day limit)**
* NAT Gateway is single AZ to save cost
* Public EKS access enabled temporarily
* No ALB Controller / Ingress
* No autoscaling (fixed node count = 1)
* No IRSA
* Only 2 AZs used
* No secrets encryption with KMS on EKS Clusters

<br><br>

## **Potential Improvements**
**Cost Optimization**
* Use smaller instance types (e.g., t3.small for dev)

<br>

**Production-Ready Enhancements**
* Deploy 3 AZs for HA
* Enable KMS encryption for secrets in EKS Clusters
* Disable public access to EKS
* Enable IRSA for secure pod IAM
* Use Cluster Autoscaler for dynamic node management
* Deploy AWS Load Balancer Controller and use ALB with Ingress
* Add WAF or NACLs to restrict LoadBalancer traffic
* Use ArgoCD for GitOps-based CD

<br><br>

## **Next Steps**
* Add ALB via AWS Load Balancer Controller
* Replace static NGINX with proper Ingress controller
* Use IRSA to grant pods minimal IAM permissions
* Enable secrets encryption with KMS
* Implement autoscaling for workloads and nodes
* (Optional) Add Kubernetes Network Policies within clusters to restrict intra-cluster traffic
