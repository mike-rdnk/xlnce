#!/bin/bash
# Скрипт для обновления инструкций xlnce из GitHub

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# Переходим в корень git репозитория (на 1 уровень выше от xlnce)
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$REPO_ROOT"

echo "🔄 Обновление инструкций xlnce из GitHub..."
echo "📁 Репозиторий: $REPO_ROOT"
echo ""

# Проверка, что мы в git репозитории
if [ ! -d ".git" ]; then
    echo "❌ Ошибка: это не git репозиторий"
    exit 1
fi

# Получение текущей версии
CURRENT_COMMIT=$(git rev-parse --short HEAD)
echo "📌 Текущая версия: $CURRENT_COMMIT"

# Обновление из GitHub
echo ""
echo "⬇️  Загрузка обновлений..."
git fetch origin

# Проверка наличия обновлений
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})

if [ "$LOCAL" = "$REMOTE" ]; then
    echo "✅ Инструкции уже актуальны"
else
    echo "🔄 Найдены обновления, применяю..."
    git pull origin main
    NEW_COMMIT=$(git rev-parse --short HEAD)
    echo "✅ Обновлено до версии: $NEW_COMMIT"
    echo ""
    echo "📝 Изменения:"
    git log --oneline $CURRENT_COMMIT..$NEW_COMMIT
fi

echo ""
echo "✨ Готово!"

