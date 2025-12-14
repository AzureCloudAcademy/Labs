
# 🚀 Azure Load Balancer Labs Guide

## Lab Objective
Create a Public Azure Load Balancer using Terraform that distributes HTTP traffic across two Linux virtual machines running NGINX.
Then in other steps experiment failure cases and different Loadbalancing mechanism : Nat rules; Private internal traffic through bastion; Session persistance (Source IP).

## Architecture Overview
• Resource Group
• Virtual Network & Subnet
• Network Security Group (Allow HTTP 80)
• 2 Linux Virtual Machines (Ubuntu)
• Standard Public Azure Load Balancer
• Health Probe and Load Balancing Rule

## Prerequisites
• Azure Subscription
• Terraform installed (v1.5+)
• Azure CLI logged in
• SSH public key

## 1️⃣ Create through terraform a Basic Azure Load Balancer (Inbound Traffic)

**Goal:** Understand how traffic is distributed across VMs.

### Steps:

1. **Create 2 Azure VMs** in the same VNet & subnet
2. **Install web server** (NGINX or IIS) on both VMs
3. **Create Public Azure Load Balancer** with:
    - ✅ Frontend IP (Public IP)
    - ✅ Backend pool (both VMs)
    - ✅ Health probe (HTTP / TCP)
    - ✅ Load balancing rule (Port 80)

### ✅ Test:
Open Load Balancer Public IP in browser → refresh → response should alternate between VMs.

---

## 2️⃣ Health Probe Failure Test

**Goal:** Learn how health probes work.

### Steps:

1. Stop web service on **VM1** (keep VM2 running)
2. Check health probe status in Load Balancer dashboard
3. Verify traffic routing

### ✅ Expected Result:
Traffic routes **only to healthy VM**

💡 **Learning:** Load Balancer automatically removes unhealthy instances from rotation.

---

## 3️⃣ Configure Load Balancer for SSH (NAT Rules)

**Goal:** Access individual VMs behind Load Balancer.

### Steps:

1. **Create Inbound NAT Rules:**
    - Port 50001 → VM1 SSH (22)
    - Port 50002 → VM2 SSH (22)

2. **Connect via SSH:**
    ```bash
    ssh -p 50001 azureuser@<LB-Public-IP>
    ```

### ✅ Learning:
NAT rules enable admin access without exposing individual VM public IPs.

---

## 4️⃣ Internal Load Balancer (Private Traffic)

**Goal:** Understand internal load balancing.

### Steps:

1. Create **Internal Azure Load Balancer** (no public IP)
2. Add VMs to backend pool
3. Access from Jumpbox VM or Azure Bastion

### ✅ Use Cases:
- App tier → Database tier communication
- Microservices architecture

---

## 5️⃣ Session Persistence (Source IP)

**Goal:** Learn sticky sessions.

### Steps:

1. Update Load Balancer rule
2. Set **Session Persistence = Source IP**
3. Add hostname/VM name in web response

### ✅ Test:
Refresh browser → traffic stays on same VM

💡 **Learning:** Essential for stateful applications.

---

## 🔹 Bonus: Azure Load Balancer vs Application Gateway

| Feature | ALB | App Gateway |
|---------|-----|-------------|
| **Layer** | L4 (Transport) | L7 (Application) |
| **SSL Termination** | ❌ | ✅ |
| **WAF Support** | ❌ | ✅ |
