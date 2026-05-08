# Misc aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias cls="clear"

# Git aliases
alias gc="git commit"
alias gck="git commit --no-verify"
alias ga="git add"
alias gs="git status"
alias gr="git restore --staged ."
alias gmd="git fetch origin develop && git merge origin/develop"
alias revertLast="git reset --soft HEAD~1"

# Android development aliases
alias adbtcp="adb tcpip 5555"
alias adbconnect="adb connect 10.0.0.171:5555"
alias adbkill="adb kill-server && adb devices"
alias startemulator="emulator -avd Pixel_9_Pro_XL.avd &"
alias mirror="scrcpy --video-bit-rate 2M --max-size 800"
alias boom="rm -rf ~/.gradle/caches/build-cache-1 && ./gradlew clean --quiet"
alias killjava="pkill -9 java"
alias scan="./gradlew :app:dependencies --scan > ~/Desktop/dependencies.txt"


# Functions
compressvideo() {
    # 1. Check if ffmpeg is actually installed
    if ! command -v ffmpeg &> /dev/null; then
        echo "Error: ffmpeg is not installed."
        return 1
    fi

    # 2. Validate that an input file was provided and exists
    if [[ ! -f "$1" ]]; then
        echo "Error: Input file '$1' not found."
        echo "Usage: compressvideo <input_file> [output_file]"
        return 1
    fi

    local input_file="$1"
    
    # 3. Determine output filename
    # If $2 is provided, use it. Otherwise, append "_compressed" to the input name.
    # ${input_file%.*} removes the extension (e.g., video.mov -> video)
    local output_file="${2:-"${input_file%.*}_compressed.mp4"}"

    # 4. Run compression
    # -c:v libx264 : The standard video codec (modern alias for -vcodec)
    # -crf 28      : Constant Rate Factor (Higher = more compression/lower quality)
    # -preset fast : Balances speed vs compression efficiency
    # -c:a copy    : Copies audio stream directly (faster, no audio quality loss)
    ffmpeg -i "$input_file" -c:v libx264 -crf 28 -preset fast -c:a copy "$output_file"
}


# Export environment variables
export ANDROID_SDK_ROOT="~/Android/Sdk"
export ANDROID_HOME="~/Android/Sdk"
export ANDROID_AVD_HOME="~/.android/avd" 

export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin
