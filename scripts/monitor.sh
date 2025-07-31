#!/bin/bash
# monitor.sh - System monitoring for IBB

echo "🔍 IBB System Health Check - $(date)"
echo "=================================================="

# Check Git repositories status
echo "📦 Repository Status:"
cd /home/ibb/Projects/ibb-app
echo "Frontend: $(git branch --show-current) - $(git log -1 --format='%h %s')"

cd /home/ibb/Projects/ibb-backend  
echo "Backend: $(git branch --show-current) - $(git log -1 --format='%h %s')"

# Check backend service
echo ""
echo "🖥️ Backend Service:"
if curl -s http://localhost:5000/health > /dev/null; then
    echo "✅ Backend service is running"
    curl -s http://localhost:5000/health | grep -o '"status":"[^"]*"'
else
    echo "❌ Backend service is DOWN"
fi

# Check disk space
echo ""
echo "💾 Disk Space:"
df -h | grep -E "/$|/home"

# Check recent commits
echo ""
echo "📝 Recent Activity:"
cd /home/ibb/Projects/ibb-backend
echo "Last backend commit: $(git log -1 --format='%ar - %s')"

echo ""
echo "=================================================="
