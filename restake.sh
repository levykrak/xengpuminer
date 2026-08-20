#!/usr/bin/env bash
set -euo pipefail

STAKE1="stake.json"
STAKE2="stake2.json"
VOTE="vote.json"
LEDGER="usb://ledger?key=0"

echo "=== 1. Merge stake accounts ==="
if ! solana merge-stake "$STAKE1" "$STAKE2" -k "$LEDGER"; then
    read -r -p "Merge nie powiódł się. Pominąć ten krok i kontynuować? [y/N]: " ans
    if [[ "$ans" != "y" && "$ans" != "Y" ]]; then
        echo "Przerywam."
        exit 1
    fi
    echo "Pomijam merge, kontynuuję dalej."
fi
echo
echo "=== 2. Aktualny balans (po merge) ==="
balance

echo
read -n 1 -s -r -p "Naciśnij dowolny klawisz, aby kontynuować (withdraw-from-vote-account)..."
echo
echo

echo "=== 3. Withdraw ALL z vote account ==="
solana withdraw-from-vote-account "$VOTE" "$LEDGER" ALL -k "$LEDGER"

echo
read -r -p "Podaj AMOUNT do utworzenia nowego stake account: " AMOUNT

if [[ -z "$AMOUNT" ]]; then
    echo "Błąd: nie podano kwoty. Przerywam." >&2
    exit 1
fi

echo
echo "=== 5. Tworzenie stake account ($STAKE2, $AMOUNT) ==="
solana create-stake-account "$STAKE2" "$AMOUNT" -k "$LEDGER"

echo
echo "=== 6. Delegacja stake ==="
solana delegate-stake "$STAKE2" "$VOTE" -k "$LEDGER"

echo
echo "=== Gotowe ==="
