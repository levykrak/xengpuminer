#!/bin/bash

# Plik zawierający adresy źródłowe
addresses_file="addresses.txt"

# Plik docelowego portfela
destination_file="account_1.json"

# Sprawdzenie, czy pliki istnieją
if [ ! -f "$addresses_file" ]; then
    echo "Plik $addresses_file nie istnieje. Upewnij się, że plik jest dostępny."
    exit 1
fi

if [ ! -f "$destination_file" ]; then
    echo "Plik docelowego portfela $destination_file nie istnieje. Upewnij się, że plik jest dostępny."
    exit 1
fi

# Pobranie adresu docelowego
destination_address=$(solana-keygen pubkey "$destination_file")
if [ -z "$destination_address" ]; then
    echo "Nie udało się odczytać adresu docelowego z $destination_file."
    exit 1
fi

# Liczba wszystkich adresów w pliku
total_addresses=$(wc -l < "$addresses_file")
current_index=0

# Iteracja przez każdy adres z pliku
while IFS= read -r source_address; do
    if [ -n "$source_address" ]; then
        current_index=$((current_index + 1))
        progress=$(awk "BEGIN {printf \"%.2f\", ($current_index / $total_addresses) * 100}")
        
        echo "[$current_index/$total_addresses] (${progress}%) Transfer środków z adresu: $source_address do $destination_address"

        # Ustawienie aktywnego portfela źródłowego
        #solana config set --keypair "account_${current_index}.json"

        # Sprawdzenie salda
        balance=$(solana balance --keypair "account_${current_index}.json" | awk '{print $1}')
        if (( $(echo "$balance > 0" | bc -l) )); then
            echo "Saldo źródłowe: $balance SOL. Rozpoczynanie transferu..."
            
            # Wykonanie transferu
            solana transfer "$destination_address" "$balance" --allow-unfunded-recipient --keypair "account_${current_index}.json" --fee-payer "account_1.json"
        else
            echo "Adres $source_address nie ma wystarczającego salda. Pominięcie."
        fi

        # Opcjonalne opóźnienie (np. 2 sekundy)
        #sleep 2
    else
        echo "Pusty adres pominięty."
    fi
done < "$addresses_file"

echo "Proces zakończony. Przetworzono $total_addresses adresów."
