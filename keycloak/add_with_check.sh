#!/bin/bash

# Конфигурационные переменные
CONFIG_FILE="/opt/jboss/keycloak/config/keycloak.conf"
REALM="your-realm-name"
USERS_JSON="/opt/jboss/tools/users.json"

# Проверка наличия пользователя
check_user_exists() {
    local username=$1
    result=$(kcadm get users -r $REALM -q username=$username)
    if [[ ! -z "$result" ]]; then
        echo "Пользователь '$username' уже существует."
        return 1
    else
        return 0
    fi
}

# Функция для добавления пользователя
add_user() {
    local username=$1
    local firstName=$2
    local lastName=$3
    # Остальные поля передаются аналогичным образом

    # Форматируем тело запроса в формате JSON
    USER_DATA='{"username": "'$username'", "firstName": "'$firstName'", "lastName": "'$lastName'", ...}'

    # Используем kcadm для создания пользователя
    kcadm create users -r $REALM -s enabled=true -s emailVerified=true -b "$USER_DATA"
}

# Читаем JSON-файл и обрабатываем каждого пользователя
jq -c '.users[]' $USERS_JSON | while read i; do
    # Извлекаем нужные поля
    username=$(echo $i | jq -r .username)
    firstName=$(echo $i | jq -r .firstName)
    lastName=$(echo $i | jq -r .lastName)
    # Аналогичным образом извлекайте остальные атрибуты...

    # Сначала проверяем, существует ли пользователь
    check_user_exists "$username"
    if [[ $? -eq 0 ]]; then
        # Пользователь не найден, добавляем
        add_user "$username" "$firstName" "$lastName"
    else
        echo "Пользователь '$username' пропускается, поскольку уже существует."
    fi
done