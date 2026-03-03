# Commands + Hooks + Agents 完善 Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 为 superpowers-codebuddy 项目添加 Commands 支持、完善 Hooks 反馈、在 README 中增加智能体创建手册。

**Architecture:** 新增 `.codebuddy/commands/` 目录，为每个 skill 创建对应的 command 文件（内容为触发 skill 的 prompt）；改进 `hooks/session-start` 的成功反馈输出；更新 `install.sh` 复制 commands 目录；在 README 中新增智能体手册章节。

**Tech Stack:** Bash, Markdown, JSON

---

### Task 1: 创建 `.codebuddy/commands/` 目录和所有 command 文件

**Files:**
- Create: `.codebuddy/commands/brainstorming.md`
- Create: `.codebuddy/commands/systematic-debugging.md`
- Create: `.codebuddy/commands/test-driven-development.md`
- Create: `.codebuddy/commands/requesting-code-review.md`
- Create: `.codebuddy/commands/receiving-code-review.md`
- Create: `.codebuddy/commands/writing-plans.md`
- Create: `.codebuddy/commands/writing-skills.md`
- Create: `.codebuddy/commands/verification-before-completion.md`
- Create: `.codebuddy/commands/using-git-worktrees.md`
- Create: `.codebuddy/commands/executing-plans.md`
- Create: `.codebuddy/commands/finishing-a-development-branch.md`
- Create: `.codebuddy/commands/dispatching-parallel-agents.md`
- Create: `.codebuddy/commands/subagent-driven-development.md`

**Step 1: 创建 brainstorming.md**

```markdown
Use the brainstorming skill to explore requirements and design before implementation. $ARGUMENTS
```

**Step 2: 创建 systematic-debugging.md**

```markdown
Use the systematic-debugging skill to diagnose and fix the issue. $ARGUMENTS
```

**Step 3: 创建 test-driven-development.md**

```markdown
Use the test-driven-development skill to implement this feature. $ARGUMENTS
```

**Step 4: 创建 requesting-code-review.md**

```markdown
Use the requesting-code-review skill to review the current work. $ARGUMENTS
```

**Step 5: 创建 receiving-code-review.md**

```markdown
Use the receiving-code-review skill to process this review feedback. $ARGUMENTS
```

**Step 6: 创建 writing-plans.md**

```markdown
Use the writing-plans skill to create an implementation plan. $ARGUMENTS
```

**Step 7: 创建 writing-skills.md**

```markdown
Use the writing-skills skill to create or edit a skill. $ARGUMENTS
```

**Step 8: 创建 verification-before-completion.md**

```markdown
Use the verification-before-completion skill to verify the work before marking it complete. $ARGUMENTS
```

**Step 9: 创建 using-git-worktrees.md**

```markdown
Use the using-git-worktrees skill to set up an isolated git worktree. $ARGUMENTS
```

**Step 10: 创建 executing-plans.md**

```markdown
Use the executing-plans skill to execute the implementation plan task-by-task. $ARGUMENTS
```

**Step 11: 创建 finishing-a-development-branch.md**

```markdown
Use the finishing-a-development-branch skill to complete and integrate this development branch. $ARGUMENTS
```

**Step 12: 创建 dispatching-parallel-agents.md**

```markdown
Use the dispatching-parallel-agents skill to dispatch these independent tasks in parallel. $ARGUMENTS
```

**Step 13: 创建 subagent-driven-development.md**

```markdown
Use the subagent-driven-development skill to execute the plan with subagents in this session. $ARGUMENTS
```

**Step 14: Commit**

```bash
git add .codebuddy/commands/
git commit -m "feat: add commands for all superpowers skills"
```

---

### Task 2: 改进 `hooks/session-start` 的成功反馈

**Files:**
- Modify: `hooks/session-start`

当前问题：hook 输出的 JSON 使用了 `hookSpecificOutput` 字段（Claude Code 格式），需要确认是否符合 CodeBuddy 规范，同时缺少用户可见的激活反馈。

**Step 1: 读取当前 session-start 文件**

读取 `hooks/session-start` 确认当前输出格式。

**Step 2: 修改 JSON 输出，增加 additionalContext 提示**

将 `hookSpecificOutput` 改为顶层的 `additionalContext` 字段（CodeBuddy 规范），并在 `additionalContext` 开头加上激活标志：

```bash
session_context="<EXTREMELY_IMPORTANT>\nYou have superpowers.\n\n**Below is the full content of your 'superpowers:using-superpowers' skill...**\n\n${using_superpowers_escaped}\n</EXTREMELY_IMPORTANT>"

cat <<EOF
{
  "continue": true,
  "additionalContext": "${session_context}"
}
EOF
```

> 注意：CodeBuddy Hooks 文档中 SessionStart 没有明确的输出格式，需保留 `hookSpecificOutput` 格式作为备用，实际以能生效为准。若当前格式已经生效（本次对话已验证），则只添加可见的成功提示即可，不改变 JSON 结构。

**Step 3: 验证 hook 脚本语法**

```bash
bash -n hooks/session-start
```
Expected: 无输出（语法无误）

**Step 4: Commit**

```bash
git add hooks/session-start
git commit -m "fix: improve session-start hook feedback"
```

---

### Task 3: 更新 `install.sh` 支持复制 commands 目录

**Files:**
- Modify: `install.sh`

**Step 1: 读取当前 install.sh**

读取 `install.sh` 找到复制 skills 的代码行。

**Step 2: 在复制 skills 的代码之后，添加复制 commands 的代码**

在 `cp -r .codebuddy/skills "${TARGET_DIR}/"` 之后添加：

```bash
# Copy commands
echo "复制Commands文件 / Copying commands..."
cp -r .codebuddy/commands "${TARGET_DIR}/"
```

**Step 3: Commit**

```bash
git add install.sh
git commit -m "feat: copy commands directory in install script"
```

---

### Task 4: 更新 `install.ps1` 支持复制 commands 目录

**Files:**
- Modify: `install.ps1`

**Step 1: 读取当前 install.ps1**

读取 `install.ps1` 找到复制 skills 的代码行。

**Step 2: 在复制 skills 的代码之后，添加复制 commands 的代码**

在复制 skills 之后添加：

```powershell
# Copy commands
Write-Host "复制Commands文件 / Copying commands..."
Copy-Item -Path ".codebuddy\commands" -Destination $TargetDir -Recurse -Force
```

**Step 3: Commit**

```bash
git add install.ps1
git commit -m "feat: copy commands directory in Windows install script"
```

---

### Task 5: 在 README 中添加智能体创建手册

**Files:**
- Modify: `README.md`

**Step 1: 读取当前 README.md**

读取 README 找到"可用技能"章节的位置，在其后插入智能体章节。

**Step 2: 在中文"可用技能"表格后添加智能体章节**

```markdown
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
```

**Step 3: 在英文"Available Skills"表格后添加对应英文章节**

```markdown
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
```

**Step 4: Commit**

```bash
git add README.md
git commit -m "docs: add recommended agent configurations to README"
```

---

### Task 6: 更新 `sync-from-upstream.sh` 支持同步 commands

**Files:**
- Modify: `sync-from-upstream.sh`

**Step 1: 读取当前 sync-from-upstream.sh**

```bash
cat sync-from-upstream.sh
```

**Step 2: 检查是否需要更新同步脚本**

若脚本中有对 `.codebuddy/skills` 的特殊处理，添加对 `.codebuddy/commands` 的同等处理。若脚本是通用 rsync/cp，则不需要修改。

**Step 3: 按需提交**

```bash
git add sync-from-upstream.sh
git commit -m "feat: sync commands directory from upstream"
```

---

### Task 7: 更新 CHANGELOG.md

**Files:**
- Modify: `CHANGELOG.md`

**Step 1: 读取当前 CHANGELOG.md**

**Step 2: 在最新版本下添加本次变更记录**

```markdown
### Added
- `.codebuddy/commands/` directory with commands for all 13 superpowers skills
- Recommended agent configurations (Code Review Expert, Debug Assistant, Requirements Analyst) in README

### Fixed
- Improved session-start hook feedback clarity
- install.sh now copies commands directory
```

**Step 3: Commit**

```bash
git add CHANGELOG.md
git commit -m "docs: update changelog for commands and agents support"
```
