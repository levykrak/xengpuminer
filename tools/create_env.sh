#!/bin/bash

# Ścieżki do plików
PRIVATE_KEY_PATH="/root/.config/solana/spam_test.json"
RECIPIENT_KEY_PATH="/root/.config/solana/spam_test_recv.json"

# Pobierz adres publiczny z klucza prywatnego odbiorcy
RECIPIENT_ADDRESS=$(solana-keygen pubkey "$RECIPIENT_KEY_PATH")

# Wczytaj bajty klucza prywatnego i sformatuj je jako listę oddzieloną przecinkami
PRIVATE_KEY_BYTES=$(cat "$PRIVATE_KEY_PATH" | jq -c '.[]' | tr '\n' ',' | sed 's/,$//g')

# Utwórz plik .env
cat > .env << EOF
RPC_URL="http://localhost:8899"
RECIPIENT_ADDRESS="$RECIPIENT_ADDRESS"
PRIVATE_KEY_BYTES="$PRIVATE_KEY_BYTES"
NUM_TASKS="128" # Optional: Adjust the number of concurrent tasks
EOF

echo "Plik .env został pomyślnie utworzony."
echo "Adres publiczny odbiorcy: $RECIPIENT_ADDRESS"
