# Changelog

## [4.3.1-codebuddy.2] - 2026-03-03

### Added
- `.codebuddy/commands/` directory with 13 commands for all superpowers skills
- Recommended agent configurations (Code Review Expert, Debug Assistant, Requirements Analyst) in README

### Fixed
- `hooks/session-start`: add `additional_context` field for compatibility alongside `hookSpecificOutput`
- `hooks/session-start`: add activation indicator message to session context
- `.codebuddy/settings.json`: expand SessionStart matcher from `startup` to `startup|resume|clear|compact`
- `.codebuddy/settings.json`: route hook through `run-hook.cmd` wrapper for Windows compatibility
- Command files: add frontmatter with `description` and `disable-model-invocation: true`

---

## [4.3.1-codebuddy.1] - 2026-02-27

### Based on Upstream
- obra/superpowers v4.3.1

### Added
- CodeBuddy native adaptation using Skills and Hooks
- Cross-platform installation scripts (install.sh, install.ps1)
- Upstream synchronization tool (sync-from-upstream.sh)
- Chinese and English documentation

### Changed
- Skills frontmatter: added `allowed-tools` and `disable` fields
- Hooks JSON format adapted for CodeBuddy specification
- Environment variable changed from CLAUDE_PLUGIN_ROOT to SUPERPOWERS_ROOT
- Removed legacy skills directory check

### Technical Details
- 14 skills adapted with tool permissions
- SessionStart hook outputs CodeBuddy-compatible JSON
- Cross-platform hook wrapper preserved for Windows/Mac/Linux support
