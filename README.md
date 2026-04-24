# 🚀 AWS EC2 Automation Script

Production-grade Bash script to automate AWS EC2 provisioning with environment validation, idempotency, and real-time monitoring.

---

## ⚡ Features

- ✅ Internet connectivity check
- ✅ AWS CLI auto-installation
- ✅ AWS credential validation
- ✅ EC2 instance provisioning
- ✅ Wait until instance is running
- ✅ Fetch public IP & instance state
- ✅ Idempotent (prevents duplicate instances)
- ✅ Logging & error handling (`set -Eeuo pipefail`)

---

## 🧠 Architecture

```text
User → Script → AWS CLI → EC2 API → Instance Lifecycle
