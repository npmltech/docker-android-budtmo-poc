#!/usr/bin/env bash
set -e

# ==============================================
# Script para subir 2 emuladores Android via Docker
# e aguardar até que cada um apareça como "device"
# ==============================================

echo "🚀 Subindo os 2 emuladores Android..."
docker compose up -d

# ==============================================
# Função que aguarda até o emulador estar pronto
# ==============================================
wait_for_emulator() {
    local port=$1
    local name=$2

    while true; do
        # Tenta conectar via ADB
        adb connect 127.0.0.1:$port >/dev/null 2>&1

        # Captura o status do dispositivo na lista ADB
        status=$(adb devices | grep "127.0.0.1:$port" | awk '{print $2}')

        # Sai do loop quando o status for "device"
        if [ "$status" = "device" ]; then
            break
        fi

        sleep 5
    done

    echo "✅ Emulador $name pronto!"
}

# ==============================================
# Reinicia o servidor ADB
# ==============================================
echo "🔄 Reiniciando servidor ADB..."
adb kill-server
adb start-server

# ==============================================
# Aguarda cada emulador ficar pronto
# ==============================================
wait_for_emulator 5555 "Samsung Galaxy S6" || echo "⚠️ S6 pode não estar completamente pronto, pode ser necessário aguardar mais um pouco! Verifique as condições do ADB."
wait_for_emulator 5556 "Nexus 5" || echo "⚠️ Nexus 5 pode não estar completamente pronto, pode ser necessário aguardar mais um pouco! Verifique as condições do ADB."

# ==============================================
# Mostra os dispositivos conectados
# ==============================================
echo "📱 Dispositivos disponíveis:"
adb devices

echo "✅ Todos os emuladores estão prontos para uso!"