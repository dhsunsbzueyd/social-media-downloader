# Contributing to Social Media Downloader

First off, thank you for considering contributing to Social Media Downloader! It's people like you that make this tool better for everyone.

## 🎯 Ways to Contribute

There are many ways you can contribute to this project:

- 🐛 **Report bugs** - Found a bug? Let us know!
- 💡 **Suggest features** - Have an idea? We'd love to hear it!
- 📝 **Improve documentation** - Help make our docs clearer
- 🔧 **Fix bugs** - Submit a pull request
- ✨ **Add features** - Implement new functionality
- 🧪 **Write tests** - Help improve code quality
- 🌍 **Translate** - Help make the tool multilingual

## 📋 Code of Conduct

This project adheres to a code of conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to the project maintainers.

### Our Standards

- ✅ Be respectful and inclusive
- ✅ Welcome newcomers
- ✅ Accept constructive criticism
- ✅ Focus on what's best for the community
- ❌ No harassment or trolling
- ❌ No spam or off-topic content

## 🐛 Reporting Bugs

Before creating a bug report, please check existing issues to avoid duplicates.

### How to Submit a Good Bug Report

Include the following information:

- **Clear title** - Summarize the issue
- **Description** - Detailed explanation of the bug
- **Steps to reproduce** - How to trigger the bug
- **Expected behavior** - What should happen
- **Actual behavior** - What actually happens
- **Environment** - OS, Python version, tool versions
- **Screenshots** - If applicable
- **Error messages** - Full error output

**Example:**

```markdown
**Title:** Instagram download fails with private profiles

**Description:**
When trying to download from a private Instagram profile with login credentials, 
the tool fails with a "Login required" error even after providing valid credentials.

**Steps to Reproduce:**
1. Run `./scripts/social_media_downloader.sh`
2. Choose option 1 (Instagram)
3. Enter a private profile username
4. Choose to login with valid credentials
5. Error occurs

**Expected Behavior:**
Should successfully login and download content

**Actual Behavior:**
Fails with "Login required" error

**Environment:**
- OS: Android 12 (Termux)
- Python: 3.11
- instaloader: 4.15
- gallery-dl: 1.31.2

**Error Message:**
```
[instagram] Error: Login required
```
```

## 💡 Suggesting Features

We love feature suggestions! Before submitting:

1. **Check existing suggestions** - It might already be planned
2. **Be specific** - Clearly describe the feature
3. **Explain the use case** - Why is this useful?
4. **Consider alternatives** - Are there other ways to achieve this?

### Feature Request Template

```markdown
**Feature Title:** Add support for LinkedIn downloads

**Description:**
Add the ability to download profile pictures and posts from LinkedIn.

**Use Case:**
Many users want to archive their LinkedIn content or download 
professional photos for portfolios.

**Proposed Solution:**
Integrate LinkedIn support using gallery-dl or a dedicated scraper.

**Alternatives Considered:**
- Manual download (time-consuming)
- Third-party tools (not integrated)

**Additional Context:**
LinkedIn has an API but requires authentication.
```

## 🔧 Pull Request Process

### Before You Start

1. **Fork the repository**
2. **Create a new branch** - `git checkout -b feature/your-feature-name`
3. **Check existing PRs** - Avoid duplicate work

### Development Workflow

1. **Make your changes**
   - Follow the existing code style
   - Add comments where necessary
   - Keep changes focused and atomic

2. **Test your changes**
   - Test on your local machine
   - Test on Android/Termux if possible
   - Ensure no regressions

3. **Update documentation**
   - Update README if needed
   - Add examples if applicable
   - Update CHANGELOG.md

4. **Commit your changes**
   - Use clear, descriptive commit messages
   - Follow conventional commits format

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Open a Pull Request**
   - Use the PR template
   - Link related issues
   - Provide detailed description

### Commit Message Guidelines

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code refactoring
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks

**Examples:**

```bash
feat(instagram): add support for downloading reels

- Added reel detection logic
- Updated menu to include reels option
- Added documentation for reel downloads

Closes #123
```

```bash
fix(facebook): handle rate limiting errors

- Added retry logic with exponential backoff
- Improved error messages
- Updated documentation

Fixes #456
```

### Pull Request Checklist

Before submitting, ensure:

- [ ] Code follows the project style
- [ ] All tests pass
- [ ] Documentation is updated
- [ ] Commit messages are clear
- [ ] PR description is detailed
- [ ] Related issues are linked
- [ ] No merge conflicts
- [ ] Changes are tested

### PR Review Process

1. **Automated checks** - CI/CD runs automatically
2. **Code review** - Maintainers review your code
3. **Feedback** - Address any requested changes
4. **Approval** - PR is approved
5. **Merge** - Changes are merged into main branch

## 📝 Code Style Guidelines

### Shell Scripts

- Use `#!/bin/bash` shebang
- Use 4 spaces for indentation
- Add comments for complex logic
- Use descriptive variable names
- Quote variables: `"$variable"`
- Use functions for reusable code

**Example:**

```bash
#!/bin/bash
# Function to download Instagram profile

download_instagram_profile() {
    local username="$1"
    local output_dir="$2"
    
    # Validate inputs
    if [ -z "$username" ]; then
        echo "Error: Username is required"
        return 1
    fi
    
    # Download profile
    instaloader --dirname-pattern="$output_dir" "$username"
}
```

### Python Scripts

- Follow PEP 8 style guide
- Use 4 spaces for indentation
- Add docstrings to functions
- Use type hints where appropriate
- Keep functions focused and small

**Example:**

```python
def download_instagram_profile(username: str, output_dir: str) -> bool:
    """
    Download Instagram profile content.
    
    Args:
        username: Instagram username to download
        output_dir: Directory to save downloads
        
    Returns:
        True if successful, False otherwise
    """
    try:
        # Download logic here
        return True
    except Exception as e:
        print(f"Error: {e}")
        return False
```

### Documentation

- Use Markdown for all docs
- Keep lines under 100 characters
- Use headers hierarchically
- Include code examples
- Add links to related docs

## 🧪 Testing

### Manual Testing

Before submitting a PR, test:

1. **Basic functionality** - Does it work?
2. **Edge cases** - What about unusual inputs?
3. **Error handling** - How does it handle errors?
4. **Different platforms** - Test on Android and Linux if possible

### Test Checklist

- [ ] Tested on Termux (Android)
- [ ] Tested on Linux
- [ ] Tested with public profiles
- [ ] Tested with private profiles
- [ ] Tested with invalid inputs
- [ ] Tested error scenarios
- [ ] Tested with different platforms (Instagram, Facebook, etc.)

## 📚 Documentation Guidelines

### README Updates

- Keep the main README concise
- Move detailed docs to `docs/` folder
- Update table of contents
- Add examples for new features

### Adding New Documentation

1. Create file in `docs/` folder
2. Use clear, descriptive filename
3. Add link in main README
4. Follow existing doc structure

## 🎨 Design Principles

When contributing, keep these principles in mind:

1. **Simplicity** - Keep it simple and intuitive
2. **Reliability** - Code should be robust and handle errors
3. **Performance** - Optimize for speed and efficiency
4. **Compatibility** - Work on Android and Linux
5. **User-Friendly** - Clear prompts and helpful error messages
6. **Maintainability** - Write clean, documented code

## 🏷️ Issue Labels

We use labels to organize issues:

- `bug` - Something isn't working
- `enhancement` - New feature or request
- `documentation` - Documentation improvements
- `good first issue` - Good for newcomers
- `help wanted` - Extra attention needed
- `question` - Further information requested
- `wontfix` - This will not be worked on
- `duplicate` - Duplicate issue

## 🌟 Recognition

Contributors will be recognized in:

- README.md acknowledgments section
- CHANGELOG.md for their contributions
- GitHub contributors page

## 📞 Getting Help

Need help contributing?

- 💬 [GitHub Discussions](https://github.com/YOUR_USERNAME/social-media-downloader/discussions)
- 📧 Contact maintainers
- 📖 Read existing documentation

## 🙏 Thank You!

Every contribution, no matter how small, is valuable. Thank you for helping make Social Media Downloader better!

---

**Happy Contributing! 🎉**
