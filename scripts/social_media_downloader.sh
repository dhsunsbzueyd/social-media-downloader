#!/bin/bash
# Social Media Downloader for Android/Termux
# No GUI required - Pure command line

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default download directory
DOWNLOAD_DIR=~/Downloads/social_media

# Function to print colored messages
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Function to display banner
show_banner() {
    clear
    echo "================================================"
    echo "   Social Media Downloader for Android/Termux"
    echo "================================================"
    echo ""
}

# Function to download from Instagram
download_instagram() {
    show_banner
    echo "📸 Instagram Downloader"
    echo "================================================"
    echo ""
    
    read -p "Enter Instagram username: " username
    
    if [ -z "$username" ]; then
        print_error "Username cannot be empty!"
        return
    fi
    
    echo ""
    echo "What do you want to download?"
    echo "1) All posts"
    echo "2) All posts + stories"
    echo "3) All posts + stories + highlights"
    echo "4) Profile picture only"
    echo "5) With comments and geotags"
    read -p "Choose option (1-5): " option
    
    # Ask for login
    echo ""
    read -p "Do you need to login? (for private profiles) [y/N]: " need_login
    
    LOGIN_CMD=""
    if [[ "$need_login" =~ ^[Yy]$ ]]; then
        read -p "Your Instagram username: " my_username
        LOGIN_CMD="--login=$my_username"
    fi
    
    # Create output directory
    OUTPUT_DIR="$DOWNLOAD_DIR/instagram/$username"
    mkdir -p "$OUTPUT_DIR"
    cd "$OUTPUT_DIR"
    
    print_info "Starting download to: $OUTPUT_DIR"
    echo ""
    
    # Execute download based on option
    case $option in
        1)
            instaloader $LOGIN_CMD "$username"
            ;;
        2)
            instaloader $LOGIN_CMD --stories "$username"
            ;;
        3)
            instaloader $LOGIN_CMD --stories --highlights "$username"
            ;;
        4)
            instaloader $LOGIN_CMD --no-posts --no-videos "$username"
            ;;
        5)
            instaloader $LOGIN_CMD --comments --geotags "$username"
            ;;
        *)
            print_error "Invalid option!"
            return
            ;;
    esac
    
    if [ $? -eq 0 ]; then
        print_success "Download completed!"
        print_info "Files saved to: $OUTPUT_DIR"
    else
        print_error "Download failed!"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function to download from Facebook
download_facebook() {
    show_banner
    echo "📘 Facebook Downloader"
    echo "================================================"
    echo ""
    
    read -p "Enter Facebook profile URL or username: " profile
    
    if [ -z "$profile" ]; then
        print_error "Profile cannot be empty!"
        return
    fi
    
    # Add https:// if not present
    if [[ ! "$profile" =~ ^https?:// ]]; then
        profile="https://facebook.com/$profile"
    fi
    
    echo ""
    echo "What do you want to download?"
    echo "1) All photos"
    echo "2) Profile picture"
    echo "3) Photo albums"
    echo "4) Everything (photos + albums)"
    read -p "Choose option (1-4): " option
    
    # Ask for login
    echo ""
    print_warning "Note: Facebook usually requires login"
    read -p "Do you want to login? [Y/n]: " need_login
    
    LOGIN_CMD=""
    if [[ ! "$need_login" =~ ^[Nn]$ ]]; then
        read -p "Your Facebook email: " fb_email
        read -sp "Your Facebook password: " fb_password
        echo ""
        LOGIN_CMD="-u \"$fb_email\" -p \"$fb_password\""
    fi
    
    # Create output directory
    username=$(basename "$profile")
    OUTPUT_DIR="$DOWNLOAD_DIR/facebook/$username"
    mkdir -p "$OUTPUT_DIR"
    
    print_info "Starting download to: $OUTPUT_DIR"
    echo ""
    
    # Execute download based on option
    case $option in
        1)
            eval gallery-dl $LOGIN_CMD -D "$OUTPUT_DIR" "${profile}/photos"
            ;;
        2)
            eval gallery-dl $LOGIN_CMD -D "$OUTPUT_DIR" "${profile}/avatar"
            ;;
        3)
            eval gallery-dl $LOGIN_CMD -D "$OUTPUT_DIR" "${profile}/photos_albums"
            ;;
        4)
            eval gallery-dl $LOGIN_CMD -D "$OUTPUT_DIR" "$profile"
            ;;
        *)
            print_error "Invalid option!"
            return
            ;;
    esac
    
    if [ $? -eq 0 ]; then
        print_success "Download completed!"
        print_info "Files saved to: $OUTPUT_DIR"
    else
        print_error "Download failed! Facebook blocking is common."
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function to download from any URL
download_from_url() {
    show_banner
    echo "🌐 Universal Downloader (gallery-dl)"
    echo "================================================"
    echo ""
    print_info "Supports: Instagram, Twitter, TikTok, Reddit, Tumblr, and 700+ sites"
    echo ""
    
    read -p "Enter URL: " url
    
    if [ -z "$url" ]; then
        print_error "URL cannot be empty!"
        return
    fi
    
    # Ask for login
    echo ""
    read -p "Do you need to login? [y/N]: " need_login
    
    LOGIN_CMD=""
    if [[ "$need_login" =~ ^[Yy]$ ]]; then
        read -p "Username/Email: " username
        read -sp "Password: " password
        echo ""
        LOGIN_CMD="-u \"$username\" -p \"$password\""
    fi
    
    # Create output directory
    OUTPUT_DIR="$DOWNLOAD_DIR/downloads"
    mkdir -p "$OUTPUT_DIR"
    
    print_info "Starting download to: $OUTPUT_DIR"
    echo ""
    
    eval gallery-dl $LOGIN_CMD -D "$OUTPUT_DIR" "$url"
    
    if [ $? -eq 0 ]; then
        print_success "Download completed!"
        print_info "Files saved to: $OUTPUT_DIR"
    else
        print_error "Download failed!"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function to download from TikTok
download_tiktok() {
    show_banner
    echo "🎵 TikTok Downloader"
    echo "================================================"
    echo ""
    
    read -p "Enter TikTok username or URL: " input
    
    if [ -z "$input" ]; then
        print_error "Input cannot be empty!"
        return
    fi
    
    # Check if it's a URL or username
    if [[ "$input" =~ ^https?:// ]]; then
        url="$input"
    else
        url="https://www.tiktok.com/@$input"
    fi
    
    # Create output directory
    username=$(basename "$url" | sed 's/@//')
    OUTPUT_DIR="$DOWNLOAD_DIR/tiktok/$username"
    mkdir -p "$OUTPUT_DIR"
    
    print_info "Starting download to: $OUTPUT_DIR"
    echo ""
    
    gallery-dl -D "$OUTPUT_DIR" "$url"
    
    if [ $? -eq 0 ]; then
        print_success "Download completed!"
        print_info "Files saved to: $OUTPUT_DIR"
    else
        print_error "Download failed!"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function to download from Twitter/X
download_twitter() {
    show_banner
    echo "🐦 Twitter/X Downloader"
    echo "================================================"
    echo ""
    
    read -p "Enter Twitter/X URL: " url
    
    if [ -z "$url" ]; then
        print_error "URL cannot be empty!"
        return
    fi
    
    # Ask for login
    echo ""
    print_warning "Note: Twitter may require login"
    read -p "Do you want to login? [y/N]: " need_login
    
    LOGIN_CMD=""
    if [[ "$need_login" =~ ^[Yy]$ ]]; then
        read -p "Your Twitter username: " username
        read -sp "Your Twitter password: " password
        echo ""
        LOGIN_CMD="-u \"$username\" -p \"$password\""
    fi
    
    # Create output directory
    OUTPUT_DIR="$DOWNLOAD_DIR/twitter"
    mkdir -p "$OUTPUT_DIR"
    
    print_info "Starting download to: $OUTPUT_DIR"
    echo ""
    
    eval gallery-dl $LOGIN_CMD -D "$OUTPUT_DIR" "$url"
    
    if [ $? -eq 0 ]; then
        print_success "Download completed!"
        print_info "Files saved to: $OUTPUT_DIR"
    else
        print_error "Download failed!"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function to view downloaded files
view_downloads() {
    show_banner
    echo "📁 Downloaded Files"
    echo "================================================"
    echo ""
    
    if [ ! -d "$DOWNLOAD_DIR" ]; then
        print_error "No downloads found!"
        echo ""
        read -p "Press Enter to continue..."
        return
    fi
    
    print_info "Download directory: $DOWNLOAD_DIR"
    echo ""
    
    # Count files
    total_files=$(find "$DOWNLOAD_DIR" -type f | wc -l)
    total_size=$(du -sh "$DOWNLOAD_DIR" 2>/dev/null | cut -f1)
    
    echo "Total files: $total_files"
    echo "Total size: $total_size"
    echo ""
    echo "Directory structure:"
    echo "-------------------"
    tree -L 2 "$DOWNLOAD_DIR" 2>/dev/null || ls -lh "$DOWNLOAD_DIR"
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function to show settings
show_settings() {
    show_banner
    echo "⚙️  Settings"
    echo "================================================"
    echo ""
    echo "Current download directory: $DOWNLOAD_DIR"
    echo ""
    read -p "Enter new download directory (or press Enter to keep current): " new_dir
    
    if [ ! -z "$new_dir" ]; then
        DOWNLOAD_DIR="$new_dir"
        mkdir -p "$DOWNLOAD_DIR"
        print_success "Download directory updated to: $DOWNLOAD_DIR"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Main menu
main_menu() {
    while true; do
        show_banner
        echo "Choose a platform:"
        echo ""
        echo "1) 📸 Instagram"
        echo "2) 📘 Facebook"
        echo "3) 🎵 TikTok"
        echo "4) 🐦 Twitter/X"
        echo "5) 🌐 Any URL (Universal)"
        echo ""
        echo "6) 📁 View Downloads"
        echo "7) ⚙️  Settings"
        echo "8) ❌ Exit"
        echo ""
        read -p "Enter your choice (1-8): " choice
        
        case $choice in
            1) download_instagram ;;
            2) download_facebook ;;
            3) download_tiktok ;;
            4) download_twitter ;;
            5) download_from_url ;;
            6) view_downloads ;;
            7) show_settings ;;
            8) 
                clear
                print_success "Thank you for using Social Media Downloader!"
                exit 0
                ;;
            *)
                print_error "Invalid choice! Please try again."
                sleep 2
                ;;
        esac
    done
}

# Check if required tools are installed
check_requirements() {
    if ! command -v gallery-dl &> /dev/null; then
        print_error "gallery-dl is not installed!"
        echo "Please run: pip install gallery-dl"
        exit 1
    fi
    
    if ! command -v instaloader &> /dev/null; then
        print_error "instaloader is not installed!"
        echo "Please run: pip install instaloader"
        exit 1
    fi
}

# Main execution
check_requirements
main_menu
