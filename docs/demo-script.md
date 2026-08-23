# FA1 Faculty Presentation Script (5–10 Minutes)

Use this step-by-step presentation script during your college FA1 evaluation demo.

---

## 🕒 Step 1: Problem Statement & Concept Introduction (1 Minute)

> **What to Say**:  
> *"Good morning / afternoon professors. Today I am presenting my DevOps project: **Blue-Green Deployment for a Placement Portal**.*  
>  
> *Deploying software updates directly to live production servers frequently leads to service downtime and critical outage risks if a new update breaks. To solve this, I built a Blue-Green deployment strategy using Git, Terraform, AWS EC2, AWS Load Balancers, Ansible, and Docker.*  
>  
> *Blue represents our currently active production environment (v1.0), and Green represents our new upgraded environment (v2.0). Traffic is switched instantly at the AWS Load Balancer level with zero downtime, and if any fault occurs, we perform an emergency rollback in seconds."*

---

## 🕒 Step 2: Show GitHub & Repository Architecture (1 Minute)

> **What to Show**: Open your GitHub repository or local VS Code folder.  
> **What to Say**:  
> *"Here is our project repository structure following modular DevOps standards:*  
> - `app/`: Houses both Blue v1.0 and Green v2.0 web applications containerized with Docker.  
> - `terraform/`: Infrastructure as Code defining AWS VPC, Security Groups, EC2 instances, and ALB.  
> - `ansible/`: Configuration management playbooks for server setup and container execution.  
> - `scripts/`: Automated execution scripts for zero-downtime traffic switching and instant rollback."*

---

## 🕒 Step 3: Demonstrate Infrastructure Provisioning with Terraform (1.5 Minutes)

> **What to Show**: Terminal with `terraform plan` or `terraform apply`.  
> **What to Say**:  
> *"**Terraform equals CREATE**. I used Terraform to declaratively provision our entire AWS cloud infrastructure. With `terraform apply`, Terraform creates two EC2 instances (`blue-instance` and `green-instance`), security groups, two Target Groups, and an Application Load Balancer configured to initially route HTTP port 80 traffic to Blue."*

---

## 🕒 Step 4: Demonstrate Server Configuration with Ansible (1.5 Minutes)

> **What to Show**: Terminal running `ansible all -i inventory.ini -m ping` and `ansible-playbook`.  
> **What to Say**:  
> *"**Ansible equals CONFIGURE**. Once Terraform creates the servers, Ansible connects via SSH to configure both nodes. First, we test host connectivity with `ansible ping` which returns `pong`. Then Ansible updates packages, installs Docker daemon, builds `placement-portal:blue` on node 1 and `placement-portal:green` on node 2, and starts containers on port 80."*

---

## 🕒 Step 5: Demonstrate Containerization with Docker (1 Minute)

> **What to Show**: Run `docker ps` on terminal or show local `docker-compose.yml`.  
> **What to Say**:  
> *"**Docker equals RUN**. Each version runs in an isolated Nginx Alpine container. This guarantees environment consistency regardless of where the code is deployed."*

---

## 🕒 Step 6: Live Demonstration of Stage 1 (Blue v1.0 Live) (1 Minute)

> **What to Show**: Open the ALB DNS URL or local endpoint `http://localhost:8081`.  
> **What to Say**:  
> *"Here is our live placement portal. Notice the prominent badge at the top: **CURRENT VERSION: BLUE v1.0**. All user requests currently reach the Blue environment."*

---

## 🕒 Step 7: Live Demonstration of Stage 2 & 3 (Traffic Switch to Green v2.0) (1.5 Minutes)

> **What to Show**: Run `./scripts/switch-to-green.sh` (or `.\scripts\switch-to-green.ps1`), then refresh browser page.  
> **What to Say**:  
> *"Now we deploy Green v2.0 in the background and verify it. To switch production user traffic to Green, I execute `./scripts/switch-to-green.sh`.*  
>  
> *(Refresh browser page)*  
>  
> *Notice that the application instantly updates to **NEW VERSION: GREEN v2.0**! The users experience zero downtime. In Green v2.0, you can see our newly added features: **Live Placement Statistics Dashboard** and **Recently Added Jobs** (AI/ML Engineer and Cloud Security Specialist)."*

---

## 🕒 Step 8: Live Demonstration of Stage 4 (Emergency Rollback to Blue) (1 Minute)

> **What to Show**: Run `./scripts/rollback.sh` (or `.\scripts\rollback.ps1`), then refresh browser page.  
> **What to Say**:  
> *"Now suppose a bug is discovered in production. Rather than spending hours debugging or rebuilding binaries, I execute our emergency rollback script: `./scripts/rollback.sh`.*  
>  
> *(Refresh browser page)*  
>  
> *The load balancer instantly routes traffic back to Blue v1.0 in under 3 seconds! The previous stable version was running untouched, making our rollback instant, safe, and reliable."*

---

## 🕒 Step 9: Conclusion & Viva Readiness (30 Seconds)

> **What to Say**:  
> *"In summary, this project demonstrates the complete end-to-end DevOps pipeline: **GitHub → Terraform → AWS → Ansible → Docker → Blue-Green Switching → Rollback**. Thank you, and I am now open to your viva questions!"*
