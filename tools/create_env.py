import json
import os

# Ścieżka do pliku klucza Solana
key_path = "/root/.config/solana/spam_test.json"

# Wczytaj plik JSON
with open(key_path, 'r') as file:
    key_data = json.load(file)

# Wyciągnij bajty klucza prywatnego i połącz je przecinkami
private_key_bytes = ",".join(map(str, key_data))

# Stwórz zawartość pliku .env
env_content = f"""RPC_URL="http://localhost:8899"
RECIPIENT_ADDRESS="2751kMjez1c5CP1T6H9dmVbxTJAKoeZLiA7xp8XndBKJ"
PRIVATE_KEY_BYTES="{private_key_bytes}"
NUM_TASKS="128" # Optional: Adjust the number of concurrent tasks
"""

# Zapisz do pliku .env
with open('.env', 'w') as env_file:
    env_file.write(env_content)

print("Plik .env został pomyślnie utworzony.")
