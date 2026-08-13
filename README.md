# finance-infrastructure
### 🛠️ Microservices Infrastructure & Orchestration

Central infrastructure repository responsible for orchestrating the local development environment using **Docker Compose** and **Git Submodules**.

---

## 📐 Project Structure

This ecosystem adopts a **Polyrepo** architecture. Each microservice resides in its own dedicated repository and is linked to this project as a **Git Submodule** inside the `stack/` directory.

```text
.
├── docker-compose.yml     # Container and service orchestration
├── run.sh                 # Custom CLI/script for infrastructure management
├── .env.example           # Global environment variables template
└── stack/                 # Microservices (Git Submodules)
    └── finance-api/       # Dedicated repository for the Financial API
```

## ⚙️ Prerequisites
- Docker & Docker Compose
- Git (version 2.13+)

## 🚀 Getting Started
... Work in progress ...