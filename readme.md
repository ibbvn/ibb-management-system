# IBB Management System

Hệ thống quản lý sản xuất bia hoàn chỉnh bao gồm Mobile App và Backend Server

## 🏗️ Architecture Overview
┌─────────────────┐    HTTPS/Tunnel    ┌──────────────────┐
│   Mobile App    │ ←─────────────────→ │  Flask Backend   │
│  (React Native) │   api.ibb.vn       │ (Raspberry Pi)   │
└─────────────────┘                    └──────────────────┘

## 📦 Repositories

| Component | Repository | Description |
|-----------|------------|-------------|
| **Frontend** | [ibb-mobile-app](https://github.com/ibbvn/ibb-mobile-app) | React Native mobile application |
| **Backend** | [ibb-backend](https://github.com/ibbvn/ibb-backend) | Flask server trên Raspberry Pi |
| **Documentation** | [ibb-management-system](https://github.com/ibbvn/ibb-management-system) | Project documentation và guides |

## 🚀 Quick Start

### 1. Clone All Repositories
```bash
# Frontend
git clone https://github.com/ibbvn/ibb-mobile-app.git
cd ibb-mobile-app
npm install
npx expo start

# Backend  
git clone https://github.com/ibbvn/ibb-backend.git
cd ibb-backend
pip install -r requirements.txt
python app.py

# Documentation
git clone https://github.com/ibbvn/ibb-management-system.git
2. Development Workflow
bash# Work on frontend
cd ibb-mobile-app
git checkout -b feature/new-screen
# ... develop ...
git commit -m "feat: add new screen"
git push origin feature/new-screen

# Work on backend
cd ibb-backend  
git checkout -b feature/new-api
# ... develop ...
git commit -m "feat: add new API endpoint"
git push origin feature/new-api
📱 Mobile App Features

3 Beer Types: River (109 fields), Hà Nội, Chai Hoàng Gia
QA Modules: Fermentation tracking, Filter logging
Tank Management: Real-time monitoring dashboard
Offline Support: Local storage với auto-sync
Image Upload: Photo documentation
User Management: Role-based access control

🖥️ Backend Features

RESTful APIs: Complete CRUD operations
Authentication: SQLite-based user management
File Storage: JSON-based data persistence
Image Handling: Upload và serving
Tank Metrics: Real-time data aggregation
Network Tunnel: Secure access via api.ibb.vn

🏭 Production Environment
Hardware: Raspberry Pi 5
OS: Raspberry Pi OS Bookworm 64-bit
Network: Home-based với tunnel access
Storage: Local file system với daily backups
📚 Documentation

Technical Specification
API Documentation
Development Workflow
Deployment Guide

🔧 Development
Prerequisites:

Node.js 16+ (for mobile app)
Python 3.8+ (for backend)
Expo CLI (for mobile development)
Git (for version control)

Environment Setup:
bash# Mobile app
npm install -g expo-cli
npm install -g @expo/cli

# Backend
pip install flask sqlite3 pillow
📞 Support
Technical Contact: IBB Development Team
Repository Owner: @ibbvn
