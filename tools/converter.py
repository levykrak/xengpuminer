import json
import base58
import sys

# Sprawdź, czy podano nazwę pliku
if len(sys.argv) < 2:
    print("❌ Użycie: python script.py <nazwa_pliku.json>")
    sys.exit(1)

# Pobierz nazwę pliku z argumentów
filename = sys.argv[1]

try:
    # Otwórz plik JSON
    with open(filename, "r") as f:
        key_array = json.load(f)

    # Konwersja do Base58
    key_base58 = base58.b58encode(bytes(key_array)).decode()

    print("✅ Private Key in Base58:", key_base58)

except FileNotFoundError:
    print(f"❌ Plik '{filename}' nie istnieje.")
except json.JSONDecodeError:
    print(f"❌ Błąd odczytu pliku '{filename}'. Upewnij się, że to poprawny JSON.")
