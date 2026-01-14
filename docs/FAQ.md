# Frequently Asked Questions (FAQ)

## General Questions

### What is Social Media Downloader?

Social Media Downloader is a command-line tool that allows you to download content (photos, videos, stories, etc.) from over 700 social media platforms. It's designed to work on Android devices via Termux and Linux systems without requiring a graphical interface.

### Is this tool free?

Yes! This is a completely free and open-source project released under the MIT License. You can use, modify, and distribute it freely.

### Which platforms are supported?

The tool supports 700+ platforms including Instagram, Facebook, TikTok, Twitter/X, Reddit, Tumblr, Flickr, DeviantArt, Pinterest, YouTube, and many more. See the full list in the [TOOLS_REFERENCE.md](TOOLS_REFERENCE.md).

### Do I need a powerful phone to use this?

No! The tool works on any Android device that can run Termux. It requires approximately 200MB of storage for the tools and dependencies.

---

## Installation & Setup

### How do I install Termux?

Download Termux from F-Droid (recommended): https://f-droid.org/packages/com.termux/

**Important:** Do NOT install from Google Play Store as that version is outdated and unsupported.

### The setup script is taking too long. Is this normal?

Yes, the first-time setup can take 5-15 minutes depending on your internet speed. It needs to download and install Python, pip, and several packages. Be patient!

### I get "Permission denied" errors. What should I do?

Run these commands:
```bash
termux-setup-storage  # Grant storage permission
chmod +x scripts/*.sh  # Make scripts executable
```

### Can I use this on iOS?

Currently, no. iOS doesn't have a terminal emulator like Termux. The tool is designed for Android and Linux systems only.

---

## Usage Questions

### How do I download from a private Instagram account?

Use the login option when prompted:
```bash
./scripts/social_media_downloader.sh
# Choose: 1 (Instagram)
# Enter the private account username
# When asked "Need login?": y
# Enter YOUR Instagram credentials
```

### Where are my downloaded files saved?

By default, files are saved to:
- Android: `/storage/emulated/0/Downloads/social_media/`
- Linux: `~/Downloads/social_media/`

You can change this in the settings menu (option 7).

### Can I download multiple profiles at once?

Yes! Create a text file with URLs (one per line) and use:
```bash
gallery-dl -i urls.txt
```

### How do I download Instagram stories?

```bash
instaloader --stories username
```

Or use the interactive menu and choose option 2 (All posts + stories).

### Can I download someone's follower list?

Yes, but you need to login:
```bash
instaloader --login=your_username target_username
```

The follower/following lists will be saved as text files.

---

## Platform-Specific Questions

### Why doesn't Facebook work well?

Facebook has very strong anti-scraping measures. They actively block automated tools, require login for most content, and frequently change their website structure. Success rate is around 40%. Instagram and TikTok work much better.

### Can I download from Twitter/X?

Yes, but with limitations. Twitter/X has restricted API access and blocks many scrapers. Media downloads usually work, but tweet text extraction is limited. Success rate is around 60%.

### Does this work with TikTok?

Yes! TikTok support is good with an 85% success rate. You can download user videos and profile information.

### Can I download YouTube videos?

Yes, through gallery-dl which integrates with yt-dlp. However, for dedicated YouTube downloading, consider using yt-dlp directly.

---

## Troubleshooting

### "Command not found" error

Make sure scripts are executable:
```bash
chmod +x scripts/social_media_downloader.sh
./scripts/social_media_downloader.sh
```

### "gallery-dl: command not found"

The tools aren't installed. Run:
```bash
pip3 install gallery-dl instaloader
```

Or re-run the setup script:
```bash
./scripts/termux_setup.sh
```

### "Login required" even after logging in

This can happen if:
1. Your credentials are incorrect
2. The platform requires 2FA (two-factor authentication)
3. Your account is flagged for suspicious activity
4. The platform detected automation

Try logging in through a web browser first, then try again.

### Downloads are very slow

This could be due to:
- Slow internet connection
- Platform rate limiting
- Large file sizes

Try downloading fewer items at once or wait a few hours if rate limited.

### "Rate limited" or "Too many requests"

You're downloading too fast. The platform has temporarily blocked your IP. Solutions:
- Wait 1-2 hours
- Use a different internet connection
- Add delays between requests
- Use a VPN (with caution)

### Facebook keeps failing

Unfortunately, this is common. Facebook has the strongest anti-scraping measures. Try:
1. Using login credentials
2. Downloading only profile pictures (more reliable)
3. Trying at different times of day
4. Using a browser instead

### The script crashes or freezes

1. Check your internet connection
2. Ensure you have enough storage space
3. Try updating the tools: `pip3 install --upgrade gallery-dl instaloader`
4. Restart Termux
5. Check for error messages in verbose mode: `gallery-dl -v "URL"`

---

## Legal & Privacy

### Is this legal?

Using this tool is legal for downloading public content that you have permission to access. However:
- Respect copyright and intellectual property
- Follow platform Terms of Service
- Comply with local laws
- Don't use for harassment or illegal activities

### Will my account get banned?

There's always a small risk when using automation tools. To minimize risk:
- Don't download excessively
- Add delays between requests
- Don't violate platform ToS
- Use for personal archiving only

### Are my credentials safe?

Yes. All credentials are stored locally on your device in plain text configuration files. They are never sent to third parties. Only you and the social media platforms have access to them.

### Can others see what I'm downloading?

No. All downloads happen directly between your device and the social media platform. This tool doesn't track or report your activity.

---

## Advanced Usage

### How do I save my login credentials?

Create a config file:
```bash
mkdir -p ~/.config/gallery-dl
nano ~/.config/gallery-dl/config.json
```

Add:
```json
{
    "extractor": {
        "instagram": {
            "username": "your_username",
            "password": "your_password"
        }
    }
}
```

### Can I schedule automatic downloads?

Yes, using cron:
```bash
crontab -e
```

Add a line like:
```
0 2 * * * /path/to/social_media_downloader.sh
```

This runs daily at 2 AM.

### How do I download only specific content types?

Use gallery-dl filters:
```bash
# Only images
gallery-dl --filter "extension == 'jpg' or extension == 'png'" "URL"

# Only videos
gallery-dl --filter "extension == 'mp4'" "URL"

# Posts from specific date range
instaloader --post-filter="date >= datetime(2024, 1, 1)" username
```

### Can I use this with a proxy?

Yes, configure in gallery-dl config:
```json
{
    "extractor": {
        "proxy": "http://proxy.example.com:8080"
    }
}
```

Or use environment variables:
```bash
export HTTP_PROXY="http://proxy.example.com:8080"
export HTTPS_PROXY="http://proxy.example.com:8080"
```

---

## Performance

### How much storage space do I need?

It depends on what you're downloading:
- Profile with 100 posts: ~500MB
- 10 stories: ~50MB
- Single profile picture: ~1MB
- 50 TikTok videos: ~200MB

Ensure you have enough free space before starting large downloads.

### How long does it take to download a profile?

Varies based on:
- Number of posts
- File sizes
- Internet speed
- Platform rate limits

Typical times:
- 100 Instagram posts: 5-10 minutes
- 50 TikTok videos: 3-5 minutes
- Facebook album: 2-5 minutes

### Can I speed up downloads?

gallery-dl supports parallel downloads. Add to config:
```json
{
    "downloader": {
        "part": true,
        "part-directory": "/tmp/.download/",
        "rate": null,
        "retries": 4,
        "timeout": 30.0
    }
}
```

---

## Updates & Maintenance

### How do I update the tool?

```bash
cd social-media-downloader
git pull origin main
pip3 install --upgrade gallery-dl instaloader
```

### How often should I update?

Check for updates monthly or when you encounter issues. Social media platforms frequently change, so updates may include fixes for broken functionality.

### How do I uninstall?

```bash
# Remove the repository
rm -rf ~/social-media-downloader

# Uninstall Python packages (optional)
pip3 uninstall gallery-dl instaloader
```

---

## Contributing

### How can I contribute?

See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed guidelines. You can:
- Report bugs
- Suggest features
- Improve documentation
- Submit code fixes
- Add platform support

### I found a bug. Where do I report it?

Open an issue on GitHub: https://github.com/YOUR_USERNAME/social-media-downloader/issues

Include:
- Clear description
- Steps to reproduce
- Expected vs actual behavior
- Environment details
- Error messages

### Can I add support for a new platform?

Yes! If the platform is supported by gallery-dl, it should work automatically. If not, you can:
1. Check if gallery-dl has an extractor for it
2. Request it in gallery-dl's repository
3. Write a custom script

---

## Comparison with Other Tools

### How is this different from other downloaders?

**Advantages:**
- Works on Android (Termux)
- No GUI required
- Supports 700+ platforms
- Free and open-source
- Active development
- Easy to use menu system

**Disadvantages:**
- Command-line only (no GUI)
- Requires some technical knowledge
- Platform restrictions (especially Facebook)

### Should I use this or a web-based downloader?

**Use this tool if:**
- You want to download large amounts of content
- You need automation
- You want to save metadata
- You're comfortable with command line

**Use web-based tools if:**
- You only need to download a few items
- You don't want to install anything
- You prefer a graphical interface

---

## Still Have Questions?

- 📖 Check the [documentation](.)
- 💬 Ask in [GitHub Discussions](https://github.com/YOUR_USERNAME/social-media-downloader/discussions)
- 🐛 Report issues on [GitHub](https://github.com/YOUR_USERNAME/social-media-downloader/issues)
- 📧 Contact the maintainers

---

**Last Updated:** January 14, 2026
