# Development Workflow - IBB Management System

## Branch Strategy

### Repository Structure
```
main (production-ready code)
├── development (integration branch)
│   ├── feature/screen-improvements
│   ├── feature/api-enhancements  
│   ├── feature/qa-dashboard
│   └── bugfix/sync-issues
```

### Branch Naming Convention
- **Feature branches:** `feature/brief-description`
- **Bug fixes:** `bugfix/issue-description`
- **Hotfixes:** `hotfix/critical-issue`
- **Release branches:** `release/v1.3.0`

## Daily Development Workflow

### 1. Bắt đầu ngày làm việc
```bash
# Pull latest changes
cd /home/ibb/Projects/ibb-app  # hoặc ibb-backend
git checkout development
git pull origin development

# Tạo feature branch mới (nếu cần)
git checkout -b feature/new-functionality
```

### 2. Development cycle
```bash
# Làm việc trên code...
# Test chức năng...

# Commit thường xuyên (mỗi 1-2 giờ)
git add .
git commit -m "feat(component): implement basic functionality

- Add new component structure
- Implement basic UI layout
- Add form validation logic"

# Push để backup
git push origin feature/new-functionality
```

### 3. Kết thúc ngày
```bash
# Final commit cho ngày
git add .
git commit -m "wip: end of day progress on feature

- Completed UI implementation
- TODO: Add API integration tomorrow
- TODO: Test on device"

# Push changes
git push origin feature/new-functionality
```

## Commit Message Standards

### Format Template
```
type(scope): brief description

Detailed explanation of changes:
- Point 1
- Point 2
- Point 3

Closes #123
```

### Commit Types
- **feat:** New feature
- **fix:** Bug fix
- **docs:** Documentation changes
- **style:** Code formatting (no logic changes)
- **refactor:** Code refactoring
- **test:** Adding tests
- **chore:** Maintenance tasks
- **wip:** Work in progress (end of day commits)

### Examples of Good Commits
```bash
# Feature addition
git commit -m "feat(screens): add RiverScreen with auto-calculation

- Implement dynamic form generation from JSON
- Add time field auto-calculation logic
- Integrate image upload functionality
- Add local storage with FileSystem API

Closes #45"

# Bug fix
git commit -m "fix(locscreen): resolve syntax error in import statements

- Move all import statements to top of file
- Remove code execution before imports  
- Maintain all existing functionality and logic

Fixes #67"

# Documentation
git commit -m "docs(api): update endpoint documentation

- Add new QA endpoints specification
- Update authentication examples
- Add error handling documentation
- Include rate limiting information"
```

## Feature Development Process

### 1. Planning Phase
```bash
# Create feature branch
git checkout development
git pull origin development
git checkout -b feature/tank-dashboard-enhancement

# Create GitHub Issue first:
# Title: [FEATURE] Enhanced Tank Dashboard with Real-time Metrics
# Description: Detailed requirements
# Acceptance criteria checklist
```

### 2. Development Phase
```bash
# Daily commits with clear progress
git commit -m "feat(dashboard): add basic tank grid layout"
git commit -m "feat(dashboard): implement real-time data fetching"
git commit -m "feat(dashboard): add temperature color coding"
git commit -m "feat(dashboard): integrate filter status display"
```

### 3. Testing Phase
```bash
# Test commits
git commit -m "test(dashboard): add unit tests for tank calculations"
git commit -m "test(dashboard): verify real-time updates on device"
git commit -m "fix(dashboard): resolve memory leak in data polling"
```

### 4. Code Review Phase
```bash
# Final cleanup
git add .
git commit -m "docs(dashboard): add component documentation and comments"

# Push for review
git push origin feature/tank-dashboard-enhancement

# Create Pull Request on GitHub:
# Base: development ← Compare: feature/tank-dashboard-enhancement
# Add detailed description, screenshots, testing notes
```

### 5. Merge Phase
```bash
# After PR approval and merge
git checkout development
git pull origin development
git branch -d feature/tank-dashboard-enhancement
```

## Code Review Guidelines

### What to Review
- **Functionality:** Does it work as expected?
- **Code Quality:** Readable, maintainable, follows patterns
- **Performance:** No memory leaks, efficient algorithms
- **Security:** No hardcoded secrets, proper input validation
- **Documentation:** Comments for complex logic
- **Testing:** Adequate test coverage

### Review Checklist Template
```markdown
## Code Review Checklist

### Functionality
- [ ] Feature works on both Android device and simulator
- [ ] All user flows tested and working
- [ ] Error handling implemented
- [ ] Edge cases considered

### Code Quality
- [ ] Code follows project conventions
- [ ] No hardcoded values
- [ ] Proper error handling
- [ ] Clear variable and function names

### Mobile App Specific
- [ ] UI responsive on different screen sizes
- [ ] Offline functionality works
- [ ] Image upload/display working
- [ ] Form validation appropriate

### Backend Specific  
- [ ] API endpoints return correct data
- [ ] Database operations are safe
- [ ] File operations handle errors
- [ ] Performance acceptable

### Documentation
- [ ] README updated if needed
- [ ] API docs updated for new endpoints
- [ ] Complex logic has comments
```

## Release Management

### Version Numbering
**Format:** `MAJOR.MINOR.PATCH`
- **MAJOR:** Breaking changes
- **MINOR:** New features, backwards compatible
- **PATCH:** Bug fixes

### Release Process

#### 1. Prepare Release
```bash
# Create release branch
git checkout development
git pull origin development
git checkout -b release/v1.3.0

# Update version numbers
# Frontend: package.json version
# Backend: app.py version constant
# Documentation: version references

git commit -m "chore: bump version to v1.3.0"
```

#### 2. Release Testing
```bash
# Test entire system
# Full regression testing
# Performance testing
# Security testing

# Fix any issues found
git commit -m "fix(release): resolve login timeout issue"
```

#### 3. Merge to Main
```bash
# Merge to main
git checkout main
git pull origin main  
git merge release/v1.3.0

# Tag the release
git tag -a v1.3.0 -m "Release v1.3.0: Enhanced Tank Dashboard

New Features:
- Real-time tank metrics dashboard
- Improved QA workflow
- Enhanced image upload process

Bug Fixes:
- Fixed sync issues in LocScreen
- Resolved memory leaks in dashboard
- Improved error handling

Breaking Changes:
- API endpoint restructure (see migration guide)"

# Push everything
git push origin main --tags
```

#### 4. Create GitHub Release
1. Go to repository → Releases → New Release
2. Choose tag v1.3.0
3. Release title: "v1.3.0 - Enhanced Tank Dashboard"
4. Description: Copy from tag message + add deployment notes
5. Attach APK file if available
6. Publish release

#### 5. Deploy to Production
```bash
# On Raspberry Pi
cd /home/ibb/Projects/ibb-backend
git checkout main
git pull origin main

# Restart services
sudo systemctl restart ibb-backend
sudo systemctl restart nginx

# Verify deployment
curl http://localhost:5000/health
```

## Hotfix Process

### For Critical Production Issues
```bash
# Create hotfix from main
git checkout main
git pull origin main
git checkout -b hotfix/critical-login-issue

# Fix the issue
git commit -m "hotfix: resolve critical login authentication bug

- Fix token validation logic
- Add input sanitization  
- Improve error messages

Fixes #123"

# Test thoroughly
git commit -m "test: verify hotfix on production environment"

# Merge to main
git checkout main
git merge hotfix/critical-login-issue
git tag -a v1.2.1 -m "Hotfix v1.2.1: Critical login issue"
git push origin main --tags

# Merge back to development
git checkout development
git merge main
git push origin development

# Delete hotfix branch
git branch -d hotfix/critical-login-issue
```

## Environment Management

### Development Environment
- **Location:** Raspberry Pi local network
- **URL:** `http://192.168.1.100:5000`
- **Database:** Development data
- **Images:** Test images only

### Production Environment  
- **Location:** Raspberry Pi with tunnel
- **URL:** `https://api.ibb.vn`
- **Database:** Production user accounts
- **Images:** Production brewery photos
- **Backup:** Daily automated backups

### Environment Variables
```bash
# Development
export FLASK_ENV=development
export API_BASE_URL=http://192.168.1.100:5000
export DEBUG=true

# Production
export FLASK_ENV=production  
export API_BASE_URL=https://api.ibb.vn
export DEBUG=false
```

## Backup and Recovery

### Daily Backup Script
```bash
#!/bin/bash
# backup-git.sh

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/home/ibb/backups/git"

mkdir -p $BACKUP_DIR

# Backup all repositories
cd /home/ibb/Projects/ibb-app
git bundle create $BACKUP_DIR/ibb-app_$DATE.bundle --all

cd /home/ibb/Projects/ibb-backend  
git bundle create $BACKUP_DIR/ibb-backend_$DATE.bundle --all

cd /home/ibb/Projects/ibb-documentation
git bundle create $BACKUP_DIR/ibb-docs_$DATE.bundle --all

echo "Git backup completed: $DATE"
```

### Recovery Process
```bash
# Restore from bundle
git clone /path/to/backup.bundle restored-repo
cd restored-repo
git remote set-url origin https://github.com/ibbvn/repo-name.git
```

## Collaboration Guidelines

### Multiple Developers
1. **Always** pull latest development before starting work
2. **Never** commit directly to main branch
3. **Always** use Pull Requests for code review
4. **Communicate** about overlapping work areas
5. **Test** thoroughly before requesting review

### Code Conflicts Resolution
```bash
# When pull results in conflicts
git pull origin development

# Fix conflicts in files
nano conflicted-file.js

# Mark as resolved
git add conflicted-file.js
git commit -m "resolve: merge conflicts in feature implementation"
```

---

*Development Workflow được update thường xuyên dựa trên lessons learned và team feedback.*
