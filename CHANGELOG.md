## 0.3.0 (2025-11-23)

### 🐛🚑️ Fixes

- **2-ml-platform/mlflow/ingress-mlflow.yaml**: fix api path (ui works static, this has to be at /api instead of /mlflow/api) >>> ⏰ 15m

## 0.2.0 (2025-11-23)

### ✨ Features

- **2-ml-platform/mlflow/***: set up mlflow >>> ⏰ 45m
- **1-core-services/minio/**: set up minio (still some bugs to fix) >>> ⏰ 30m
- **/1-core-services/ingress-nginx**: create nginx service >>> ⏰ 15m
- **/0-bootstrap**: setup metal >>> ⏰ 15m

### 🐛🚑️ Fixes

- **2-ml-platform/mlflow/*.yaml**: fix static rendering, site now available >>> ⏰ 30m
- **1-core-services/minio/values.yaml**: fix login - network was bugged because of server redirect url >>> ⏰ 15m
- **1-core-services/minio/*.yaml**: fix minio console rendering/routing >>> ⏰ 15m

### 🎨🏗️ Style & Architecture

- **0-bootstrap/Makefile**: more logging >>> ⏰ 1m

### 📝💡 Documentation

- **1-core-services/ingress-nginx/readme.md**: explain debugging nginx >>> ⏰ 1m
