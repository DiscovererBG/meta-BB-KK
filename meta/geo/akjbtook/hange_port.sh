#!/bin/bash
# 请确保使用管理员权限运行此脚本，如需修改 /etc 下的文件

# 配置文件路径（请根据实际情况修改）
CONFIG_FILE="/etc/myapp/config.conf"

# 检查配置文件是否存在
if [ ! -f "$CONFIG_FILE" ]; then
  echo "错误：配置文件 $CONFIG_FILE 不存在！"
  exit 1
fi

# 如果运行脚本时传入了参数，则使用参数作为新的端口号，否则提示输入
if [ $# -eq 1 ]; then
  NEW_PORT=$1
else
  read -p "请输入新的端口号: " NEW_PORT
fi

# 检查输入是否为纯数字
if ! [[ $NEW_PORT =~ ^[0-9]+$ ]]; then
  echo "错误：端口号必须为数字。"
  exit 1
fi

# 备份原始配置文件
cp "$CONFIG_FILE" "${CONFIG_FILE}.bak"
echo "已备份原始配置文件到 ${CONFIG_FILE}.bak"

# 修改配置文件中的端口号
# 这里假设配置文件中有一行形如：port=旧端口号
sed -i "s/port=[0-9]\+/port=$NEW_PORT/g" "$CONFIG_FILE"

echo "端口号已更改为 $NEW_PORT"