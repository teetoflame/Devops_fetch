
# Devopsfetch
**Devopsfetch** is a command-line tool designed for DevOps professionals to retrieve and monitor system information. It collects details about active ports, Docker images, Nginx configurations, and user logins, and it can display activities within specified time ranges. The tool also supports continuous monitoring and logging through a systemd service.

## Features

- **Ports:**
  - Display all active ports and services.
  - Provide detailed information about a specific port.

- **Docker:**
  - List all Docker images and containers.
  - Provide detailed information about a specific container.

- **Nginx:**
  - Display all Nginx domains and their ports.
  - Provide detailed configuration information for a specific domain.

- **Users:**
  - List all users and their last login times.
  - Provide detailed information about a specific user.

- **Time Range:**
  - Display activities within a specified time range.

- **Systemd Service:**
  - Continuous monitoring and logging of system activities.

## Installation

### Dependencies

Ensure the following dependencies are installed:
- `net-tools` (for `netstat` command)
- `docker` (for Docker commands)
- `nginx` (for Nginx configurations)
- `systemd` (for creating the service)

Install these dependencies using the following command:

```bash
sudo apt-get update
sudo apt-get install net-tools docker.io nginx
```

### Installation Script

1. Clone the repository and navigate to the project directory:

   ```bash
   git clone <repository-url>
   cd devopsfetch
   ```

2. Run the installation script:

   ```bash
   sudo ./install.sh
   ```

   This script will install necessary dependencies and set up a systemd service for continuous monitoring.

## Usage

### General Syntax

```bash
devopsfetch [OPTION]
```

### Ports

- **Display all active ports and services:**

  ```bash
  devopsfetch -p
  ```

- **Provide detailed information about a specific port:**

  ```bash
  devopsfetch -p <port_number>
  ```

### Docker

- **List all Docker images and containers:**

  ```bash
  devopsfetch -d
  ```

- **Provide detailed information about a specific container:**

  ```bash
  devopsfetch -d <container_name>
  ```

### Nginx

- **Display all Nginx domains and their ports:**

  ```bash
  devopsfetch -n
  ```

- **Provide detailed configuration information for a specific domain:**

  ```bash
  devopsfetch -n <domain>
  ```

### Users

- **List all users and their last login times:**

  ```bash
  devopsfetch -u
  ```

- **Provide detailed information about a specific user:**

  ```bash
  devopsfetch -u <username>
  ```

### Time Range

- **Display activities within a specified time range:**

  ```bash
  devopsfetch -t "start_time" "end_time"
  ```

  Replace `start_time` and `end_time` with the desired timestamps in the format `YYYY-MM-DD HH:MM:SS`.

## Help and Documentation

To display help and usage instructions:

```bash
devopsfetch -h
```

### Example Commands

- Display all active ports:

  ```bash
  devopsfetch -p
  ```

- List all Docker containers:

  ```bash
  devopsfetch -d
  ```

- Show Nginx configurations for a specific domain:

  ```bash
  devopsfetch -n example.com
  ```

- Show user details for a specific user:

  ```bash
  devopsfetch -u username
  ```

- Display activities between two dates:

  ```bash
  devopsfetch -t "2024-07-21 00:00:00" "2024-07-22 00:00:00"
  ```

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.

