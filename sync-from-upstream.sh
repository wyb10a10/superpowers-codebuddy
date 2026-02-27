#!/usr/bin/env bash
# Sync skills from obra/superpowers upstream

set -e

UPSTREAM_REPO="https://github.com/obra/superpowers.git"
TEMP_DIR=$(mktemp -d)

echo "=== 从上游仓库同步技能 ==="
echo "=== Syncing from upstream repository ==="
echo "上游仓库 / Upstream: ${UPSTREAM_REPO}"
echo ""

# Clone upstream repository
echo "正在克隆上游仓库 / Cloning upstream..."
git clone --depth 1 "${UPSTREAM_REPO}" "${TEMP_DIR}"

# Get upstream version
UPSTREAM_VERSION=$(cat "${TEMP_DIR}/.claude-plugin/plugin.json" | grep '"version"' | sed 's/.*: "\(.*\)".*/\1/')
echo "上游版本 / Upstream version: ${UPSTREAM_VERSION}"

# Sync skills directory
echo "同步 skills/ 目录 / Syncing skills/..."
rsync -av --delete "${TEMP_DIR}/skills/" ".codebuddy/skills/"

# Check hooks for updates
if ! diff -q "${TEMP_DIR}/hooks/session-start" "hooks/session-start" > /dev/null 2>&1; then
    echo "⚠️  检测到上游 hooks 有更新，请手动检查差异"
    echo "⚠️  Upstream hooks changed, please review differences manually"
    echo "运行 / Run: diff ${TEMP_DIR}/hooks/session-start hooks/session-start"
fi

# Cleanup
rm -rf "${TEMP_DIR}"

echo ""
echo "✅ 同步完成！/ Sync complete!"
echo "请检查更新内容并重新适配 Skills frontmatter"
echo "Please review changes and re-adapt Skills frontmatter"
echo "然后运行 / Then run: ./install.sh"
