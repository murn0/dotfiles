# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# CVE-2023-38545とCVE-2023-38546に対応するcurl8.4.0を優先するための設定
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
