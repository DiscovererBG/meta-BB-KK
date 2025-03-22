#!/bin/bash

# 默认DNS地址
DEFAULT_DNS="154.83.83.83"

# 提供选项恢复或更改DNS
echo "请选择操作选项:"
echo "1. 恢复之前的 DNS 配置"
echo "2. 继续更改 DNS 配置"

# 读取用户选择
while true; do
  read -p "请输入选择的号码 (1-2): " choice
  if [[ "$choice" =~ ^[1-2]$ ]]; then
    break
  else
    echo "无效输入，请输入 1 或 2."
  fi
done

# 选择恢复原始 DNS 配置
if [ "$choice" -eq 1 ]; then
  if [ -f /etc/resolv.conf.bak ]; then
    echo "恢复原始 DNS 配置..."
    cp /etc/resolv.conf.bak /etc/resolv.conf
    echo "恢复成功！当前 DNS 配置："
    cat /etc/resolv.conf
  else
    echo "备份文件未找到，无法恢复 DNS 配置。"
  fi
  exit 0
fi

# 如果选择更改DNS，继续执行以下操作

# 显示当前DNS设置
echo "当前DNS设置为："
cat /etc/resolv.conf | grep "nameserver"

# 备份当前 resolv.conf 文件
echo "正在备份当前 DNS 配置..."
cp /etc/resolv.conf /etc/resolv.conf.bak
echo "备份完成，备份文件保存为 /etc/resolv.conf.bak"

# 运行流媒体解锁检测脚本（检查当前状态）
echo "正在检测流媒体解锁情况..."
bash <(curl -L -s https://github.com/1-stream/RegionRestrictionCheck/raw/main/check.sh) -M 4

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

# 读取用户选择
while true; do
  read -p "请输入选择的号码 (1-8): " choice
  if [[ "$choice" =~ ^[1-8]$ ]]; then
    break
  else
    echo "无效输入，请输入 1 到 8 之间的数字."
  fi
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

# 重新运行流媒体解锁检测脚本，检查更新后的状况
echo "正在重新检测流媒体解锁情况..."
bash <(curl -L -s https://github.com/1-stream/RegionRestrictionCheck/raw/main/check.sh) -M 4

echo "操作完成！"
