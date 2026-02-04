# Deployment Guide

This guide explains how to deploy DJ Dungeon Spam Guide to CurseForge and Wago using automated GitHub Actions.

## What's Been Set Up

1. **`.pkgmeta`** - Packaging configuration that tells the packager what to include/exclude
2. **`.github/workflows/release.yml`** - Automated GitHub Actions workflow
3. This guide!

## First-Time Setup

### 1. Register Your Addon on CurseForge

1. Go to [CurseForge Authors Portal](https://authors.curseforge.com/)
2. Sign in or create an account
3. Click "Create Project"
4. Select "World of Warcraft" as the game
5. Fill in project details:
   - **Project Name**: DJ Dungeon Spam Guide
   - **Summary**: Track TBC dungeon spam progress for optimal leveling and reputation gains
   - **Category**: Dungeons & Raids
6. Upload a screenshot or logo (optional but recommended)
7. Click "Create Project"
8. Note your **Project ID** (found in the URL: `curseforge.com/wow/addons/<project-name>`)

### 2. Get CurseForge API Token

1. Go to [CurseForge API Tokens](https://authors.curseforge.com/account/api-tokens)
2. Click "Generate Token"
3. Copy the token (you won't be able to see it again!)

### 3. Register Your Addon on Wago

1. Go to [Wago Addons](https://addons.wago.io/)
2. Sign in with your GitHub account
3. Click "Publish an Addon"
4. Link your GitHub repository: `DJilanov/ally-level-addon-wow-tbc`
5. Configure project details
6. Note your **Project Slug** (usually your repo name)

### 4. Get Wago API Token

1. Go to [Wago Account Settings](https://addons.wago.io/account)
2. Navigate to "API Keys" section
3. Click "Generate New API Key"
4. Copy the token

### 5. Add Secrets to GitHub

1. Go to your GitHub repository: [https://github.com/DJilanov/ally-level-addon-wow-tbc/settings/secrets/actions](https://github.com/DJilanov/ally-level-addon-wow-tbc/settings/secrets/actions)
2. Click "New repository secret"
3. Add these two secrets:

   **Secret 1:**
   - Name: `CF_API_KEY`
   - Value: [Your CurseForge API token]

   **Secret 2:**
   - Name: `WAGO_API_TOKEN`
   - Value: [Your Wago API token]

## How to Release a New Version

### 1. Update Version Numbers

Edit [`DJDungeonSpamGuide/DJDungeonSpamGuide.toc`](DJDungeonSpamGuide/DJDungeonSpamGuide.toc):
```
## Version: 1.0.1
```

### 2. Update Changelog

Edit [`CHANGES.md`](CHANGES.md) with your changes:
```markdown
## Version 1.0.1
- Fixed bug in reputation tracking
- Added new dungeon recommendations
- Improved UI performance
```

### 3. Commit Your Changes

```bash
git add .
git commit -m "Release v1.0.1"
git push
```

### 4. Create and Push a Git Tag

```bash
git tag v1.0.1
git push origin v1.0.1
```

**That's it!** The GitHub Action will automatically:
- Package your addon
- Upload to CurseForge
- Upload to Wago
- Create a GitHub release with the zip file

## Monitoring Releases

### Check Release Status

1. Go to your repository's [Actions tab](https://github.com/DJilanov/ally-level-addon-wow-tbc/actions)
2. Click on the latest workflow run
3. Check the logs for any errors

### View Your Releases

- **CurseForge**: `https://www.curseforge.com/wow/addons/[your-project-slug]`
- **Wago**: `https://addons.wago.io/addons/[your-project-slug]`
- **GitHub**: `https://github.com/DJilanov/ally-level-addon-wow-tbc/releases`

## Troubleshooting

### "Invalid API Token" Error

- Verify your secrets are set correctly in GitHub
- Check that tokens haven't expired
- Regenerate tokens if needed

### "Project Not Found" Error

- Make sure you've created the project on CurseForge/Wago first
- The packager auto-detects project ID from your GitHub repo in most cases
- If needed, you can specify project IDs in `.pkgmeta`

### Release Didn't Upload

- Check the Actions log for specific error messages
- Ensure your tag follows the format `v*` (e.g., `v1.0.0`)
- Verify that CHANGES.md is properly formatted

## Advanced Configuration

### Specify Project IDs Manually

If auto-detection doesn't work, edit [`.pkgmeta`](.pkgmeta):

```yaml
package-as: DJDungeonSpamGuide

wowi-archive-previous: no
wowi-create-changelog: yes
wowi-convert-changelog: yes

enable-nolib-creation: no

manual-changelog:
  filename: CHANGES.md
  markup-type: markdown

# Uncomment and fill in if needed:
# curse-project-id: 123456
# wago-project-id: your-slug

ignore:
  - .git
  - .github
  - README.md
  - DEVELOPMENT_PLAN.md
  - DEBUGGING_GUIDE.md
  - OPTIMIZATION_MODES.md
  - deploy.sh
  - table.csv
```

### Release Beta Versions

For beta releases, use tags like `v1.0.0-beta`:

```bash
git tag v1.0.0-beta
git push origin v1.0.0-beta
```

The packager will automatically mark it as a beta release.

## Quick Reference Commands

```bash
# Update version in .toc file
# Update CHANGES.md

# Commit and release
git add .
git commit -m "Release v1.0.1"
git push
git tag v1.0.1
git push origin v1.0.1

# Delete a tag (if you made a mistake)
git tag -d v1.0.1
git push origin :refs/tags/v1.0.1
```

## Support

- **Packager Documentation**: [BigWigsMods/packager](https://github.com/BigWigsMods/packager)
- **CurseForge Support**: [CurseForge Authors Discord](https://discord.gg/curseforge)
- **Wago Support**: [Wago Discord](https://discord.gg/wago)
