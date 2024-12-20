#!/bin/bash

# Plik zawierający adresy Solany
addresses_file="addresses.txt"

# Sprawdzenie, czy plik istnieje
if [ ! -f "$addresses_file" ]; then
    echo "Plik $addresses_file nie istnieje. Upewnij się, że plik jest dostępny."
    exit 1
fi

# Liczba wszystkich adresów w pliku
total_addresses=$(wc -l < "$addresses_file")
current_index=0

# Iteracja przez każdy adres z pliku
while IFS= read -r address; do
    if [ -n "$address" ]; then
        current_index=$((current_index + 1))
        progress=$(awk "BEGIN {printf \"%.2f\", ($current_index / $total_addresses) * 100}")
        
        echo "[$current_index/$total_addresses] (${progress}%) Przetwarzanie adresu: $address"

        # Wykonanie żądania cURL
        response=$(curl --proxy socks5h://localhost:9050 -X POST https://xolana.xen.network/faucet \
            -H "Content-Type: application/json" \
            -d "{\"pubkey\":\"$address\"}" \
            -s)
        
        echo "Odpowiedź: $response"

        # Restart usługi Tor
        echo "Restartowanie usługi Tor..."
        sudo systemctl reload tor

        # Opcjonalnie dodaj opóźnienie (np. 2 sekundy)
        #sleep 1
    else
        echo "Pusty adres pominięty."
    fi
done < "$addresses_file"

echo "Proces zakończony. Przetworzono $total_addresses adresów."
