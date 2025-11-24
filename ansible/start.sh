#!/bin/bash

# --- Configuration ---
ANSIBLE_USER="ansible"
PUB_KEY=""

# --------------------

echo "Starting configuration of user $ANSIBLE_USER on the host..."

# 1. Create the ansible user if they do not exist
if ! id "$ANSIBLE_USER" &>/dev/null; then
    echo "Creating user $ANSIBLE_USER..."
    useradd -m -s /bin/bash "$ANSIBLE_USER"
    # If you want to limit login, use: useradd -m -s /sbin/nologin "$ANSIBLE_USER"
else
    echo "User $ANSIBLE_USER already exists."
fi

# 2. Add the user to the wheel group (for sudo privileges)
echo "Adding $ANSIBLE_USER to the wheel group..."

if getent group sudo &>/dev/null; then
    SUDO_GROUP="sudo"
elif getent group wheel &>/dev/null; then
    SUDO_GROUP="wheel"
else
    echo "Warning: No found sudo. Using wheel."
    SUDO_GROUP="wheel"
fi

usermod -aG "$SUDO_GROUP" "$ANSIBLE_USER"


# 3. Configure NOPASSWD for the $ANSIBLE_USER user
echo "Configuring NOPASSWD for user $ANSIBLE_USER..."
SUDO_FILE="/etc/sudoers.d/ansible_user_nopasswd"
SUDO_RULE="$ANSIBLE_USER ALL=(ALL) NOPASSWD: ALL"

echo "$SUDO_RULE" > "$SUDO_FILE"
chmod 0440 "$SUDO_FILE"
visudo -cf "$SUDO_FILE"

# 4. Deploy the public SSH key
echo "Deploying the public SSH key..."
HOME_DIR=$(eval echo "~$ANSIBLE_USER")
AUTH_KEYS_FILE="$HOME_DIR/.ssh/authorized_keys"

mkdir -p "$HOME_DIR/.ssh"
# Add the key only if it's not already in the file
if ! grep -qF "$PUB_KEY" "$AUTH_KEYS_FILE"; then
    echo "$PUB_KEY" >> "$AUTH_KEYS_FILE"
fi

# 5. Set correct permissions
echo "Setting permissions..."
chmod 700 "$HOME_DIR/.ssh"
chmod 600 "$AUTH_KEYS_FILE"
chown -R "$ANSIBLE_USER:$ANSIBLE_USER" "$HOME_DIR"

# 6. Configure sshd_config
echo "Configure sshd_config $ANSIBLE_USER..."
CONFIG_FILE="/etc/ssh/sshd_config"

# Use Match User
if ! grep -q "^Match User $ANSIBLE_USER" "$CONFIG_FILE"; then
    echo -e "\nMatch User $ANSIBLE_USER" >> "$CONFIG_FILE"
    echo "    PasswordAuthentication no" >> "$CONFIG_FILE"
    echo "    PubkeyAuthentication yes" >> "$CONFIG_FILE"
else
    echo "Block Match User already has, skip."
fi

# 7. Restart the SSH servise
echo "Restart  SSH..."

if command -v systemctl &>/dev/null && systemctl list-units --type=service | grep -q sshd; then
    systemctl restart sshd
    echo "  -> " The SSH service has been restarted."
else
    echo "Warning: Failed to restart the SSH service (you may be using a different init system)."
fi


echo "Configuration complete. User $ANSIBLE_USER is ready for Ansible."