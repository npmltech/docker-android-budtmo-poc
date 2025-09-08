#!/usr/bin/env bash
set -e

# ==============================================
# Script para parar todos os emuladores e remover volumes
# ==============================================

echo "🛑 Parando emuladores Android..."
docker compose down --volumes
echo "✅ Todos os emuladores foram parados e volumes removidos!"
echo "📂 Verificando se os volumes foram removidos..."
docker volume ls -qf dangling=true | xargs -r docker volume rm
echo "🔌 Verificando se as redes foram removidas..."
docker network ls -qf dangling=true | xargs -r docker network rm
echo "✅ Tudo foi removido com sucesso!"