# Assignment


**Project:** `project-XXXXX`  
**Region:** `asia-south1` (Mumbai)  
**Stack:** Terraform + GitHub Actions + GKE + Grafana OSS

---

## Repository Structure

```
.
├── terraform/
    ├──ProjectSetUp
    ├──VPC
    ├──GKE
    ├──Grafana
│   └── modules/
│       ├── GKE/                
│       ├── Grafana/ 
│       └── VPC/        
└── .github/workflows/
    └── deploy.yml              # CI/CD pipeline
│
└── README.md
```

---

## SLI / SLO Definitions

### SLIs (Service Level Indicators)

| SLI | Definition | Measurement |
|---|---|---|
| **Availability** | % of HTTP requests returning 2xx | `sum(rate(http_requests_total{status=~"2.."}[5m])) / sum(rate(http_requests_total[5m]))` |
| **Latency** | P95 response time in milliseconds | `histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))` |

### SLO (Service Level Objective)

> **The App will be available 99.9% of the time over any 30-day rolling window,  
> and 95% of requests will complete in under 500ms.**

| SLO | Target | Error Budget (30 days) |
|---|---|---|
| Availability | 99.9% | 43.2 minutes downtime allowed |
| P95 Latency | < 500ms | 5% of requests may exceed 500ms |

---

## Capacity Assumptions

- **Expected load:** ~100 requests/second sustained
- **Node count:** 2 × `e2-medium` (2 vCPU, 4 GB each) — sufficient for ~1000 req/s
- **Pod replicas:** 2 minimum (spreads across nodes for zone HA)
- **Single-zone deployment** as per assignment spec (no multi-zone HA in primary)

---

## GitOps Flow

This repository contains a GitHub Actions workflow that automatically runs Terraform plan and apply for changed Terraform directories inside the terraform/ folder.
```
The workflow uses:

GitHub Actions
Terraform
Google Cloud Platform (GCP)
Workload Identity Federation (OIDC authentication)
Dynamic directory detection for Terraform changes
```
```
Workflow Overview:

Developer Changes Code
        ↓
Push / Pull Request to GitHub
        ↓
GitHub Actions Triggered
        ↓
Terraform Plan Executed
        ↓
Code Review & Merge Approval
        ↓
Push to Main Branch
        ↓
Terraform Apply Executed
        ↓
Infrastructure Updated in GCP
```

All infra changes go through Git PRs — no manual `gcloud`.  
Terraform state of every resource is stored in GCS.
The workflow runs only when files inside the terraform/ directory change.

---

## Prerequisites

```
1. A GCP project with billing enabled
2. Install Terraform
3. A GitHub repository
4. Create a GCP Service Account
5. Configure Workload Identity Federation
6. Create GCS State Bucket

```

---

## Frontend Application Setup

```
1. Created a simple Python frontend application using app.py
2. Wrote a Dockerfile to containerize the application
3. Performed all development steps using Google Cloud Shell / Cloud CLI
4. Built the Docker image locally using Docker
5. Tagged the Docker image for Google Artifact Registry
6. Pushed the Docker image to Google Artifact Registry
7. Used the pushed image for deployment in GKE / Kubernetes environment

```

## GKE Application Deployment

```
1. Used the Docker image stored in Google Artifact Registry for Kubernetes deployment
2. Created Kubernetes YAML manifests for: Namespace, Deployment, Service, Ingress
3. Created a dedicated namespace "app" for application resource isolation
4. Created a Kubernetes Deployment for frontend application pods
5. Configured the Deployment to pull the image from Artifact Registry
6. Created a ClusterIP Service to expose the frontend application internally within the cluster
7. Created an Ingress resource to expose the application externally
8. Used GKE HTTP External Load Balancer Ingress annotation in the Ingress YAML
9. Applied all Kubernetes manifests using kubectl apply -f
```
```
Deployment Flow:

User
  ↓
External HTTP(S) Load Balancer
  ↓
GKE Ingress
  ↓
Kubernetes Service
  ↓
Frontend Application Pods
```
---

## Grafana Deployment and Frontend Monitor

```

1. Created an internal Compute Engine VM for Grafana deployment
2. Used Container-Optimized OS (COS) image for the VM
3. Configured the VM to run a Grafana Docker container
4. Used the Grafana image stored in Google Artifact Registry
5. Pulled and deployed the Grafana container on VM startup
6. Exposed Grafana externally using Google Cloud External HTTP(S) Load Balancer
7. Accessed Grafana securely using the Load Balancer public IP
8. Configured Grafana dashboards for the following SLI metrics:
Traffic
Error Rate
P95 Latency

```

