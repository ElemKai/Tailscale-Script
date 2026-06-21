#!/bin/sh

echo "=== Установка Tailscale на OpenWrt ==="

# Определяем архитектуру
ARCH=$(uname -m)
case $ARCH in
    armv7l|armv8l) ARCH="arm" ;;
    aarch64) ARCH="arm64" ;;
    x86_64) ARCH="amd64" ;;
    mips) ARCH="mips" ;;
    *) 
        echo "❌ Неподдерживаемая архитектура: $ARCH"
        exit 1
        ;;
esac
echo "✓ Архитектура: $ARCH"

# Проверяем свободное место
FREE_SPACE=$(df -h /overlay | tail -1 | awk '{print $4}' | sed 's/M//')
if [ "$FREE_SPACE" -lt 25 ]; then
    echo "⚠️  Недостаточно места на /overlay (${FREE_SPACE}MB, нужно 25MB)"
    echo "Удалите ненужные пакеты: opkg remove <package_name>"
    exit 1
fi
echo "✓ Свободно: ${FREE_SPACE}MB"

# Устанавливаем Tailscale
echo "→ Установка Tailscale..."
opkg update
opkg install tailscale

if [ $? -ne 0 ]; then
    echo "❌ Ошибка установки Tailscale"
    exit 1
fi
echo "✓ Tailscale установлен"

# Создаем TUN устройство
echo "→ Создание TUN устройства..."
mkdir -p /dev/net
[ -e /dev/net/tun ] || mknod /dev/net/tun c 10 200
chmod 600 /dev/net/tun

# Создаем hotplug скрипт для автосоздания TUN
cat > /etc/hotplug.d/iface/99-tun << 'EOF'
#!/bin/sh
[ "$ACTION" = "ifup" ] || exit 0
mkdir -p /dev/net
[ -e /dev/net/tun ] || mknod /dev/net/tun c 10 200
chmod 600 /dev/net/tun
EOF
chmod +x /etc/hotplug.d/iface/99-tun
echo "✓ TUN устройство создано"

# Создаем директории
mkdir -p /var/lib/tailscale
mkdir -p /var/run/tailscale

# Создаем init-скрипт
echo "→ Создание init-скрипта..."
cat > /etc/init.d/tailscaled << 'EOF'
#!/bin/sh /etc/rc.common

START=90
STOP=10
USE_PROCD=1

start_service() {
    procd_open_instance
    procd_set_param command /usr/sbin/tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock
    procd_set_param respawn 3600 5 3
    procd_set_param stderr 1
    procd_close_instance
}
EOF
chmod +x /etc/init.d/tailscaled
echo "✓ Init-скрипт создан"

# Включаем автозапуск
/etc/init.d/tailscaled enable

# Запускаем tailscaled
/etc/init.d/tailscaled start

# Проверяем запуск
sleep 2
if ps w | grep -q "[t]ailscaled"; then
    echo "✓ Tailscaled запущен"
else
    echo "❌ Ошибка запуска tailscaled"
    exit 1
fi

echo ""
echo "=== Установка завершена ==="
echo ""
echo "Для авторизации выполните:"
echo "  tailscale up"
echo ""
echo "После авторизации проверьте статус:"
echo "  tailscale status"
echo ""
echo "IP-адрес роутера в сети Tailscale можно использовать для:"
echo "  - Веб-интерфейс: http://<tailscale-ip>"
echo "  - SSH: ssh root@<tailscale-ip>"