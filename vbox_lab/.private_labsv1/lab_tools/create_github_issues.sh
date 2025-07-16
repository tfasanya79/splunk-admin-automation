#!/bin/bash

# Ensure GitHub CLI is authenticated before running this script

PROJECT_REPO="tfasanya79/splunk-lab-automation-suite"

# Create Issue 1: GitHub Repo Setup
gh issue create --repo $PROJECT_REPO \
  --title "Set up GitHub repository" \
  --body "Initialize and configure the repository infrastructure.

**Tasks:**
- [ ] Create private repository
- [ ] Add .gitignore, README.md, LICENSE
- [ ] Enable GitHub Project (Kanban)
- [ ] Protect main branch
- [ ] Create dev, test, prod branches" \
  --label "phase-1,infra,high-priority"

# Create Issue 2: Baseline VM Lab
gh issue create --repo $PROJECT_REPO \
  --title "Create baseline VM lab (Ubuntu + Splunk + UF)" \
  --body "Set up reproducible VM environment:

**Tasks:**
- [ ] Import Ubuntu .vdi into VirtualBox
- [ ] Import Kali .vdi into VirtualBox
- [ ] SSH access to both
- [ ] Install Splunk using remote script
- [ ] Install UF
- [ ] Enable receiver on port 9997" \
  --label "phase-1,lab-setup,vm"

# Create Issue 3: Initial install script
gh issue create --repo $PROJECT_REPO \
  --title "Build initial installer script (install_splunk.py)" \
  --body "Create reusable Python installer script for Splunk.

**Tasks:**
- [ ] Handle CLI args (local or remote .deb)
- [ ] Start & enable Splunk
- [ ] Create admin user
- [ ] Validate install via REST/CLI" \
  --label "phase-1,automation,scripting"

# Create Issue 4: README and Charter
gh issue create --repo $PROJECT_REPO \
  --title "Add project charter and main README" \
  --body "Document goals, structure, and collaboration workflow.

**Tasks:**
- [ ] Define project scope and audience
- [ ] Link documentation
- [ ] Describe folder structure
- [ ] Reference Kanban board" \
  --label "phase-1,documentation"

# Create Issue 5: Git Branch Setup
gh issue create --repo $PROJECT_REPO \
  --title "Setup dev, test, and prod branches" \
  --body "Prepare Git branch model with protections.

**Tasks:**
- [ ] Create dev, test, prod branches
- [ ] Protect test and prod
- [ ] Enable PR workflows
- [ ] Document strategy in contributing.md" \
  --label "phase-1,gitops"

echo "✅ All Phase 1 issues created in GitHub repo: $PROJECT_REPO"
