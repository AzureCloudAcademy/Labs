
 ## Features
  - **AKS Integration:** Automates deployment, scaling, and management of payment microservices on Azure Kubernetes Service.
  - **Azure DevOps Integration:** Enables CI/CD pipelines, infrastructure as code, and release management for payment operations.
  - **Monitoring:** Incorporates monitoring and alerting using Azure Monitor and Application Insights for real-time observability of payment services.
  
 ## Usage
  Designed for DevOps teams managing payment infrastructure, ensuring high availability, scalability, and compliance with operational best practices.
  
 ## Components
  - AKS cluster provisioning and management
  - Azure DevOps pipeline configuration
  - Monitoring setup and alert rules
  
  @author
  AzureAcademy team

## 1) Quick start
```bash
# 1. Clone
git clone <your-repo-url>
cd Labs

 # 1. Run locally (Python v3.10+)
python -m venv .venv && source .venv/bin/activate
pip install -r app/requirements.txt
python app/app.py
# open http://localhost:5000
```

---

## 2) Docker

```bash
# Build & run
docker build -t payment-engine:local -f Dockerfile .
docker run -d -p 5000:5000 --name payment payment-engine:local

# Logs
docker logs -f payment
```

---

## 4) 📌 Kubernetes (kind / Minikube / AKS)

```bash
# Create namespace
kubectl create ns payments || true

# Apply manifests
kubectl apply -n payments -f k8s/deployment.yaml
kubectl apply -n payments -f k8s/service.yaml

# Check
kubectl get pods -n payments
kubectl logs -n payments -l app=payment-engine -f

# (If using kind/Minikube) expose service
kubectl port-forward -n payments svc/payment-engine-svc 5000:5000
# open http://localhost:5000
```

Rollback example:
```bash
kubectl rollout undo -n payments deployment/payment-engine-deploy
```

---

## 4) 📌 Monitoring (Prometheus + Grafana)

```bash
cd monitoring
docker-compose up -d
# Grafana: http://localhost:3000 (admin/admin on first login)
# Prometheus: http://localhost:9090
```

In Grafana, add Prometheus data source at `http://prometheus:9090`.  
Import dashboard JSON from `monitoring/grafana-dashboard.json` (simple CPU/Memory/app health example).

---

## 5) 📌 Azure DevOps – Pipeline

- Put this repo in an Azure Repos project.  
- Create a new pipeline using `azure-pipelines.yml`.  
- Optional: Set variables `ACR_LOGIN_SERVER`, `ACR_USERNAME`, `ACR_PASSWORD` as secrets to push images.  
- Stages: install deps → run tests → build Docker → (optional) push to ACR.

---

## 6) 📌 Ops Scripts

- `scripts/service_check.sh` → restarts a Linux service if it goes down (cron‑friendly).
- `scripts/log_parser.py` → prints lines with `ERROR` from a log file.

Crontab example (every 5 min):
```bash
*/5 * * * * /bin/bash /path/to/scripts/service_check.sh >> /var/log/service_monitor.log 2>&1
```

---

## 7) 🙋‍♀️ Talking Points (Interview)

- **Reliability**: health endpoints, probes, monitors, alerts.
- **Troubleshooting flow**: logs → metrics → config → infra → rollback.
- **DevOps**: CI/CD, artifact versioning, immutable images.
- **Security basics**: non-root container user, secrets via env/KeyVault/Secrets.

Good luck — now go crack it! 🚀