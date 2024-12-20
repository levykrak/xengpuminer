#!/bin/bash

for i in {1..100}
do
    solana-keygen new --no-passphrase -o "account_${i}.json"
done
