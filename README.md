# Superpowers for CodeBuddy

[中文](#中文说明) | [English](#english)

---

## 中文说明

### CodeBuddy AI 超能力技能包

这是 [Superpowers](https://github.com/coleam00/ottomator-agents) 框架在 CodeBuddy IDE 中的适配版本，为 Claude AI 助手提供了一套结构化的工作流程技能。

### 特性

- **结构化工作流程**: 提供代码审查、测试驱动开发、系统调试等多种专业技能
- **双语支持**: 所有技能同时支持中文和英文
- **CodeBuddy 原生集成**: 使用 CodeBuddy 的 `.claude/` 配置系统
- **快速安装**: 一键安装脚本，自动处理所有配置

### 安装

#### 一行命令安装（推荐）

**Mac/Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/wyb10a10/superpowers-codebuddy/main/install.sh | bash
```

#### 手动安装

**Mac/Linux:**

```bash
# 克隆仓库
git clone https://github.com/wyb10a10/superpowers-codebuddy.git
cd superpowers-codebuddy

# 运行安装脚本
./install.sh
```

#### Windows

```powershell
# 克隆仓库
git clone https://github.com/wyb10a10/superpowers-codebuddy.git
cd superpowers-codebuddy

# 运行安装脚本
powershell -ExecutionPolicy Bypass -File install.ps1
```

安装脚本会自动：
1. 检测你的 CodeBuddy 配置目录（`~/.config/codebuddy/.claude/` 或 `%APPDATA%\CodeBuddy\.claude\`）
2. 创建技能目录结构
3. 复制所有技能文件
4. 设置正确的权限

### 配置环境变量（可选）

如果你的 CodeBuddy 配置目录在非标准位置，可以设置环境变量：

**Mac/Linux:**
```bash
export CODEBUDDY_CONFIG_DIR="/path/to/your/codebuddy/config/.claude"
./install.sh
```

**Windows:**
```powershell
$env:CODEBUDDY_CONFIG_DIR = "C:\path\to\your\codebuddy\config\.claude"
.\install.ps1
```

### 验证安装

安装完成后：

1. 重启 CodeBuddy IDE
2. 打开任意项目
3. 在 Claude 对话中，技能会自动在需要时被调用
4. 你也可以手动测试，例如输入："请使用 brainstorming 技能帮我设计一个功能"

### 使用方法

技能会根据上下文自动触发。你也可以：

1. **直接请求技能**: "使用 test-driven-development 技能来实现这个功能"
2. **触发场景**: 当你要求审查代码、调试问题、编写测试时，相应技能会自动激活
3. **查看技能**: 所有技能文档位于 `~/.config/codebuddy/.claude/skills/superpowers/`

### 可用技能

| 技能名称 | 用途 | 触发场景 |
|---------|------|---------|
| `brainstorming` | 创意探索和需求分析 | 创建功能、构建组件前 |
| `dispatching-parallel-agents` | 并行任务分发 | 2个以上独立任务 |
| `executing-plans` | 执行实施计划 | 有书面实施计划时 |
| `finishing-a-development-branch` | 完成开发分支 | 实现完成、需要集成时 |
| `receiving-code-review` | 接收代码审查 | 收到审查反馈时 |
| `requesting-code-review` | 请求代码审查 | 完成任务、合并前 |
| `subagent-driven-development` | 子代理驱动开发 | 当前会话中执行计划 |
| `systematic-debugging` | 系统化调试 | 遇到bug、测试失败时 |
| `test-driven-development` | 测试驱动开发 | 实现功能或修复前 |
| `using-git-worktrees` | Git工作树管理 | 需要隔离工作区时 |
| `using-superpowers` | 超能力使用指南 | 任何对话开始时 |
| `verification-before-completion` | 完成前验证 | 声称完成工作前 |
| `writing-plans` | 编写实施计划 | 多步骤任务前 |
| `writing-skills` | 编写技能 | 创建或编辑技能时 |

### 推荐智能体配置

CodeBuddy 智能体通过 UI 创建（对话框左下角 → 创建智能体），无法通过配置文件部署。以下是推荐的智能体配置，复制后在 CodeBuddy 中创建即可。

勾选"子智能体"后，默认 Agent 会在合适时机自动调用这些智能体。

#### 代码审查专家

- **名称**: 代码审查专家
- **描述（影响自动调用）**: 当用户需要审查代码、检查 MR/PR、评估代码质量、分析代码规范时，必须调用我
- **系统提示词**:
  ```
  你是一位严格的代码审查专家。当收到代码审查请求时，使用 receiving-code-review 技能来系统性地处理审查反馈，使用 requesting-code-review 技能来主动审查代码质量。关注代码正确性、可维护性、安全性和性能。
  ```

#### 调试助手

- **名称**: 调试助手
- **描述（影响自动调用）**: 当用户遇到 bug、测试失败、程序异常、报错信息时，必须调用我
- **系统提示词**:
  ```
  你是一位系统化的调试专家。遇到任何 bug 或异常时，立即使用 systematic-debugging 技能，按照假设-验证的方式逐步定位根因，不凭直觉猜测。
  ```

#### 需求分析师

- **名称**: 需求分析师
- **描述（影响自动调用）**: 当用户要设计新功能、讨论需求、规划系统架构、创建实施计划时，必须调用我
- **系统提示词**:
  ```
  你是一位严谨的需求分析师。接到新功能或设计任务时，先使用 brainstorming 技能充分探索需求，再使用 writing-plans 技能制定详细实施计划，避免直接跳入编码。
  ```

### 故障排除

#### 技能未生效

1. **检查安装位置**:
   ```bash
   # Mac/Linux
   ls -la ~/.config/codebuddy/.claude/skills/superpowers/

   # Windows
   dir %APPDATA%\CodeBuddy\.claude\skills\superpowers\
   ```

2. **验证文件结构**:
   ```
   .claude/
   └── skills/
       └── superpowers/
           ├── skill.md
           ├── brainstorming.md
           ├── systematic-debugging.md
           └── ...（其他技能文件）
   ```

3. **重启 CodeBuddy**: 配置更改需要重启 IDE

4. **检查权限**: 确保文件可读
   ```bash
   chmod -R 644 ~/.config/codebuddy/.claude/skills/superpowers/*.md
   ```

#### 找不到配置目录

如果自动检测失败，手动设置环境变量后重新运行安装脚本。

### 致谢

本项目改编自：
- [Superpowers](https://github.com/coleam00/ottomator-agents) - 由 Cole Medin 创建
- 原始技能内容和工作流程由 Superpowers 社区开发

### 许可证

MIT License - 详见 LICENSE 文件

---

## English

### CodeBuddy AI Superpowers Skill Pack

This is an adaptation of the [Superpowers](https://github.com/coleam00/ottomator-agents) framework for CodeBuddy IDE, providing structured workflow skills for Claude AI assistant.

### Features

- **Structured Workflows**: Professional skills including code review, test-driven development, systematic debugging, and more
- **Bilingual Support**: All skills support both Chinese and English
- **Native CodeBuddy Integration**: Uses CodeBuddy's `.claude/` configuration system
- **Quick Installation**: One-command install script handles all configuration

### Installation

#### One-line Install (Recommended)

**Mac/Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/wyb10a10/superpowers-codebuddy/main/install.sh | bash
```

#### Manual Install

**Mac/Linux:**

```bash
# Clone the repository
git clone https://github.com/wyb10a10/superpowers-codebuddy.git
cd superpowers-codebuddy

# Run install script
./install.sh
```

#### Windows

```powershell
# Clone the repository
git clone https://github.com/wyb10a10/superpowers-codebuddy.git
cd superpowers-codebuddy

# Run install script
powershell -ExecutionPolicy Bypass -File install.ps1
```

The install script will automatically:
1. Detect your CodeBuddy config directory (`~/.config/codebuddy/.claude/` or `%APPDATA%\CodeBuddy\.claude\`)
2. Create skill directory structure
3. Copy all skill files
4. Set correct permissions

### Configure Environment Variables (Optional)

If your CodeBuddy config directory is in a non-standard location, set the environment variable:

**Mac/Linux:**
```bash
export CODEBUDDY_CONFIG_DIR="/path/to/your/codebuddy/config/.claude"
./install.sh
```

**Windows:**
```powershell
$env:CODEBUDDY_CONFIG_DIR = "C:\path\to\your\codebuddy\config\.claude"
.\install.ps1
```

### Verify Installation

After installation:

1. Restart CodeBuddy IDE
2. Open any project
3. In Claude conversations, skills will be automatically invoked when needed
4. You can also test manually, e.g., "Please use the brainstorming skill to help me design a feature"

### Usage

Skills are triggered automatically based on context. You can also:

1. **Direct Request**: "Use the test-driven-development skill to implement this feature"
2. **Trigger Scenarios**: When you request code review, debugging, or testing, relevant skills activate automatically
3. **View Skills**: All skill documentation is in `~/.config/codebuddy/.claude/skills/superpowers/`

### Available Skills

| Skill Name | Purpose | Trigger Scenario |
|-----------|---------|-----------------|
| `brainstorming` | Creative exploration and requirements analysis | Before creating features/components |
| `dispatching-parallel-agents` | Parallel task dispatching | 2+ independent tasks |
| `executing-plans` | Execute implementation plans | When you have a written plan |
| `finishing-a-development-branch` | Complete development branch | Implementation done, needs integration |
| `receiving-code-review` | Receive code review feedback | When receiving review feedback |
| `requesting-code-review` | Request code review | Before completing tasks/merging |
| `subagent-driven-development` | Subagent-driven development | Executing plans in current session |
| `systematic-debugging` | Systematic debugging | When encountering bugs/test failures |
| `test-driven-development` | Test-driven development | Before implementing features/fixes |
| `using-git-worktrees` | Git worktree management | When workspace isolation needed |
| `using-superpowers` | Superpowers usage guide | At conversation start |
| `verification-before-completion` | Verify before completion | Before claiming work complete |
| `writing-plans` | Write implementation plans | Before multi-step tasks |
| `writing-skills` | Write skills | When creating/editing skills |

### Recommended Agent Configurations

CodeBuddy agents are created via UI (bottom-left of chat → Create Agent) and cannot be deployed via config files. Copy these configurations to create agents in CodeBuddy.

Enable "Sub-agent" to allow the default Agent to automatically call these agents when appropriate.

#### Code Review Expert

- **Name**: Code Review Expert
- **Description (affects auto-invocation)**: When the user needs code review, MR/PR review, code quality analysis, or coding standard checks, I must be called
- **System Prompt**:
  ```
  You are a strict code review expert. Use the receiving-code-review skill when processing review feedback, and the requesting-code-review skill when proactively reviewing code quality. Focus on correctness, maintainability, security, and performance.
  ```

#### Debug Assistant

- **Name**: Debug Assistant
- **Description (affects auto-invocation)**: When the user encounters bugs, test failures, exceptions, or error messages, I must be called
- **System Prompt**:
  ```
  You are a systematic debugging expert. Use the systematic-debugging skill immediately when encountering any bug or exception. Follow hypothesis-validation approach to locate root causes. Never guess.
  ```

#### Requirements Analyst

- **Name**: Requirements Analyst
- **Description (affects auto-invocation)**: When the user wants to design new features, discuss requirements, plan system architecture, or create implementation plans, I must be called
- **System Prompt**:
  ```
  You are a rigorous requirements analyst. Use the brainstorming skill to thoroughly explore requirements before any new feature or design task, then use writing-plans to create a detailed implementation plan. Never jump straight into coding.
  ```

### Troubleshooting

#### Skills Not Working

1. **Check installation location**:
   ```bash
   # Mac/Linux
   ls -la ~/.config/codebuddy/.claude/skills/superpowers/

   # Windows
   dir %APPDATA%\CodeBuddy\.claude\skills\superpowers\
   ```

2. **Verify file structure**:
   ```
   .claude/
   └── skills/
       └── superpowers/
           ├── skill.md
           ├── brainstorming.md
           ├── systematic-debugging.md
           └── ...(other skill files)
   ```

3. **Restart CodeBuddy**: Configuration changes require IDE restart

4. **Check permissions**: Ensure files are readable
   ```bash
   chmod -R 644 ~/.config/codebuddy/.claude/skills/superpowers/*.md
   ```

#### Config Directory Not Found

If auto-detection fails, manually set the environment variable and re-run the install script.

### Credits

This project is adapted from:
- [Superpowers](https://github.com/coleam00/ottomator-agents) - Created by Cole Medin
- Original skill content and workflows developed by the Superpowers community

### License

MIT License - See LICENSE file for details
