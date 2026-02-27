#!/usr/bin/env bash
# Superpowers for CodeBuddy - Installation Script

set -e

echo "=== Superpowers for CodeBuddy 安装程序 ==="
echo "=== Superpowers for CodeBuddy Installer ==="
echo ""
echo "请选择安装范围 / Choose installation scope:"
echo "  1) 用户级 (所有项目通用) / User-level (all projects) - Recommended"
echo "  2) 项目级 (仅当前项目) / Project-level (current project only)"
echo ""
read -p "请输入选项 / Enter choice [1]: " choice
choice=${choice:-1}

if [ "$choice" = "1" ]; then
    TARGET_DIR="${HOME}/.codebuddy"
    echo "安装到用户级目录 / Installing to user-level: ${TARGET_DIR}"
elif [ "$choice" = "2" ]; then
    TARGET_DIR="$(pwd)/.codebuddy"
    echo "安装到项目级目录 / Installing to project-level: ${TARGET_DIR}"
else
    echo "无效选项 / Invalid choice"
    exit 1
fi

# Create target directory
mkdir -p "${TARGET_DIR}"

# Copy skills
echo "复制技能文件 / Copying skills..."
cp -r .codebuddy/skills "${TARGET_DIR}/"

# Copy or merge settings.json
if [ -f "${TARGET_DIR}/settings.json" ]; then
    echo "检测到现有配置文件 / Existing config detected"
    read -p "是否覆盖 settings.json? / Overwrite settings.json? [y/N]: " overwrite
    if [ "$overwrite" = "y" ] || [ "$overwrite" = "Y" ]; then
        cp .codebuddy/settings.json "${TARGET_DIR}/"
        echo "已覆盖配置文件 / Config overwritten"
    else
        echo "保留现有配置，请手动合并 .codebuddy/settings.json"
        echo "Keeping existing config, please manually merge .codebuddy/settings.json"
    fi
else
    cp .codebuddy/settings.json "${TARGET_DIR}/"
fi

# Copy hooks scripts
echo "复制Hooks脚本 / Copying hooks..."
mkdir -p "${TARGET_DIR}/hooks"
cp -r hooks/* "${TARGET_DIR}/hooks/"
chmod +x "${TARGET_DIR}/hooks/"*

# Environment variable prompt
echo ""
echo "✅ 安装完成！/ Installation complete!"
echo ""
echo "⚠️  重要 / Important:"
echo "请将以下环境变量添加到你的 shell 配置文件："
echo "Please add this environment variable to your shell config:"
echo ""
echo "export SUPERPOWERS_ROOT=\"${TARGET_DIR}\""
echo ""
echo "示例 / Example:"
echo "  echo 'export SUPERPOWERS_ROOT=\"${TARGET_DIR}\"' >> ~/.bashrc"
echo "  echo 'export SUPERPOWERS_ROOT=\"${TARGET_DIR}\"' >> ~/.zshrc"
echo ""
echo "重启 CodeBuddy 后生效 / Restart CodeBuddy to activate"
