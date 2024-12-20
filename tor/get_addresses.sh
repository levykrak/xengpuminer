#!/bin/bash

for i in {1..100}
do
    # Ścieżka do pliku klucza
    file="account_${i}.json"
    
    # Wyodrębnienie adresu i zapisanie go do pliku lub wyświetlenie
    if [ -f "$file" ]; then
        address=$(solana-keygen pubkey "$file")
        echo "Account $i: $address"
        echo "$address" >> addresses.txt
    else
        echo "File $file not found!"
    fi
done
