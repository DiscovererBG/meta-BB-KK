#!/bin/bash

# 默认DNS地址
DEFAULT_DNS="154.83.83.83"

# 提示选择DNS地址
echo "请选择要设置的DNS地址，或选择退出:"
echo "1. 默认 DNS ($DEFAULT_DNS)"
echo "2. 香港 DNS (154.83.83.84)"
echo "3. 日本 DNS (154.83.83.85)"
echo "4. 台湾 DNS (154.83.83.86)"
echo "5. 新加坡 DNS (154.83.83.87)"
echo "6. 美国 DNS (154.83.83.88)"
echo "7. 英国 DNS (154.83.83.89)"
echo "8. 德国 DNS (154.83.83.90)"
echo "9. 退出"

# 读取用户选择
read -p "请输入选择的号码 (1-9): " choice

# 如果选择退出，直接退出
if [ "$choice" -eq 9 ]; then
  echo "退出程序。"
  exit 0
fi

# 确保用户输入有效，继续循环直到输入正确
while [[ ! "$choice" =~ ^[1-8]$ ]]; do
  echo "无效的选择，请输入 1 到 8 之间的数字，或选择退出（9）。"
  read -p "请输入选择的号码 (1-9): " choice
  if [ "$choice" -eq 9 ]; then
    echo "退出程序。"
    exit 0
  fi
done

# 根据选择设置DNS
case $choice in
  1) DNS="154.83.83.83" && DNS_NAME="默认 DNS" ;;
  2) DNS="154.83.83.84" && DNS_NAME="香港 DNS" ;;
  3) DNS="154.83.83.85" && DNS_NAME="日本 DNS" ;;
  4) DNS="154.83.83.86" && DNS_NAME="台湾 DNS" ;;
  5) DNS="154.83.83.87" && DNS_NAME="新加坡 DNS" ;;
  6) DNS="154.83.83.88" && DNS_NAME="美国 DNS" ;;
  7) DNS="154.83.83.89" && DNS_NAME="英国 DNS" ;;
  8) DNS="154.83.83.90" && DNS_NAME="德国 DNS" ;;
esac

# 更新 DNS 配置
echo "正在更新DNS为 $DNS ..."
echo "nameserver $DNS" > /etc/resolv.conf

# 显示更新后的DNS并附上中文描述
echo "DNS已更新为: $DNS ($DNS_NAME)"
