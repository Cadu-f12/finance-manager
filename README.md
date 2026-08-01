# personal-finance-manager

A simple personal financial management project.

---

## Project Structure

* `stack/`: Contains the source code for all microservices and application layers (e.g., `stack/finance-api`).
* `docker-compose.yml`: Infrastructure setup configuration.
* `run.sh`: Custom CLI script used to orchestrate infrastructure and services.

---

## Environment Variables

Create your `.env` file based on `.env.example` and fill in the required configurations:

```env
# Database configuration
CONTAINER_NAME_DB=
POSTGRES_USER=
POSTGRES_PASSWORD=
POSTGRES_HOST=
POSTGRES_PORT=
POSTGRES_DB=

# Finance API configuration
CONTAINER_NAME_API=
FINANCE_API_PORT=
```
---

## How to Run the Project

### 1. Initial Setup

Run the setup command to generate your local `.env` file:

```bash
./run.sh setup

```

### 2. Configure Environment Variables

Open the `.env` file and fill in your database credentials and API configurations:

```bash
nano .env

```

### 3. Using the CLI Script (`run.sh`)

The project uses a custom automation script `./run.sh` supporting global infrastructure commands and nested service commands.

#### Global Commands

* `./run.sh up` - Starts all Docker containers.
* `./run.sh build` - Rebuilds and starts all Docker containers.
* `./run.sh upsql` - Starts only the PostgreSQL database container in the background.
* `./run.sh down` - Stops all Docker containers.
* `./run.sh clean` - Stops containers and removes Docker volumes (deleting local database data).
* `./run.sh restart` - Restarts and rebuilds the entire system.

#### Service-Specific Commands

Services can be managed using the structure `./run.sh <service-name> <command>`.

**Finance API (`finance-api`)**

* `./run.sh finance-api init` - Starts the Finance API locally in development mode (using the `dev` Spring profile and Maven wrapper).
* `./run.sh finance-api stop` - Stops the running Finance API instance.
