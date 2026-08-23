# Blue-Green Deployment for Placement Portal

![DevOps Pipeline](https://img.shields.io/badge/DevOps-Blue--Green%20Deployment-blue)
![Terraform](https://img.shields.io/badge/IaC-Terraform%20v1.5+-purple)
![Ansible](https://img.shields.io/badge/Configuration-Ansible-red)
![Docker](https://img.shields.io/badge/Container-Docker-blue)
![AWS](https://img.shields.io/badge/Cloud-AWS%20EC2%20%26%20ALB-orange)

An end-to-end DevOps college mini-project demonstrating Zero-Downtime **Blue-Green Deployment** and **Instant Rollback** strategy for a modern Placement Portal web application.

---

## 1. Problem Statement

In traditional software deployment workflows, updating an application directly on production servers introduces severe risks:
- **Service Downtime**: Stopping active application processes causes service unavailability for live users during the deployment window.
- **Deployment Failures**: If a new release contains unforeseen runtime bugs, database migration errors, or missing dependencies, the production site breaks immediately.
- **Slow & Complex Recovery**: Rolling back a failed deployment requires re-deploying previous binaries or restoring backups under pressure, prolonging outage times.

---

## 2. Proposed Solution: Blue-Green Deployment

**Blue-Green Deployment** is an advanced deployment pattern that eliminates downtime and reduces release risk:
- **Two Identical Production Environments**: 
  - **BLUE (v1.0)**: Currently active production environment serving live user traffic.
  - **GREEN (v2.0)**: Idle/Staging environment where the new release is deployed, containerized, and tested in isolation.
- **Instant Switch**: Once Green v2.0 passes health checks, traffic is routed instantly from Blue to Green by modifying AWS Application Load Balancer (ALB) listener rules.
- **Instant Rollback**: If issues arise post-switch, ALB traffic is switched back to Blue v1.0 in seconds without needing to rebuild or re-deploy code.

---

## 3. Technology Stack

* **Source Control**: Git & GitHub
* **Infrastructure as Code (IaC)**: Terraform
* **Cloud Infrastructure**: AWS EC2 & AWS Application Load Balancer (ALB)
* **Configuration Management**: Ansible
* **Containerization**: Docker (Nginx Alpine)
* **Automation Scripts**: Bash (`.sh`) & PowerShell (`.ps1`)
* **CI Validation**: GitHub Actions

---

## 4. Architecture Diagram

```text
                       +-------------------+
                       |    Developer      |
                       +---------+---------+
                                 |
                                 v
                       +-------------------+
                       |    GitHub Repo    |
                       +---------+---------+
                                 |
                                 v
                       +-------------------+
                       |   Terraform IaC   |
                       +---------+---------+
                                 |
           +---------------------+---------------------+
           |                                           |
           v                                           v
+-----------------------+                   +-----------------------+
|   Blue EC2 Instance   |                   |  Green EC2 Instance   |
|   (Ubuntu 22.04 LTS)  |                   |   (Ubuntu 22.04 LTS)  |
+-----------+-----------+                   +-----------+-----------+
            |                                           |
            v                                           v
+-----------------------+                   +-----------------------+
|   Ansible Configured  |                   |   Ansible Configured  |
+-----------+-----------+                   +-----------+-----------+
            |                                           |
            v                                           v
+-----------------------+                   +-----------------------+
|  Docker Container     |                   |  Docker Container     |
| (placement-portal:blue)|                  | (placement-portal:green)|
+-----------+-----------+                   +-----------+-----------+
            |                                           |
            v                                           v
+-----------------------+                   +-----------------------+
|  BLUE Version 1.0     |                   |  GREEN Version 2.0    |
+-----------+-----------+                   +-----------+-----------+
            |                                           |
            +-------------------+-----------------------+
                                |
                                v
                   +-------------------------+
                   |  AWS App Load Balancer  |
                   | (Port 80 Traffic Switch)|
                   +------------+------------+
                                |
                                v
                       +-------------------+
                       |    End Users      |
                       +-------------------+
```

---

## 5. Deployment Workflow

```text
GitHub Push → Terraform Provisions AWS → Ansible Configures Nodes → Docker Builds Containers → 
Blue v1.0 Live → Green v2.0 Isolated Test → ALB Traffic Switch → Instant Rollback Capability
```

1. **Infrastructure Provisioning (Terraform)**: Creates VPC, Security Groups, Blue EC2, Green EC2, Blue Target Group, Green Target Group, and ALB Listener.
2. **Configuration & Container Deployment (Ansible)**: Installs Docker on both EC2 nodes, copies code, builds `placement-portal:blue` and `placement-portal:green`, and launches containers on Port 80.
3. **Stage 1 — Blue Live**: ALB default listener routes 100% traffic to Blue Target Group (`BLUE v1.0`).
4. **Stage 2 — Green Stage**: Green v2.0 is built and verified directly on the Green target node.
5. **Stage 3 — Traffic Switching**: `./scripts/switch-to-green.sh` updates the ALB listener to route 100% traffic to Green Target Group (`GREEN v2.0`).
6. **Stage 4 — Rollback Demonstration**: `./scripts/rollback.sh` immediately reverts traffic to Blue v1.0 in seconds.

---

## 6. Directory Structure

```text
blue-green-placement-portal/
├── app/
│   ├── blue/
│   │   ├── index.html        # Blue v1.0 Placement Portal (Indigo Modern UI)
│   │   └── Dockerfile        # Nginx Alpine Dockerfile for Blue
│   └── green/
│       ├── index.html        # Green v2.0 Placement Portal (Emerald UI + Stats + New Jobs)
│       └── Dockerfile        # Nginx Alpine Dockerfile for Green
├── terraform/
│   ├── main.tf               # AWS Provider, VPC, Subnets
│   ├── security.tf           # Security groups for ALB & EC2
│   ├── alb.tf                # ALB, Blue TG, Green TG, Listener
│   ├── ec2.tf                # EC2 Blue & Green instances
│   ├── variables.tf          # Configurable variables
│   ├── outputs.tf            # ALB DNS, EC2 Public IPs
│   └── terraform.tfvars.example
├── ansible/
│   ├── inventory.ini.example # Inventory mapping hosts
│   ├── blue.yml              # Blue deployment playbook
│   ├── green.yml             # Green deployment playbook
│   └── deploy.yml            # Master playbook
├── scripts/
│   ├── deploy-blue.sh / .ps1
│   ├── deploy-green.sh / .ps1
│   ├── switch-to-blue.sh / .ps1
│   ├── switch-to-green.sh / .ps1
│   ├── rollback.sh / .ps1
│   └── status.sh / .ps1
├── docs/
│   ├── architecture.md       # Architecture specification
│   ├── deployment.md         # Deployment guide
│   ├── demo-script.md        # FA1 Faculty presentation guide
│   └── viva.md               # 20 Viva questions & answers
├── .github/
│   └── workflows/
│       └── docker-build.yml  # GitHub Actions CI workflow
├── .gitignore
├── README.md
└── docker-compose.yml        # Local dual-container orchestration
```

---

## 7. Execution Commands

### Local Testing (Docker Compose)
```bash
# Start both Blue (Port 8081) and Green (Port 8082) locally
docker-compose up -d --build

# Inspect status
docker ps
```

### AWS Cloud Deployment (Terraform)
```bash
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
```

### Server Configuration (Ansible)
```bash
cd ansible
ansible all -i inventory.ini -m ping
ansible-playbook -i inventory.ini deploy.yml
```

### Traffic Control & Rollback Scripts
```bash
# Switch traffic to Green v2.0
./scripts/switch-to-green.sh

# Instant Emergency Rollback to Blue v1.0
./scripts/rollback.sh

# Status Check
./scripts/status.sh
```

*(For Windows PowerShell, use `.ps1` extensions: `.\scripts\switch-to-green.ps1`, `.\scripts\rollback.ps1`)*

---

## 8. Screenshot Capture List for Presentation

During your demonstration, capture screenshots of:
1. `terraform apply` output showing created resources
2. AWS EC2 Console showing `placement-portal-ec2-blue` and `placement-portal-ec2-green`
3. AWS ALB Console showing Target Groups (`placement-portal-tg-blue` & `placement-portal-tg-green`)
4. Ansible ping output (`ping: pong`)
5. Docker containers running on EC2 (`docker ps`)
6. Web browser displaying **`CURRENT VERSION: BLUE v1.0`**
7. Web browser displaying **`NEW VERSION: GREEN v2.0`** (with Live Stats & New Jobs)
8. Rollback execution output in terminal
9. Web browser returning to **`CURRENT VERSION: BLUE v1.0`** after rollback
10. GitHub Repository showing clean commit history

---

## 9. Presentation & Viva Guide

- **Faculty Presentation Script**: Refer to [docs/demo-script.md](file:///C:/Users/psunk/.gemini/antigravity/scratch/blue-green-placement-portal/docs/demo-script.md)
- **20 Viva Questions & Answers**: Refer to [docs/viva.md](file:///C:/Users/psunk/.gemini/antigravity/scratch/blue-green-placement-portal/docs/viva.md)
