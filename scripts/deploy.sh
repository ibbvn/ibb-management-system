#!/bin/bash
# deploy.sh - Deploy to production

echo "🚀 Starting deployment process..."

# Pull latest backend code
cd /home/ibb/Projects/ibb-backend
git checkout main
git pull origin main

# Restart backend service
echo "🔄 Restarting backend service..."
python app.py &

echo "✅ Deployment completed!"
echo "🔍 Check health: curl http://localhost:5000/health"
