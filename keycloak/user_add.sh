#!/bin/bash

# Конфигурационные переменные
CONFIG_FILE="/opt/jboss/keycloak/config/keycloak.conf"
REALM="your-realm-name"
USERS_JSON="/opt/jboss/tools/users.json"

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

    # Передаем данные функции добавления пользователя
    add_user "$username" "$firstName" "$lastName"
done