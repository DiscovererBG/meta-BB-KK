#!/bin/bash
# 文件路径：/usr/local/bin/hange_port.sh
# 说明：此脚本用于查询并修改 SSH 的端口，并提供选项重启 VPS

CONFIG_FILE="/etc/ssh/sshd_config"

# 检查配置文件是否存在
if [ ! -f "$CONFIG_FILE" ]; then
  echo "错误：配置文件 $CONFIG_FILE 不存在！"
  exit 1
fi

# 查询当前 SSH 端口（查找非注释行）
CURRENT_PORT=$(grep -E '^[[:space:]]*Port[[:space:]]+[0-9]+' "$CONFIG_FILE" | awk '{print $2}' | head -n 1)
if [ -z "$CURRENT_PORT" ]; then
  echo "当前配置文件中没有找到端口设置，默认假定端口为 22。"
  CURRENT_PORT=22
else
  echo "当前 SSH 端口为: $CURRENT_PORT"
fi

# 获取新端口号（参数传入或交互输入）
if [ $# -eq 1 ]; then
  NEW_PORT=$1
else
  read -p "请输入新的 SSH 端口号: " NEW_PORT
fi

# 验证端口号格式
if ! [[ $NEW_PORT =~ ^[0-9]+$ ]]; then
  echo "错误：端口号必须为数字。"
  exit 1
fi

# 备份原配置文件
sudo cp "$CONFIG_FILE" "${CONFIG_FILE}.bak"
echo "已备份原始配置文件到 ${CONFIG_FILE}.bak"

# 修改配置文件中的端口设置
if grep -qE '^[[:space:]]*Port[[:space:]]+[0-9]+' "$CONFIG_FILE"; then
  sudo sed -i "0,/^[[:space:]]*Port[[:space:]]\+[0-9]\+/s//Port $NEW_PORT/" "$CONFIG_FILE"
else
  # 如果没有找到有效的 Port 行，则追加到文件末尾
  echo -e "\nPort $NEW_PORT" | sudo tee -a "$CONFIG_FILE"
fi

echo "SSH 端口已修改为 $NEW_PORT"
echo "请重启 SSH 服务以使修改生效（例如：sudo systemctl restart sshd）"

# 添加选项：是否重启 VPS 以使改动生效
read -p "是否现在重启 VPS 以使改动生效？（y/N）：" REBOOT_CHOICE
case "$REBOOT_CHOICE" in
    y|Y )
        echo "系统正在重启..."
        sudo reboot
        ;;
    * )
        echo "请手动重启 VPS 以使改动生效。"
        ;;
esac
