# Usage Examples

This document provides real-world examples of using Social Media Downloader for various scenarios.

---

## Table of Contents

1. [Basic Examples](#basic-examples)
2. [Instagram Examples](#instagram-examples)
3. [Facebook Examples](#facebook-examples)
4. [TikTok Examples](#tiktok-examples)
5. [Twitter/X Examples](#twitterx-examples)
6. [Advanced Examples](#advanced-examples)
7. [Automation Examples](#automation-examples)
8. [OSINT Examples](#osint-examples)

---

## Basic Examples

### Example 1: Quick Download from Any URL

```bash
./scripts/quick_download.sh "https://instagram.com/nasa"
```

**Output:**
```
📥 Starting download...
URL: https://instagram.com/nasa
Saving to: /storage/emulated/0/Downloads/social_media

[instagram] nasa: Downloading profile
[1/100] post_001.jpg
[2/100] post_002.jpg
...

✓ Download completed successfully!
Files saved to: /storage/emulated/0/Downloads/social_media
```

### Example 2: Interactive Menu

```bash
./scripts/social_media_downloader.sh
```

Follow the prompts to select platform and options.

---

## Instagram Examples

### Example 3: Download Public Profile

Download all posts from a public Instagram profile:

```bash
instaloader nasa
```

**What gets downloaded:**
- All photos and videos
- Profile picture
- Captions
- Timestamps
- Metadata

**Output structure:**
```
nasa/
├── 2024-01-15_12-30-45_UTC.jpg
├── 2024-01-15_12-30-45_UTC.txt
├── 2024-01-14_08-22-10_UTC.mp4
├── profile_pic.jpg
└── id
```

### Example 4: Download Private Profile

```bash
instaloader --login=your_username private_account
```

**Steps:**
1. Enter your Instagram username
2. Enter your password
3. Tool logs in and downloads content

### Example 5: Download Stories

```bash
instaloader --stories username
```

**Note:** Stories expire after 24 hours, so download them quickly!

### Example 6: Download Everything

Download posts, stories, highlights, and tagged posts:

```bash
instaloader --stories --highlights --tagged username
```

### Example 7: Download with Comments

```bash
instaloader --comments username
```

**Result:** Each post will have a `.txt` file with all comments.

### Example 8: Download Specific Date Range

```bash
instaloader --post-filter="date >= datetime(2024, 1, 1) and date <= datetime(2024, 12, 31)" username
```

Downloads only posts from 2024.

### Example 9: Download Only Images (No Videos)

```bash
instaloader --no-videos username
```

### Example 10: Download Profile Picture Only

```bash
instaloader --no-posts --no-videos username
```

---

## Facebook Examples

### Example 11: Download Facebook Photos

```bash
gallery-dl "https://facebook.com/username/photos"
```

### Example 12: Download with Login

```bash
gallery-dl -u "your_email@example.com" -p "your_password" "https://facebook.com/username/photos"
```

### Example 13: Download Profile Picture

```bash
gallery-dl "https://facebook.com/username/avatar"
```

### Example 14: Download Photo Albums

```bash
gallery-dl "https://facebook.com/username/photos_albums"
```

### Example 15: Download Specific Album

```bash
gallery-dl "https://www.facebook.com/media/set/?set=a.1234567890"
```

---

## TikTok Examples

### Example 16: Download User's Videos

```bash
gallery-dl "https://www.tiktok.com/@username"
```

### Example 17: Download Specific Video

```bash
gallery-dl "https://www.tiktok.com/@username/video/1234567890"
```

### Example 18: Download Trending Videos

```bash
gallery-dl "https://www.tiktok.com/trending"
```

---

## Twitter/X Examples

### Example 19: Download Tweet Media

```bash
gallery-dl "https://twitter.com/username/status/1234567890"
```

### Example 20: Download User's Media

```bash
gallery-dl "https://twitter.com/username/media"
```

### Example 21: Download with Login

```bash
gallery-dl -u "your_username" -p "your_password" "https://twitter.com/username"
```

---

## Advanced Examples

### Example 22: Batch Download Multiple Profiles

Create a file `profiles.txt`:
```
https://instagram.com/user1
https://instagram.com/user2
https://instagram.com/user3
https://tiktok.com/@user4
https://twitter.com/user5
```

Download all:
```bash
gallery-dl -i profiles.txt
```

### Example 23: Custom Output Directory

```bash
gallery-dl -D ~/MyDownloads/instagram "https://instagram.com/username"
```

### Example 24: Download with Metadata

```bash
gallery-dl --write-metadata "https://instagram.com/username"
```

Creates `.json` files with metadata for each download.

### Example 25: Get URLs Only (No Download)

```bash
gallery-dl -g "https://instagram.com/username"
```

**Output:**
```
https://scontent.cdninstagram.com/v/t51.2885-15/123456789.jpg
https://scontent.cdninstagram.com/v/t51.2885-15/987654321.jpg
...
```

### Example 26: Download with Verbose Output

```bash
gallery-dl -v "https://instagram.com/username"
```

Shows detailed progress and debugging information.

### Example 27: Filter by File Type

```bash
# Only images
gallery-dl --filter "extension in ('jpg', 'png')" "URL"

# Only videos
gallery-dl --filter "extension == 'mp4'" "URL"
```

### Example 28: Limit Number of Downloads

```bash
# Download only first 10 posts
instaloader --count=10 username
```

### Example 29: Download from Hashtag

```bash
instaloader "#python"
```

### Example 30: Download from Location

```bash
instaloader -- -location:123456789
```

---

## Automation Examples

### Example 31: Daily Backup Script

Create `daily_backup.sh`:
```bash
#!/bin/bash
# Daily Instagram backup

ACCOUNTS=("nasa" "natgeo" "spacex")
OUTPUT_DIR=~/Backups/instagram

for account in "${ACCOUNTS[@]}"; do
    echo "Backing up $account..."
    instaloader --dirname-pattern="$OUTPUT_DIR/{profile}" \
                --fast-update \
                "$account"
done

echo "Backup complete!"
```

Run daily with cron:
```bash
crontab -e
# Add: 0 2 * * * /path/to/daily_backup.sh
```

### Example 32: Monitor New Posts

```bash
#!/bin/bash
# Check for new posts every hour

while true; do
    instaloader --fast-update username
    sleep 3600  # Wait 1 hour
done
```

### Example 33: Bulk Download with Error Handling

```bash
#!/bin/bash
# Download multiple profiles with error handling

PROFILES=("user1" "user2" "user3")

for profile in "${PROFILES[@]}"; do
    echo "Downloading $profile..."
    if instaloader "$profile"; then
        echo "✓ Success: $profile"
    else
        echo "✗ Failed: $profile" >> failed.log
    fi
done
```

---

## OSINT Examples

### Example 34: Profile Investigation

```bash
# Download all content
instaloader --login=your_username target_user

# Get follower list
instaloader --login=your_username --followers target_user

# Get following list
instaloader --login=your_username --followees target_user

# Download with geotags
instaloader --geotags target_user
```

### Example 35: Timeline Analysis

```bash
# Download posts with timestamps
instaloader --metadata-json username

# Analyze posting patterns
# (Use external tools to analyze the JSON files)
```

### Example 36: Cross-Platform Investigation

```bash
# Check same username across platforms
./scripts/quick_download.sh "https://instagram.com/username"
./scripts/quick_download.sh "https://twitter.com/username"
./scripts/quick_download.sh "https://tiktok.com/@username"
```

### Example 37: Archive Before Deletion

```bash
# Quickly archive everything before account deletion
instaloader --stories --highlights --tagged --comments --geotags username
```

---

## Real-World Scenarios

### Scenario 1: Personal Archive

**Goal:** Backup your own Instagram account

```bash
# Full backup
instaloader --login=your_username \
            --stories \
            --highlights \
            --tagged \
            --saved \
            your_username

# Save to specific location
instaloader --dirname-pattern="~/Backups/Instagram/{date}" \
            --login=your_username \
            your_username
```

### Scenario 2: Research Project

**Goal:** Collect data for academic research

```bash
# Download posts from multiple accounts
cat research_accounts.txt | while read account; do
    instaloader --metadata-json \
                --comments \
                --geotags \
                "$account"
done

# Analyze metadata with Python/R
```

### Scenario 3: Content Creator

**Goal:** Download competitor content for inspiration

```bash
# Download recent posts only
instaloader --count=20 competitor_username

# Download only images (no videos)
instaloader --no-videos competitor_username
```

### Scenario 4: Digital Forensics

**Goal:** Preserve evidence

```bash
# Download everything with metadata
gallery-dl --write-metadata \
           --write-info-json \
           "URL"

# Create checksums for verification
find downloads/ -type f -exec md5sum {} \; > checksums.txt
```

### Scenario 5: Brand Monitoring

**Goal:** Track brand mentions

```bash
# Download posts with brand hashtag
instaloader "#yourbrand"

# Monitor daily
# (Set up cron job to run daily)
```

---

## Configuration Examples

### Example 38: Save Login Credentials

Create `~/.config/gallery-dl/config.json`:
```json
{
    "extractor": {
        "instagram": {
            "username": "your_username",
            "password": "your_password"
        },
        "facebook": {
            "username": "your_email@example.com",
            "password": "your_password"
        },
        "twitter": {
            "username": "your_username",
            "password": "your_password"
        }
    }
}
```

### Example 39: Custom Filename Pattern

```json
{
    "extractor": {
        "instagram": {
            "filename": "{date:%Y-%m-%d}_{username}_{shortcode}.{extension}"
        }
    }
}
```

### Example 40: Proxy Configuration

```json
{
    "extractor": {
        "proxy": "http://proxy.example.com:8080"
    }
}
```

---

## Tips & Tricks

### Tip 1: Resume Interrupted Downloads

Just run the same command again. Most tools automatically skip already-downloaded files.

### Tip 2: Avoid Rate Limiting

Add delays between requests:
```bash
for user in user1 user2 user3; do
    instaloader "$user"
    sleep 300  # Wait 5 minutes
done
```

### Tip 3: Save Storage Space

Download only thumbnails or lower quality:
```bash
instaloader --no-videos --no-video-thumbnails username
```

### Tip 4: Organize Downloads

Use custom directory patterns:
```bash
instaloader --dirname-pattern="{profile}/{date:%Y/%m}" username
```

### Tip 5: Check What Will Be Downloaded

Use `-g` flag to see URLs without downloading:
```bash
gallery-dl -g "URL" | wc -l  # Count files
```

---

## Common Workflows

### Workflow 1: Daily Monitoring

```bash
#!/bin/bash
# Monitor accounts for new content

ACCOUNTS=("account1" "account2" "account3")

for account in "${ACCOUNTS[@]}"; do
    instaloader --fast-update \
                --stories \
                --dirname-pattern="~/Monitor/{profile}" \
                "$account"
done
```

### Workflow 2: Weekly Backup

```bash
#!/bin/bash
# Weekly full backup

DATE=$(date +%Y-%m-%d)
BACKUP_DIR=~/Backups/$DATE

mkdir -p "$BACKUP_DIR"

# Backup your account
instaloader --dirname-pattern="$BACKUP_DIR/{profile}" \
            --login=your_username \
            --stories \
            --highlights \
            your_username

# Create archive
tar -czf "$BACKUP_DIR.tar.gz" "$BACKUP_DIR"
```

### Workflow 3: Research Data Collection

```bash
#!/bin/bash
# Collect research data

# Download posts
instaloader --metadata-json \
            --comments \
            --geotags \
            research_account

# Extract metadata to CSV
python3 extract_metadata.py research_account/ > data.csv

# Analyze
Rscript analyze.R data.csv
```

---

## Troubleshooting Examples

### Problem: Login Fails

**Solution:**
```bash
# Clear session and try again
rm -rf ~/.config/instaloader/session-*
instaloader --login=your_username target_user
```

### Problem: Rate Limited

**Solution:**
```bash
# Wait and retry with delays
sleep 3600  # Wait 1 hour
instaloader --sleep=5 username  # 5 second delay between requests
```

### Problem: Out of Storage

**Solution:**
```bash
# Check available space
df -h

# Download to external storage
instaloader --dirname-pattern="/sdcard/Downloads/{profile}" username
```

---

## More Examples

For more examples and use cases, check:
- [ANDROID_INSTRUCTIONS.md](../docs/ANDROID_INSTRUCTIONS.md)
- [TOOLS_REFERENCE.md](../docs/TOOLS_REFERENCE.md)
- [gallery-dl documentation](https://github.com/mikf/gallery-dl)
- [instaloader documentation](https://instaloader.github.io/)

---

**Have a useful example to share?** Contribute to this document! See [CONTRIBUTING.md](../CONTRIBUTING.md)
