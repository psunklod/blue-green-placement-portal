# 20 Essential Viva Questions & Answers for DevOps Project Presentation

Use these short, clear, easy-to-memorize answers for your FA1 viva defense.

---

### Q1: What is DevOps?
**Answer**: DevOps is a cultural philosophy and methodology that integrates Software Development (Dev) and IT Operations (Ops) to shorten the development lifecycle, automate workflows, and deliver continuous high-quality software releases.

### Q2: What is Infrastructure as Code (IaC)?
**Answer**: IaC is the practice of managing and provisioning computing infrastructure (servers, networks, load balancers) using machine-readable configuration files instead of manual console configuration.

### Q3: What is Terraform?
**Answer**: Terraform is an open-source IaC tool created by HashiCorp that uses declarative HashiCorp Configuration Language (HCL) to provision and manage cloud infrastructure across cloud providers like AWS.

### Q4: Why use Terraform over manual cloud configuration?
**Answer**: Terraform ensures infrastructure repeatability, version control, automated provisioning, state tracking, and eliminates human errors associated with manual cloud console creation.

### Q5: What is Ansible?
**Answer**: Ansible is an open-source agentless configuration management and automation tool that uses YAML playbooks over SSH to configure software, install packages, and manage server states.

### Q6: Why use Ansible in this project?
**Answer**: Ansible automates node configuration—installing Docker, copying application files, building container images, and managing service states uniformly across EC2 nodes.

### Q7: What is Docker?
**Answer**: Docker is an open-source containerization platform that packages applications and their dependencies into lightweight, portable containers that run consistently across any environment.

### Q8: What is the difference between a Docker Image and a Docker Container?
**Answer**: A Docker Image is an immutable, read-only blueprint containing application code and dependencies. A Docker Container is a runnable, isolated instance created from that image.

### Q9: What is Git?
**Answer**: Git is a distributed version control system designed to track changes in source code during software development.

### Q10: What is GitHub and why use it?
**Answer**: GitHub is a cloud-based hosting platform for Git repositories providing collaboration, pull requests, code review, issue tracking, and CI/CD pipelines through GitHub Actions.

### Q11: What is Blue-Green Deployment?
**Answer**: Blue-Green deployment is a release management strategy using two identical production environments (Blue and Green). One serves live traffic while the other is updated and tested, enabling zero-downtime releases.

### Q12: Why use Blue-Green deployment over direct deployment?
**Answer**: It completely eliminates service downtime during updates, provides an isolated environment to test releases, and allows near-instant rollback if an issue occurs in production.

### Q13: What is Rollback?
**Answer**: Rollback is the process of immediately reverting a software system back to a previous stable state when a newly deployed release experiences unexpected failures.

### Q14: Why do we need two separate environments (Blue and Green)?
**Answer**: Having two environments ensures that the live production version (Blue) continues serving users uninterrupted while the new version (Green) is deployed, configured, and smoke-tested independently.

### Q15: What happens if Green fails testing in Stage 3?
**Answer**: Because public traffic is still directed to Blue, end users notice zero impact. Green can be fixed, rebuilt, or destroyed without affecting production.

### Q16: Why not deploy directly to Blue (In-Place Deployment)?
**Answer**: In-Place deployment requires stopping the active application service or replacing files on live servers, causing mandatory downtime and high outage risk during rollback.

### Q17: What is the core functional difference between Terraform and Ansible?
**Answer**: 
- **Terraform = Provision / Create** (building cloud infrastructure like VPCs, EC2 instances, ALB).
- **Ansible = Configure / Setup** (installing software packages, configuring Docker, starting containers).

### Q18: What is the difference between a Docker Container and a Virtual Machine (VM)?
**Answer**: VMs virtualize hardware and run a complete guest Operating System (heavyweight). Docker containers share the host OS kernel and isolate process spaces (lightweight, starts in seconds).

### Q19: How does traffic switching work in your architecture?
**Answer**: Traffic switching is managed by the AWS Application Load Balancer (ALB). Modifying the HTTP listener rule's default action forwards traffic from `placement-portal-tg-blue` to `placement-portal-tg-green` instantly.

### Q20: Explain your complete project pipeline workflow.
**Answer**:  
`GitHub (Code)` → `Terraform (Provision AWS EC2 & ALB)` → `Ansible (Install Docker & Configure Nodes)` → `Docker (Run Containers)` → `Stage 1 (Blue Live)` → `Stage 2 (Green Tested)` → `Stage 3 (Switch ALB Traffic to Green)` → `Stage 4 (Instant Rollback)`.
