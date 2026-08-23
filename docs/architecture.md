# System Architecture & Technical Specifications

## Architectural Overview

The **Blue-Green Deployment Placement Portal** project implements a multi-tier, zero-downtime deployment architecture on AWS.

```text
[Developer] ---> [GitHub] ---> [Terraform] ---> [AWS Infrastructure]
                                                        |
                                            +-----------+-----------+
                                            |                       |
                                     [Blue EC2 Node]         [Green EC2 Node]
                                    (Docker: Blue v1.0)     (Docker: Green v2.0)
                                            |                       |
                                            +-----------+-----------+
                                                        |
                                              [AWS App Load Balancer]
                                                        |
                                                    [Users]
```

---

## Component Specifications

### 1. Infrastructure Layer (Terraform)
- **VPC & Subnets**: Utilizes default VPC with multi-AZ public subnets.
- **Security Groups**:
  - `alb_sg`: Allows HTTP (port 80) from `0.0.0.0/0`.
  - `ec2_sg`: Allows HTTP (port 80) restricted to traffic coming from `alb_sg`, plus SSH (port 22) for administration.
- **AWS ALB**: Handles incoming web traffic and performs health checks against active target groups every 15 seconds.

### 2. Configuration Layer (Ansible)
- **Role**: Provisioning and configuration of Ubuntu 22.04 LTS instances.
- **Tasks**:
  - Installs Docker daemon and utilities.
  - Deploys static assets and Dockerfiles to `/opt/placement-portal-blue` and `/opt/placement-portal-green`.
  - Builds Docker images and runs containers on port 80.
  - Performs health assertion HTTP pings.

### 3. Container Layer (Docker)
- **Base Image**: `nginx:alpine` (~23MB lightweight footprint).
- **Blue Image**: `placement-portal:blue` (Version 1.0).
- **Green Image**: `placement-portal:green` (Version 2.0 with enhanced analytics & new job listings).

### 4. Traffic Control Layer (AWS ALB / Scripts)
- **Routing Engine**: ALB HTTP Listener rule pointing to either `placement-portal-tg-blue` or `placement-portal-tg-green`.
- **Switch Mechanism**: AWS CLI command `aws elbv2 modify-listener` updates target group weight/forwarding in real-time (< 3 seconds latency).
