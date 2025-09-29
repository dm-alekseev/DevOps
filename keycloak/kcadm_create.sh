#!/bin/bash

for user in $(jq -c '.[]' /opt/jboss/tools/users.json); do
    echo "Adding user: $user"
    kcadm create users -r your_realm -s enabled=true -s emailVerified=true -b "$user"
done