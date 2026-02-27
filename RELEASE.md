# 发布说明 / Release Instructions

## 当前状态 / Current Status

✅ **已完成 / Completed:**
- Tasks 1-23: 核心实施 / Core Implementation
- Task 24: Unix/Mac 安装测试 / Unix/Mac Installation Test
- Task 27: 上游同步工具测试 / Upstream Sync Tool Test
- Task 28: Git 标签创建 / Git Tag Creation

📋 **待完成 / Remaining:**
- Task 29: 创建 GitHub Release
- Task 30: 提交 PR 到上游（可选）
- Tasks 25-26: Windows/CodeBuddy 测试（需要对应环境）

## Task 29: 创建 GitHub Release

### 步骤 1: 在 GitHub 创建仓库

1. 访问 https://github.com/new
2. 仓库名：`superpowers-codebuddy`
3. 描述：`Superpowers workflow system adapted for CodeBuddy IDE`
4. 公开仓库（Public）
5. 不要初始化 README/license/gitignore（我们已经有了）

### 步骤 2: 推送代码到 GitHub

```bash
cd /data/workspace/superpowers-codebuddy

# 添加远程仓库（替换 YOUR-USERNAME）
git remote add origin https://github.com/YOUR-USERNAME/superpowers-codebuddy.git

# 推送代码和标签
git push -u origin master
git push origin v4.3.1-codebuddy.1
```

### 步骤 3: 创建 GitHub Release

1. 访问 `https://github.com/YOUR-USERNAME/superpowers-codebuddy/releases/new`
2. 选择标签：`v4.3.1-codebuddy.1`
3. Release 标题：`v4.3.1-codebuddy.1 - Initial Release`
4. 描述：

```markdown
## Superpowers for CodeBuddy v4.3.1-codebuddy.1

基于 obra/superpowers v4.3.1 的 CodeBuddy IDE 适配版本。

### 新功能 / Features

- ✅ **CodeBuddy 原生集成** - 使用 Skills 和 Hooks，无需额外进程
- ✅ **跨平台支持** - Windows、Mac、Linux 全平台支持
- ✅ **14 个工作流技能** - 完整的软件开发工作流
- ✅ **自动化安装** - 一键安装脚本
- ✅ **上游同步工具** - 轻松保持更新

### 安装 / Installation

**Mac/Linux:**
\`\`\`bash
git clone https://github.com/YOUR-USERNAME/superpowers-codebuddy.git
cd superpowers-codebuddy
./install.sh
\`\`\`

**Windows:**
\`\`\`powershell
git clone https://github.com/YOUR-USERNAME/superpowers-codebuddy.git
cd superpowers-codebuddy
.\install.ps1
\`\`\`

详细文档请查看 [README.md](https://github.com/YOUR-USERNAME/superpowers-codebuddy/blob/master/README.md)

### 测试平台 / Tested On

- Linux (verified)
- macOS (installation script tested)
- Windows 10/11 with Git for Windows (requires testing)

### 致谢 / Credits

基于 [obra/superpowers](https://github.com/obra/superpowers) by Jesse Vincent
```

5. 点击 "Publish release"

---

## Task 30: 提交 PR 到上游（可选）

### 步骤 1: Fork 上游仓库

1. 访问 https://github.com/obra/superpowers
2. 点击右上角 "Fork" 按钮

### 步骤 2: 克隆你的 fork

```bash
cd /tmp
git clone https://github.com/YOUR-USERNAME/superpowers.git
cd superpowers
```

### 步骤 3: 创建分支并编辑 README

```bash
git checkout -b add-codebuddy-link

# 编辑 README.md，在 Cursor 部分后添加：
```

在 README.md 的安装部分添加：

```markdown
### CodeBuddy

In CodeBuddy, install the adapted version:

\`\`\`bash
git clone https://github.com/YOUR-USERNAME/superpowers-codebuddy.git
cd superpowers-codebuddy
./install.sh  # Mac/Linux
.\install.ps1  # Windows
\`\`\`

**Detailed docs:** [superpowers-codebuddy README](https://github.com/YOUR-USERNAME/superpowers-codebuddy/blob/master/README.md)
```

### 步骤 4: 提交并推送

```bash
git add README.md
git commit -m "docs: add CodeBuddy installation instructions"
git push origin add-codebuddy-link
```

### 步骤 5: 创建 Pull Request

1. 访问你的 fork 页面
2. 点击 "Compare & pull request"
3. 标题：`docs: add CodeBuddy installation instructions`
4. 描述：

```
Adds installation instructions for CodeBuddy IDE.

I've created an adaptation of Superpowers for CodeBuddy that uses their native Skills and Hooks system. This PR adds a link to that adaptation in the installation section.

Repository: https://github.com/YOUR-USERNAME/superpowers-codebuddy
```

5. 点击 "Create pull request"

---

## Tasks 25-26: Windows 和 CodeBuddy 测试（手动）

### Task 25: Windows 安装测试

需要 Windows 10/11 环境：

1. 克隆仓库
2. 运行 `.\install.ps1`
3. 验证文件复制到 `%USERPROFILE%\.codebuddy\`
4. 验证环境变量 `SUPERPOWERS_ROOT` 已设置
5. 使用 Git Bash 测试 hook 执行

### Task 26: CodeBuddy 集成测试

需要 CodeBuddy IDE：

1. 安装 superpowers-codebuddy
2. 设置 `SUPERPOWERS_ROOT` 环境变量
3. 重启 CodeBuddy IDE
4. 测试 SessionStart hook（新会话应该提到 superpowers）
5. 测试技能调用（说 "use brainstorming skill"）
6. 测试自动触发（说 "implement a new feature"）

---

## 完成检查清单 / Completion Checklist

- [x] Task 1-23: 核心实施完成
- [x] Task 24: Unix/Mac 安装测试通过
- [x] Task 27: 上游同步工具测试通过
- [x] Task 28: Git 标签创建完成
- [ ] Task 29: GitHub Release 发布（需要 GitHub 账号）
- [ ] Task 30: 提交 PR 到上游（可选）
- [ ] Task 25: Windows 安装测试（需要 Windows 环境）
- [ ] Task 26: CodeBuddy 集成测试（需要 CodeBuddy IDE）

---

## 技术总结 / Technical Summary

**仓库位置**: `/data/workspace/superpowers-codebuddy`

**版本**: `v4.3.1-codebuddy.1`

**提交数**: 21 commits

**包含内容**:
- 14 个适配的技能（添加了 `allowed-tools` 和 `disable` 字段）
- CodeBuddy 兼容的 SessionStart hook
- 跨平台安装脚本（Unix/Mac 和 Windows）
- 上游同步工具
- 双语 README 文档

**已测试**:
- ✅ Linux 安装脚本
- ✅ 上游同步工具
- ✅ Hook 脚本执行

**待测试**:
- ⏳ Windows 安装脚本
- ⏳ CodeBuddy IDE 集成

---

**注意**: 记得将所有示例中的 `YOUR-USERNAME` 替换为你的 GitHub 用户名！
