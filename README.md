# Finance Infrastructure

### 🛠️ Microservices Infrastructure & Orchestration

Central infrastructure repository responsible for orchestrating the local development environment using **Docker Compose** and **Git Submodules**.

---

## 📐 Project Structure

This ecosystem adopts a **Polyrepo** architecture. Each microservice resides in its own dedicated repository and is linked to this project as a **Git Submodule** inside the `stack/` directory.

```text
.
├── scripts/
│   ├── help.sh             # Help and command documentation
│   └── setup-env.sh        # Environment setup and configuration
├── run.sh                  # Custom CLI for infrastructure management
├── .env.example            # Global environment variables template
└── stack/                  # Microservices (Git Submodules)
    └── finance-api/        # Dedicated repository for the Financial API
        └── .env.example    # Variables required by the Financial API
```

The infrastructure repository is responsible for **orchestration**, while each microservice remains responsible for its own application code and configuration requirements.

---

## ⚙️ Prerequisites

* Docker & Docker Compose
* Git (version 2.13+)

---

## 🚀 Getting Started

### 1. Clone the repository

Clone the infrastructure repository together with its Git submodules:

```bash
git clone --recurse-submodules <repository-url>
cd finance-infrastructure
```

If the repository was cloned without `--recurse-submodules`, initialize the submodules manually:

```bash
git submodule update --init --recursive
```

### 2. Configure the global environment

Create the global `.env` file from the provided template:

```bash
cp .env.example .env
```

Then fill in the required environment variables:

```env
# Database configuration
POSTGRES_HOST=
POSTGRES_PORT=
POSTGRES_USER=
POSTGRES_PASSWORD=
POSTGRES_DB=

# Finance API configuration
CONTAINER_NAME_API=
FINANCE_API_PORT=
```

> **Important:** The `.env` file contains local configuration and must not be committed to the repository.

### 3. Run the setup

Execute the setup command:

```bash
./run.sh setup
```

The setup script reads the global `.env` and automatically generates the `.env` file for each microservice based on its `.env.example`.

For example, if `stack/finance-api/.env.example` contains:

```env
POSTGRES_HOST=
POSTGRES_PORT=
POSTGRES_DB=
POSTGRES_USER=
POSTGRES_PASSWORD=
```

The setup process generates:

```env
POSTGRES_HOST="postgres"
POSTGRES_PORT=5432
POSTGRES_DB="finance_manager"
POSTGRES_USER="business_user"
POSTGRES_PASSWORD="..."
```

This allows the infrastructure repository to maintain a **single source of actual configuration values**, while each microservice declares only the variables it requires.

### 4. Start the environment

After running the setup, start the complete infrastructure:

```bash
./run.sh up
```

---

## 🔐 Environment Configuration

Environment configuration follows a centralized model:

```text
                    .env
                     │
          ┌──────────┴──────────┐
          │                     │
          ▼                     ▼
   Docker Compose          setup-env.sh
          │                     │
          │                     ▼
          │              service/.env
          │                     │
          ▼                     ▼
     Infrastructure        Microservice
```

The responsibilities are divided as follows:

* **Root `.env`** — stores the actual local configuration values.
* **Service `.env.example`** — declares which variables a service requires.
* **`setup-env.sh`** — copies the required variables from the root `.env` into each service's `.env`.
* **Docker Compose** — consumes the root `.env` for infrastructure configuration.

This means a new microservice can be added without modifying the environment setup logic. It only needs its own `.env.example`.

---

## 🖥️ Infrastructure Commands

The project provides a custom CLI through `run.sh`.

### Start services

```bash
./run.sh up
```

Starts the complete Docker Compose environment.

### Build and start

```bash
./run.sh build
```

Builds the required images and starts the environment.

### Start PostgreSQL

```bash
./run.sh upsql
```

Starts only the PostgreSQL container.

### Stop the environment

```bash
./run.sh down
```

Stops and removes the Docker Compose containers.

### Clean the environment

```bash
./run.sh clean
```

Stops the environment and removes Docker volumes.

> This command removes persisted data stored in Docker volumes.

### Restart the environment

```bash
./run.sh restart
```

Stops the current environment, rebuilds the images and starts it again.

### Configure environment files

```bash
./run.sh setup
```

Generates the `.env` files required by the microservices.

### Show help

```bash
./run.sh help
```

Displays the available commands.
