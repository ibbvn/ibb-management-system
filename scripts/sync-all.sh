#!/bin/bash
# sync-all.sh - Sync all IBB repositories

echo "🔄 Syncing all IBB repositories..."

# Frontend
echo "📱 Syncing Mobile App..."
cd /home/ibb/Projects/ibb-app
git checkout development
git pull origin development
echo "✅ Mobile App synced"

# Backend  
echo "🖥️ Syncing Backend..."
cd /home/ibb/Projects/ibb-backend
git checkout development
git pull origin development
echo "✅ Backend synced"

# Documentation
echo "📚 Syncing Documentation..."
cd /home/ibb/Projects/ibb-documentation
git checkout main
git pull origin main
echo "✅ Documentation synced"

echo "🎉 All repositories synced successfully!"
