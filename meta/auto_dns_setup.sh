#!/bin/bash

# 默认DNS地址
DEFAULT_DNS="154.83.83.83"

# 提示选择DNS地址
echo "请选择要设置的DNS地址:"
echo "1. 默认 DNS ($DEFAULT_DNS)"
echo "2. 香港 DNS (154.83.83.84)"
echo "3. 日本 DNS (154.83.83.85)"
echo "4. 台湾 DNS (154.83.83.86)"
echo "5. 新加坡 DNS (154.83.83.87)"
echo "6. 美国 DNS (154.83.83.88)"
echo "7. 英国 DNS (154.83.83.89)"
echo "8. 德国 DNS (154.83.83.90)"

# 在这里等待用户输入
read -p "请输入选择的号码 (1-8): " choice

# 检查输入有效性，直到用户做出有效选择
while [[ ! "$choice" =~ ^[1-8]$ ]]; do
  echo "无效的选择，请输入 1 到 8 之间的数字."
  read -p "请输入选择的号码 (1-8): " choice
done

# 根据选择设置DNS
case $choice in
  1) DNS="154.83.83.83" ;;
  2) DNS="154.83.83.84" ;;
  3) DNS="154.83.83.85" ;;
  4) DNS="154.83.83.86" ;;
  5) DNS="154.83.83.87" ;;
  6) DNS="154.83.83.88" ;;
  7) DNS="154.83.83.89" ;;
  8) DNS="154.83.83.90" ;;
esac

# 更新 DNS 配置
echo "正在更新DNS为 $DNS ..."
echo "nameserver $DNS" > /etc/resolv.conf

# 显示更新后的DNS
echo "DNS已更新为: $DNS"
