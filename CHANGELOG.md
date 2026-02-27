# Changelog

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
