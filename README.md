# Развертывание Tailscale на роутерах OpenWrt

## Требования
- OpenWrt 21.02 или новее
- Минимум 25 МБ свободного места на /overlay
- Подключение к интернету
- Аккаунт Tailscale (бесплатный)

## Быстрая установка

```bash
# Скачайте скрипт
wget -O /tmp/install_tailscale.sh https://raw.githubusercontent.com/ElemKai/Tailscale-Script/refs/heads/main/install_tailscale.sh && chmod +x /tmp/install_tailscale.sh && /tmp/install_tailscale.sh

# Или создайте вручную (см. install_tailscale.sh выше)

# Запустите
chmod +x /tmp/install_tailscale.sh
/tmp/install_tailscale.sh

# Авторизуйте
tailscale up
