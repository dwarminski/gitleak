# Gitleak: Simple Secret Scanning with Docker

`gitleak` is a lightweight Bash script that simplifies running **Gitleaks** via Docker. With minimal configuration, you can scan directories for secrets, whether it's the current working directory or a specified path. Secure approach, each scan, fresh conatiner. No leftovers from previous scans.

---

## Table of Contents

1. [Features](#features)
2. [Installation](#installation)
   - [Using the `.deb` Package](#using-the-deb-package)
   - [Manual Dependency Installation](#manual-dependency-installation)
3. [Usage](#usage)
   - [Basic Examples](#basic-examples)
   - [How It Works](#how-it-works)
4. [Example Output](#example-output)
5. [Development](#development)
6. [Troubleshooting](#troubleshooting)
7. [License](#license)

---

## Features

- **Default Directory Scanning**: Automatically scans the current directory if no argument is provided.
- **Custom Directory Support**: Specify any target directory for scanning.
- **Ubuntu 24.04 Compatibility**: Resolves AppArmor restrictions automatically.
- **Pre-installation Script**: Handles dependency checks and installs required packages (Docker and `lsb-release`).
- **Lightweight**: Leverages Docker to run Gitleaks without requiring local installation.

---

## Installation

### Using the `.deb` Package

1. **Build the Package**:

   ```bash
   dpkg-deb --build gitleak-deb
   ```

2. **Install the Package**:

   ```bash
   sudo dpkg -i gitleak-deb.deb
   ```

3. **Fix Dependencies (if required)**:
   ```bash
   sudo apt install -f
   ```

---

### Manual Dependency Installation

If not using the pre-installation script, ensure the following dependencies are installed:

```bash
sudo apt update
sudo apt install docker.io lsb-release
sudo systemctl enable docker
sudo systemctl start docker
```

---

## Usage

### Basic Examples

1. **Scan the Current Directory** (default):

   ```bash
   gitleak
   ```

2. **Scan a Specific Directory**:
   ```bash
   gitleak /path/to/target/directory
   ```

### How It Works

- When no argument is provided, the script defaults to scanning the current working directory (`${PWD}`).
- If a directory is specified, it uses the provided path for scanning.
- On Ubuntu 24.04, the script adjusts AppArmor settings automatically to allow proper execution.
- More info about issue: https://github.com/docker/desktop-linux/issues/209#issuecomment-2083540338

---

## Example Output

```plaintext

    ○
    │╲
    │ ○
    ○ ░
    ░    gitleaks

9:05AM INF 2 commits scanned.
9:05AM INF scanned ~1297 bytes (1.30 KB) in 54.4ms
9:05AM INF no leaks found
```

---

## Development

### Modify the Script

1. Edit the script:

   ```bash
   nano gitleak-deb/usr/local/bin/gitleak
   ```

2. Rebuild the `.deb` package:
   ```bash
   dpkg-deb --build gitleak-deb
   ```

---

## Troubleshooting

### Common Issues

1. **Docker Not Found**:

   - Install Docker manually:
     ```bash
     sudo apt update
     sudo apt install docker.io
     sudo systemctl start docker
     ```

2. **lsb-release Not Found**:

   - Install it manually:
     ```bash
     sudo apt update
     sudo apt install lsb-release
     ```

3. **Permissions Issues**:
   - Ensure Docker has proper permissions:
     ```bash
     sudo usermod -aG docker $USER
     newgrp docker
     ```

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Why Choose `gitleak`?

Made it for myself, feel free to use

---
