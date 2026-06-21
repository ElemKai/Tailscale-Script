<div align="center">

# 🦎 Tailscale для OpenWrt

### Быстрое развёртывание безопасного удалённого доступа к роутерам

[![OpenWrt](https://img.shields.io/badge/OpenWrt-21.02+-blue?logo=openwrt&logoColor=white)](https://openwrt.org/)
[![Tailscale](https://img.shields.io/badge/Tailscale-1.80+-black?logo=tailscale&logoColor=white)](https://tailscale.com/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-ARM%20%7C%20ARM64%20%7C%20x86_64%20%7C%20MIPS-lightgrey)]()

[🚀 Быстрый старт](#-быстрый-старт) • [📖 Документация](#-документация) • [❓ FAQ](#-faq) • [🐛 Сообщить о проблеме](https://github.com/ElemKai/Tailscale-Script/issues)

</div>

---

## 🎯 Что это?

Однострочный скрипт для установки **Tailscale** на любой роутер под управлением **OpenWrt**. Позволяет получить безопасный удалённый доступ к роутеру **без белого IP, без VPS и без домена**.

> 💡 **Почему Tailscale, а не Cloudflare Tunnel?**
>
> С июня 2025 года российские провайдеры режут трафик к Cloudflare (ограничение 16 КБ), делая Cloudflare Tunnel нерабочим в России. Tailscale использует P2P-соединения через WireGuard и работает стабильно.

---

## ✨ Возможности

| Функция | Описание |
|---------|----------|
| 🚀 **Одна команда** | Установка в один шаг на любом роутере |
| 🌐 **Без белого IP** | Доступ к роутеру из любой точки мира |
| 🔒 **Безопасность** | Весь трафик шифруется через WireGuard |
| 💰 **Бесплатно** | До 100 устройств в одной сети |
| 📱 **Мультиплатформа** | Работает на ПК, смартфонах, планшетах |
| 🏠 **P2P-соединение** | Прямая связь между устройствами без серверов |
| 🔄 **Автозапуск** | Tailscale запускается при загрузке роутера |
| 🎯 **Умная установка** | Автоматическое определение архитектуры |

---

## 🚀 Быстрый старт

Подключитесь к роутеру по SSH и выполните **одну команду**:

```bash
wget -O /tmp/install_tailscale.sh https://raw.githubusercontent.com/ElemKai/Tailscale-Script/refs/heads/main/install_tailscale.sh && \
chmod +x /tmp/install_tailscale.sh && \
/tmp/install_tailscale.sh

# Авторизуйте
tailscale up