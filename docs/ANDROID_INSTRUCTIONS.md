# Social Media Downloader for Android (Termux)
## Complete Setup and Usage Guide

This package contains scripts to download pictures and information from social media platforms on your Android phone **without needing a graphical interface**. Everything runs in the command line.

---

## 📱 What You Need

1. **Android phone** (any version)
2. **Termux app** (free terminal emulator)
3. **Internet connection**
4. **Storage space** for downloads

---

## 🚀 Quick Start (3 Steps)

### Step 1: Install Termux

1. Download **Termux** from F-Droid (recommended) or GitHub
   - F-Droid: https://f-droid.org/packages/com.termux/
   - GitHub: https://github.com/termux/termux-app/releases

2. Open Termux (you'll see a black terminal screen)

### Step 2: Setup (First Time Only)

Copy and paste these commands into Termux:

```bash
# Give Termux storage permission
termux-setup-storage

# Download the setup script
curl -O https://raw.githubusercontent.com/[YOUR_REPO]/termux_setup.sh

# Make it executable
chmod +x termux_setup.sh

# Run setup (takes 5-10 minutes)
./termux_setup.sh
```

**OR** if you have the files already:

```bash
# Copy the scripts to Termux
# (Transfer via USB, Bluetooth, or cloud storage)

# Make them executable
chmod +x termux_setup.sh
chmod +x social_media_downloader.sh
chmod +x quick_download.sh

# Run setup
./termux_setup.sh
```

### Step 3: Start Downloading!

```bash
# Run the main script
./social_media_downloader.sh
```

---

## 📋 What Gets Installed

The setup script installs:
- ✅ Python 3
- ✅ gallery-dl (downloads from 700+ sites)
- ✅ instaloader (Instagram specialist)
- ✅ wget, curl (download tools)
- ✅ All required dependencies

**Storage needed:** ~200MB for tools

---

## 🎯 How to Use

### Option 1: Interactive Menu (Recommended)

```bash
./social_media_downloader.sh
```

You'll see a menu:
```
================================================
   Social Media Downloader for Android/Termux
================================================

Choose a platform:

1) 📸 Instagram
2) 📘 Facebook
3) 🎵 TikTok
4) 🐦 Twitter/X
5) 🌐 Any URL (Universal)

6) 📁 View Downloads
7) ⚙️  Settings
8) ❌ Exit

Enter your choice (1-8):
```

Just type the number and press Enter!

### Option 2: Quick Download (One Command)

```bash
./quick_download.sh "https://instagram.com/username"
```

This downloads immediately without menus.

---

## 📸 Platform-Specific Examples

### Instagram

**Download all posts:**
```bash
# In the menu, choose: 1 (Instagram)
# Enter username: nasa
# Choose option: 1 (All posts)
# Need login?: n
```

**Download private profile:**
```bash
# Choose: 1 (Instagram)
# Enter username: private_account
# Choose option: 1 (All posts)
# Need login?: y
# Your Instagram username: your_username
# (Enter your password when prompted)
```

**Download stories:**
```bash
# Choose: 1 (Instagram)
# Enter username: username
# Choose option: 2 (All posts + stories)
```

### Facebook

**Download photos:**
```bash
# Choose: 2 (Facebook)
# Enter URL: https://facebook.com/amanda.radtke.7
# Choose option: 1 (All photos)
# Login?: y
# Email: your_email@example.com
# Password: your_password
```

**Note:** Facebook is difficult to scrape and often blocks automated tools.

### TikTok

```bash
# Choose: 3 (TikTok)
# Enter username: username
# (Downloads all videos from that user)
```

### Twitter/X

```bash
# Choose: 4 (Twitter/X)
# Enter URL: https://twitter.com/username/status/123456789
# Login?: n (try without first)
```

### Any Other Site

```bash
# Choose: 5 (Any URL)
# Enter URL: https://reddit.com/r/pics/top
# Login?: n
```

---

## 📁 Where Are My Downloads?

All downloads are saved to:
```
/storage/emulated/0/Downloads/social_media/
```

Or in Termux:
```
~/Downloads/social_media/
```

**Folder structure:**
```
social_media/
├── instagram/
│   ├── username1/
│   ├── username2/
├── facebook/
│   ├── profile1/
├── tiktok/
│   ├── user1/
├── twitter/
└── downloads/
```

**To view your downloads:**
- In the menu, choose option 6 (View Downloads)
- Or use: `ls ~/Downloads/social_media/`
- Or open your phone's file manager app

---

## 🔧 Manual Commands (Advanced)

If you prefer typing commands directly:

### Instagram Commands

```bash
# Download all posts
instaloader username

# Download with login
instaloader --login=your_username target_username

# Download stories
instaloader --stories username

# Download profile picture only
instaloader --no-posts --no-videos username

# Download with comments
instaloader --comments --geotags username
```

### Universal Download (Any Site)

```bash
# Basic download
gallery-dl "URL"

# With login
gallery-dl -u "username" -p "password" "URL"

# Get URLs only (don't download)
gallery-dl -g "URL"

# Custom output directory
gallery-dl -D ~/Downloads/my_folder "URL"

# Verbose output (see what's happening)
gallery-dl -v "URL"
```

### Facebook Commands

```bash
# Download photos
gallery-dl "https://facebook.com/username/photos"

# Download with login
gallery-dl -u "email" -p "password" "https://facebook.com/username/photos"

# Download profile picture
gallery-dl "https://facebook.com/username/avatar"

# Download albums
gallery-dl "https://facebook.com/username/photos_albums"
```

---

## 💡 Tips & Tricks

### 1. Save Credentials (Don't Type Password Every Time)

Create a config file:
```bash
mkdir -p ~/.config/gallery-dl
nano ~/.config/gallery-dl/config.json
```

Add this (replace with your info):
```json
{
    "extractor": {
        "instagram": {
            "username": "your_instagram_username",
            "password": "your_instagram_password"
        },
        "facebook": {
            "username": "your_facebook_email",
            "password": "your_facebook_password"
        }
    }
}
```

Save: Ctrl+X, then Y, then Enter

Now you don't need to type passwords!

### 2. Download Multiple Profiles

Create a file with URLs:
```bash
nano urls.txt
```

Add URLs (one per line):
```
https://instagram.com/user1
https://instagram.com/user2
https://instagram.com/user3
```

Download all:
```bash
gallery-dl -i urls.txt
```

### 3. Schedule Automatic Downloads

Use cron to download daily:
```bash
crontab -e
```

Add this line (downloads daily at 2 AM):
```
0 2 * * * /data/data/com.termux/files/home/social_media_downloader.sh
```

### 4. Check Download Progress

While downloading, you'll see progress:
```
[instagram] username: Downloading profile
[instagram] username: Downloading posts
[1/50] post_123.jpg
[2/50] post_456.jpg
...
```

### 5. Resume Interrupted Downloads

If download stops, just run the same command again. Most tools will skip already downloaded files.

---

## ⚠️ Troubleshooting

### "Command not found"

**Problem:** Script not executable or not in current directory

**Solution:**
```bash
chmod +x social_media_downloader.sh
./social_media_downloader.sh
```

### "gallery-dl: command not found"

**Problem:** Tools not installed

**Solution:**
```bash
pip install gallery-dl instaloader
```

### "Login required"

**Problem:** Content is private or platform requires authentication

**Solution:** Use the login option and enter your credentials

### "Rate limited" or "Too many requests"

**Problem:** You're downloading too fast

**Solution:** 
- Wait 1-2 hours
- Use a different internet connection
- Add delays between downloads

### "Download failed"

**Problem:** Various reasons (blocked, private, deleted)

**Solution:**
1. Check if profile/URL is valid
2. Try with login
3. Check internet connection
4. Try a different platform (Instagram works better than Facebook)

### "Permission denied"

**Problem:** No storage access

**Solution:**
```bash
termux-setup-storage
# Then allow storage permission in Android settings
```

### Facebook not working

**Problem:** Facebook heavily blocks scrapers

**Solution:**
- Try with login
- Use browser instead
- Facebook is the hardest platform to scrape

---

## 📊 What Can You Download?

### Instagram ✅ (Works Great!)
- ✅ Posts (photos/videos)
- ✅ Stories
- ✅ Highlights
- ✅ Reels
- ✅ IGTV
- ✅ Profile picture
- ✅ Comments
- ✅ Geotags
- ✅ Captions
- ✅ Follower lists (with login)

### Facebook ⚠️ (Limited)
- ⚠️ Photos (sometimes works)
- ⚠️ Profile picture (sometimes works)
- ❌ Posts (rarely works)
- ❌ Comments (not supported)

### TikTok ✅ (Works)
- ✅ Videos
- ✅ Profile info
- ⚠️ Comments (limited)

### Twitter/X ⚠️ (Limited)
- ⚠️ Media (photos/videos)
- ❌ Tweets (restricted)

### Reddit ✅ (Works Great!)
- ✅ Posts
- ✅ Images
- ✅ Videos
- ✅ Subreddit content

### And 700+ other sites!

---

## 🔒 Privacy & Legal

**Important:**
- ⚠️ Only download content you have permission to access
- ⚠️ Respect privacy settings
- ⚠️ Don't violate platform Terms of Service
- ⚠️ Don't use for harassment or stalking
- ⚠️ Be aware of local laws

**Your credentials:**
- Stored locally on your phone only
- Never sent to third parties
- Used only to authenticate with social media platforms

---

## 🆘 Need Help?

### Check if tools are installed:
```bash
gallery-dl --version
instaloader --version
python --version
```

### Test with a public profile:
```bash
instaloader nasa
```

### View error messages:
```bash
gallery-dl -v "URL"
```

### Update tools:
```bash
pip install --upgrade gallery-dl instaloader
```

---

## 🎓 Examples for Your Case

### Download from amanda.radtke.7 (Facebook)

**Method 1: Using the menu**
```bash
./social_media_downloader.sh
# Choose: 2 (Facebook)
# Enter: amanda.radtke.7
# Choose: 1 (All photos)
# Login: y
# Enter your Facebook email and password
```

**Method 2: Direct command**
```bash
gallery-dl -u "your_email" -p "your_password" "https://facebook.com/amanda.radtke.7/photos"
```

**Method 3: Quick script**
```bash
./quick_download.sh "https://facebook.com/amanda.radtke.7/photos"
```

**Note:** Facebook is difficult. If it doesn't work:
1. Try the profile picture only: `https://facebook.com/amanda.radtke.7/avatar`
2. Try albums: `https://facebook.com/amanda.radtke.7/photos_albums`
3. Check if profile is public
4. Use Instagram instead if they have an Instagram account

---

## 📦 File Sizes

Typical download sizes:
- Instagram profile (100 posts): ~500MB
- Instagram stories (10 stories): ~50MB
- Profile picture: ~1MB
- TikTok profile (50 videos): ~200MB

Make sure you have enough storage space!

---

## 🔄 Updating

To update the tools:
```bash
pip install --upgrade gallery-dl instaloader
```

To update Termux packages:
```bash
pkg update && pkg upgrade
```

---

## ✅ Quick Reference Card

```bash
# Setup (first time only)
./termux_setup.sh

# Main menu
./social_media_downloader.sh

# Quick download
./quick_download.sh "URL"

# Instagram
instaloader username

# Any URL
gallery-dl "URL"

# With login
gallery-dl -u "user" -p "pass" "URL"

# View downloads
ls ~/Downloads/social_media/

# Update tools
pip install --upgrade gallery-dl instaloader
```

---

## 📝 Summary

1. **Install Termux** from F-Droid
2. **Run setup script** (one time)
3. **Run downloader script** 
4. **Choose platform** and enter username/URL
5. **Wait for download**
6. **Find files** in Downloads folder

**Best platforms:** Instagram, TikTok, Reddit  
**Hardest platform:** Facebook  

**Most reliable tool:** gallery-dl (works on 700+ sites)

---

**Version:** 1.0  
**Last Updated:** January 2026  
**Tested on:** Android 10, 11, 12, 13, 14

**Questions?** Check the troubleshooting section above!
