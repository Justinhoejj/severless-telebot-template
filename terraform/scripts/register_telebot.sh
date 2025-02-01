#!/bin/bash
echo "Generating script to register the web token..."
if [[ -z "$TOKEN" || -z "$API_URL" ]]; then
  echo "Error: Missing token or API URL"
  exit 1
fi
RESPONSE=$(curl -sS -w "%{http_code}" -o /dev/null "https://api.telegram.org/bot{$TOKEN}/setWebhook?url={$API_URL}")

if [[ "$RESPONSE" -eq 200 ]]; then
  echo "Webhook set successfully with status code: $RESPONSE"
else
  echo "Failed to set webhook. Status code: $RESPONSE"
  exit 1
fi