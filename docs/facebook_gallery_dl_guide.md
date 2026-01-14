# How to Use gallery-dl with Facebook Profile

## Your URL: https://facebook.com/amanda.radtke.7

gallery-dl supports Facebook, but with some limitations due to Facebook's privacy settings and anti-scraping measures.

---

## What gallery-dl Can Extract from Facebook:

✅ **Profile Photos** - Public photos from the profile  
✅ **Albums** - Public photo albums  
✅ **Avatar** - Profile picture  
✅ **Videos** - Public videos  
✅ **Profile Info** - Basic public information  

❌ **Private content** - Requires login and may still be blocked  
❌ **Posts/Timeline** - Limited or no access  
❌ **Comments** - Not supported  

---

## Basic Commands for Your URL

### 1. Download All Public Photos
```bash
gallery-dl "https://facebook.com/amanda.radtke.7/photos"
```

### 2. Download Profile Picture (Avatar)
```bash
gallery-dl "https://facebook.com/amanda.radtke.7/avatar"
```

### 3. Download Photo Albums
```bash
gallery-dl "https://facebook.com/amanda.radtke.7/photos_albums"
```

### 4. Get Profile Information
```bash
gallery-dl "https://facebook.com/amanda.radtke.7/info"
```

### 5. Download from Main Profile (tries to get everything)
```bash
gallery-dl "https://facebook.com/amanda.radtke.7"
```

---

## With Authentication (for better access)

Facebook often requires login to see content. Use these commands:

### Using Username/Password
```bash
gallery-dl -u "your_facebook_email" -p "your_facebook_password" "https://facebook.com/amanda.radtke.7/photos"
```

### Using Config File (Recommended for repeated use)

Create a config file: `~/.config/gallery-dl/config.json`

```json
{
    "extractor": {
        "facebook": {
            "username": "your_facebook_email@example.com",
            "password": "your_facebook_password",
            "cookies": null
        }
    }
}
```

Then run:
```bash
gallery-dl "https://facebook.com/amanda.radtke.7/photos"
```

---

## Advanced Options

### Get URLs Only (Don't Download)
```bash
gallery-dl -g "https://facebook.com/amanda.radtke.7/photos"
```
This will list all photo URLs without downloading them.

### Download with Metadata
```bash
gallery-dl --write-metadata "https://facebook.com/amanda.radtke.7/photos"
```
Saves metadata (captions, dates, etc.) in JSON files.

### Custom Output Directory
```bash
gallery-dl -D ~/Downloads/facebook_photos "https://facebook.com/amanda.radtke.7/photos"
```

### Verbose Output (See What's Happening)
```bash
gallery-dl -v "https://facebook.com/amanda.radtke.7/photos"
```

---

## Important Notes

### ⚠️ Facebook Limitations:

1. **Privacy Settings**: If the profile is private or has restricted privacy settings, you won't be able to download content even with login.

2. **Anti-Scraping**: Facebook actively blocks automated tools. You may encounter:
   - Rate limiting
   - CAPTCHA challenges
   - Account restrictions
   - IP blocks

3. **Login Required**: Most Facebook content requires authentication.

4. **Limited Success Rate**: Facebook scraping is notoriously difficult and unreliable.

---

## Better Alternative for Facebook: Selenium/Playwright

If gallery-dl doesn't work well for Facebook, use browser automation:

### Using Selenium (Python)

```python
from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import requests

# Setup
driver = webdriver.Chrome()
driver.get('https://www.facebook.com/')

# Login
email_input = driver.find_element(By.ID, 'email')
password_input = driver.find_element(By.ID, 'pass')
email_input.send_keys('your_email@example.com')
password_input.send_keys('your_password')
driver.find_element(By.NAME, 'login').click()

time.sleep(5)  # Wait for login

# Navigate to profile
driver.get('https://facebook.com/amanda.radtke.7')

# Scroll to load more content
for _ in range(5):
    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    time.sleep(2)

# Find all images
images = driver.find_elements(By.TAG_NAME, 'img')
for idx, img in enumerate(images):
    img_url = img.get_attribute('src')
    if img_url and 'scontent' in img_url:  # Facebook CDN
        print(f"Found image: {img_url}")
        # Download
        response = requests.get(img_url)
        with open(f'photo_{idx}.jpg', 'wb') as f:
            f.write(response.content)

driver.quit()
```

---

## Step-by-Step: What to Try First

### Step 1: Try Without Login (Public Content Only)
```bash
gallery-dl "https://facebook.com/amanda.radtke.7/photos"
```

### Step 2: If That Fails, Try with Login
```bash
gallery-dl -u "your_email" -p "your_password" "https://facebook.com/amanda.radtke.7/photos"
```

### Step 3: Try Specific Extractors
```bash
# Try avatar
gallery-dl "https://facebook.com/amanda.radtke.7/avatar"

# Try albums
gallery-dl "https://facebook.com/amanda.radtke.7/photos_albums"
```

### Step 4: If All Fails, Use Browser Automation
Use the Selenium script above or Playwright.

---

## Expected Output

If successful, you'll see:
```
# gallery-dl "https://facebook.com/amanda.radtke.7/photos"
amanda.radtke.7/
├── photo_001.jpg
├── photo_002.jpg
├── photo_003.jpg
└── ...
```

If it fails:
```
[facebook] amanda.radtke.7: Login required
[facebook] amanda.radtke.7: Unable to extract data
```

---

## Troubleshooting

### "Login required"
- Add `-u` and `-p` flags with your Facebook credentials
- Or create a config file with credentials

### "Unable to extract data"
- Profile may be private
- Facebook may be blocking the tool
- Try different extractor URLs (photos, avatar, albums)

### "Rate limited"
- Wait a few hours
- Use a different IP address
- Add delays between requests

### "CAPTCHA required"
- Facebook detected automation
- Use browser automation instead
- Try from a different device/IP

---

## Recommended Approach for Facebook

Given Facebook's strong anti-scraping measures, here's the best strategy:

1. **First**: Try gallery-dl with authentication
2. **If that fails**: Use facebook-scraper Python library (for public pages)
3. **If that fails**: Use Selenium/Playwright with manual login
4. **Last resort**: Manually save content through browser

---

## Legal & Ethical Considerations

⚠️ **Important:**
- Only access content you have permission to view
- Respect privacy settings
- Don't violate Facebook's Terms of Service
- Be aware of local laws regarding data collection
- Don't harass or stalk individuals

---

## Summary

For your URL `https://facebook.com/amanda.radtke.7`, try these in order:

```bash
# 1. Try photos with login
gallery-dl -u "your_email" -p "your_password" "https://facebook.com/amanda.radtke.7/photos"

# 2. Try avatar (usually works)
gallery-dl "https://facebook.com/amanda.radtke.7/avatar"

# 3. Try albums
gallery-dl "https://facebook.com/amanda.radtke.7/photos_albums"

# 4. Get URLs only to see what's available
gallery-dl -g "https://facebook.com/amanda.radtke.7/photos"
```

**Reality Check**: Facebook scraping is difficult and unreliable. If you need consistent access to Facebook data, consider:
- Using Facebook's official API (requires app approval)
- Manual collection through the browser
- Professional scraping services (Bright Data, Apify, etc.)
