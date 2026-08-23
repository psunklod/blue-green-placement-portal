# Step-by-Step Deployment Guide

This guide details how to deploy, test, switch, and rollback the Placement Portal Blue-Green application.

---

## Phase 1: Local Simulation (Zero AWS Prerequisites)

If AWS credentials are unavailable during testing, run locally with Docker Compose:

1. Launch dual environments locally:
   ```bash
   docker-compose up -d --build
   ```
2. Verify endpoints:
   - **Blue v1.0**: Open `http://localhost:8081` in your browser. (Visual indicator: **CURRENT VERSION: BLUE v1.0**)
   - **Green v2.0**: Open `http://localhost:8082` in your browser. (Visual indicator: **NEW VERSION: GREEN v2.0**)
3. Inspect running containers:
   ```bash
   docker ps
   ```

---

## Phase 2: Cloud Infrastructure Provisioning (Terraform)

1. Navigate to the `terraform/` directory:
   ```bash
   cd terraform
   ```
2. Initialize Terraform modules and AWS provider:
   ```bash
   terraform init
   ```
3. Validate HCL code:
   ```bash
   terraform validate
   ```
4. Generate execution plan:
   ```bash
   terraform plan
   ```
5. Apply infrastructure provisioning:
   ```bash
   terraform apply -auto-approve
   ```
6. Note the output values:
   - `alb_dns_name`
   - `blue_ec2_public_ip`
   - `green_ec2_public_ip`

---

## Phase 3: Server Configuration & Container Deployment (Ansible)

1. Navigate to `ansible/`:
   ```bash
   cd ../ansible
   ```
2. Create `inventory.ini` from example:
   ```bash
   cp inventory.ini.example inventory.ini
   ```
   *Replace IP placeholders with the actual EC2 public IPs from Terraform.*

3. Test connectivity:
   ```bash
   ansible all -i inventory.ini -m ping
   ```
   *Expected result: `ping: pong`*

4. Run the master deployment playbook:
   ```bash
   ansible-playbook -i inventory.ini deploy.yml
   ```

---

## Phase 4: Blue-Green Traffic Switch & Rollback Demonstration

1. Open the ALB DNS name in your browser:
   `http://<alb-dns-name>`
   *Observe **CURRENT VERSION: BLUE v1.0**.*

2. Execute traffic switch to Green v2.0:
   ```bash
   ./scripts/switch-to-green.sh
   # (On Windows PowerShell: .\scripts\switch-to-green.ps1)
   ```

3. Refresh your browser page:
   *Observe **NEW VERSION: GREEN v2.0** with Live Statistics and Recently Added Jobs.*

4. Execute emergency rollback to Blue v1.0:
   ```bash
   ./scripts/rollback.sh
   # (On Windows PowerShell: .\scripts\rollback.ps1)
   ```

5. Refresh your browser page:
   *Observe immediate return to **CURRENT VERSION: BLUE v1.0**.*
