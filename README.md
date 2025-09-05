# Labs
Labs public repository to share labs content with participants

## 1) 📌 Labs structure plan

### Lab 1 -  [Azure Subscription and Developer Workstation Setup steps guide](lab1/lab1.md)
### Lab 2 -  [Creating Your First Project and Setting up Your Organization](lab2/lab2.md)
### Lab 3 -  [Integrating Azure AD with Azure DevOps](./lab3/lab3.md)
### Lab 4 -  [Configuring Project Permissions]()
### Lab 5 -  [Initialize and Connect to Your First Git Repository]()
### Lab 6 -  [Initialize Cloud Shell and Azure DevOps CLI]
### Lab 7 -  [Getting Started with Git and GitHub]
### Lab 8 -  [Creating a Branch and Merging Changes]
### Lab 9 -  [Code Reviews with Git Pull Requests]
### Lab 10 - [Blue-green Deployments with Azure App Service and GitHub]
### Lab 11 - [Create a CI/CD Pipeline for .NET or Java with the Azure DevOps Project]
### Lab 12 - [Configuring CI/CD Pipelines as Code with YAML in Azure DevOps]
### Lab 13 - [Deploying a Docker Web Application to Azure App Service]
### Lab 14 - [Using Secrets from Azure Key Vault in a Pipeline]
### Lab 15 - [Deploying to Azure VM using Deployment]

## 2) 📌 Quickstart

```bash
# 1. Clone
git clone <your-repo-url>
cd Labs

# 2. Run locally (Python v3.10+)
python -m venv .venv && source .venv/bin/activate
pip install -r app/requirements.txt
python app/app.py
# open http://localhost:5000
```

---

## 3) Docker

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

## 8) 🙋‍♀️ Frequently Asked Questions
For answers to common questions about the Azure DevOps, see the Frequently Asked Questions.

## 9) 📌 Contributing
We welcome contributions! During preview, please file issues for bugs, enhancements, or documentation improvements.

See our Contributions Guide for:

🛠️ Development setup
✨ Adding new tools
📝 Code style & testing
🔄 Pull request process
🤝 Code of Conduct
This project follows the Microsoft Open Source Code of Conduct. For questions, see the FAQ or contact open@microsoft.com.

