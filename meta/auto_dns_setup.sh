#!/bin/bash

# 默认DNS地址
DEFAULT_DNS="154.83.83.83"

# 查询当前的DNS设置
echo "当前DNS设置为："
cat /etc/resolv.conf | grep "nameserver"

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

# 运行流媒体解锁检测脚本（检查当前状态）
echo "正在检测流媒体解锁情况..."
bash <(curl -L -s https://github.com/1-stream/RegionRestrictionCheck/raw/main/check.sh) -M 4

# 读取用户选择
read -p "请输入选择的号码 (1-8): " choice

# 设置DNS地址
case $choice in
  1) DNS="154.83.83.83" ;;
  2) DNS="154.83.83.84" ;;
  3) DNS="154.83.83.85" ;;
  4) DNS="154.83.83.86" ;;
  5) DNS="154.83.83.87" ;;
  6) DNS="154.83.83.88" ;;
  7) DNS="154.83.83.89" ;;
  8) DNS="154.83.83.90" ;;
  *) echo "无效的选择，使用默认 DNS ($DEFAULT_DNS)" && DNS="$DEFAULT_DNS" ;;
esac

# 备份当前 resolv.conf 并更新为新的 DNS
echo "正在更新DNS为 $DNS ..."
cp /etc/resolv.conf /etc/resolv.conf.bak
echo "nameserver $DNS" > /etc/resolv.conf

# 显示更新后的DNS
echo "DNS已更新为: $DNS"

# 重新运行流媒体解锁检测脚本，检查更新后的状况
echo "正在重新检测流媒体解锁情况..."
bash <(curl -L -s https://github.com/1-stream/RegionRestrictionCheck/raw/main/check.sh) -M 4

echo "操作完成！"
