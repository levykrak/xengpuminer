#!/bin/bash

# Zdefiniuj zmienne z ścieżkami dostępu
CONFIG_DIR="/root/.config/solana"
SOLANA_BIN="/usr/bin/solana"  # Zmień na odpowiednią ścieżkę do pliku wykonywalnego solana

# Wykonaj polecenia z użyciem zmiennych
$SOLANA_BIN withdraw-from-vote-account $CONFIG_DIR/vote.json $CONFIG_DIR/id.json ALL --fee-payer $CONFIG_DIR/identity.json -k $CONFIG_DIR/id.json
$SOLANA_BIN deactivate-stake $CONFIG_DIR/stake2.json -k $CONFIG_DIR/id.json
sleep 200

$SOLANA_BIN withdraw-stake $CONFIG_DIR/stake2.json $CONFIG_DIR/id.json ALL -k $CONFIG_DIR/id.json

#obliczamy stake jaki mozemy wrzucic do stake -0.1
amount=$(solana balance $CONFIG_DIR/id.json | awk '{print $1}')
amount=$(echo "$amount - 0.1" | bc)

$SOLANA_BIN create-stake-account $CONFIG_DIR/stake2.json $amount -k $CONFIG_DIR/id.json
$SOLANA_BIN delegate-stake $CONFIG_DIR/stake2.json $CONFIG_DIR/vote.json -k $CONFIG_DIR/id.json --fee-payer $CONFIG_DIR/identity.json
