#!/bin/bash
# 示例脚本：/usr/local/bin/change_ssh_port.sh

# 指定要操作的配置文件（此处以 SSH 为例）
CONFIG_FILE="/etc/ssh/sshd_config"

# 检查配置文件是否存在
if [ ! -f "$CONFIG_FILE" ]; then
  echo "错误：配置文件 $CONFIG_FILE 不存在！"
  exit 1
fi

# 自动查询当前 SSH 端口
CURRENT_PORT=$(grep -E '^Port ' "$CONFIG_FILE" | awk '{print $2}' | head -n 1)
if [ -z "$CURRENT_PORT" ]; then
  echo "当前配置文件中没有找到端口设置。"
else
  echo "当前 SSH 端口为: $CURRENT_PORT"
fi

# 交互输入新端口号
read -p "请输入新的 SSH 端口号: " NEW_PORT

# 验证端口号是否为纯数字
if ! [[ $NEW_PORT =~ ^[0-9]+$ ]]; then
  echo "错误：端口号必须为数字。"
  exit 1
fi

# 备份原始配置文件
sudo cp "$CONFIG_FILE" "${CONFIG_FILE}.bak"
echo "已备份原始配置文件到 ${CONFIG_FILE}.bak"

# 修改配置文件中的端口设置
sudo sed -i "s/^Port [0-9]\+/Port $NEW_PORT/" "$CONFIG_FILE"
echo "SSH 端口已更改为 $NEW_PORT"

# 提示重启 SSH 服务
echo "请重启 SSH 服务以使修改生效，例如：sudo systemctl restart sshd"
