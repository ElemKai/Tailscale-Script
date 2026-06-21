# Развертывание Tailscale на роутерах OpenWrt

## Требования
- OpenWrt 21.02 или новее
- Минимум 25 МБ свободного места на /overlay
- Подключение к интернету
- Аккаунт Tailscale (бесплатный)

## Быстрая установка

```bash
# Скачайте скрипт
wget -O /tmp/install_tailscale.sh https://your-server.com/install_tailscale.sh

# Или создайте вручную (см. install_tailscale.sh выше)

# Запустите
chmod +x /tmp/install_tailscale.sh
/tmp/install_tailscale.sh

# Авторизуйте
tailscale up
