# Superpowers for CodeBuddy - Installation Script (Windows)

Write-Host "=== Superpowers for CodeBuddy 安装程序 ===" -ForegroundColor Cyan
Write-Host "=== Superpowers for CodeBuddy Installer ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "请选择安装范围 / Choose installation scope:"
Write-Host "  1) 用户级 (所有项目通用) / User-level (all projects) - Recommended"
Write-Host "  2) 项目级 (仅当前项目) / Project-level (current project only)"
Write-Host ""

$choice = Read-Host "请输入选项 / Enter choice [1]"
if ([string]::IsNullOrEmpty($choice)) { $choice = "1" }

if ($choice -eq "1") {
    $targetDir = "$env:USERPROFILE\.codebuddy"
    Write-Host "安装到用户级目录 / Installing to user-level: $targetDir" -ForegroundColor Green
} elseif ($choice -eq "2") {
    $targetDir = "$(Get-Location)\.codebuddy"
    Write-Host "安装到项目级目录 / Installing to project-level: $targetDir" -ForegroundColor Green
} else {
    Write-Host "无效选项 / Invalid choice" -ForegroundColor Red
    exit 1
}

# Create target directory
New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

# Copy skills
Write-Host "复制技能文件 / Copying skills..." -ForegroundColor Yellow
Copy-Item -Recurse -Force ".codebuddy\skills" "$targetDir\"

# Copy or merge settings.json
if (Test-Path "$targetDir\settings.json") {
    Write-Host "检测到现有配置文件 / Existing config detected" -ForegroundColor Yellow
    $overwrite = Read-Host "是否覆盖 settings.json? / Overwrite settings.json? [y/N]"
    if ($overwrite -eq "y" -or $overwrite -eq "Y") {
        Copy-Item -Force ".codebuddy\settings.json" "$targetDir\"
        Write-Host "已覆盖配置文件 / Config overwritten" -ForegroundColor Green
    } else {
        Write-Host "保留现有配置，请手动合并 / Keeping existing config, please manually merge" -ForegroundColor Yellow
    }
} else {
    Copy-Item -Force ".codebuddy\settings.json" "$targetDir\"
}

# Copy hooks scripts
Write-Host "复制Hooks脚本 / Copying hooks..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path "$targetDir\hooks" | Out-Null
Copy-Item -Force "hooks\*" "$targetDir\hooks\"

# Set environment variable
Write-Host ""
Write-Host "设置环境变量 / Setting environment variable..." -ForegroundColor Yellow
[System.Environment]::SetEnvironmentVariable("SUPERPOWERS_ROOT", $targetDir, "User")

Write-Host ""
Write-Host "✅ 安装完成！/ Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "已设置环境变量 / Environment variable set:" -ForegroundColor Cyan
Write-Host "SUPERPOWERS_ROOT=$targetDir" -ForegroundColor Cyan
Write-Host ""
Write-Host "重启 CodeBuddy 后生效 / Restart CodeBuddy to activate" -ForegroundColor Cyan
