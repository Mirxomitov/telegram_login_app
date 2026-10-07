#!/bin/sh
# Sets the Telegram bot client ID everywhere it is needed.
# Usage: tool/set_client_id.sh 1234567890
set -e
case "$1" in
  ''|*[!0-9]*) echo "usage: $0 <numeric bot client id>" >&2; exit 1 ;;
esac
cd "$(dirname "$0")/.."
sed -i '' "s/static const clientId = '[0-9]*'/static const clientId = '$1'/" lib/auth/telegram_config.dart
sed -i '' "s/^telegramClientId=.*/telegramClientId=$1/" android/gradle.properties
sed -i '' "s/^TELEGRAM_CLIENT_ID=.*/TELEGRAM_CLIENT_ID=$1/" ios/Flutter/Telegram.xcconfig
echo "Client ID set to $1 (redirect: https://app$1-login.tg.dev)"
