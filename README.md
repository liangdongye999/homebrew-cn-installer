# Homebrew 中国镜像安装器

一个用于在中国大陆快速安装和配置 Homebrew 的 Bash 脚本，使用清华大学镜像源加速下载。

## 功能特性

- 🚀 **快速安装**: 使用国内镜像源，大幅提升安装速度
- 🔄 **一键换源**: 为已安装的 Homebrew 快速切换镜像源
- 🛡️ **安全可靠**: 基于官方 Homebrew 安装脚本，确保安全性
- 📱 **多架构支持**: 支持 Intel 和 Apple Silicon (M1/M2) 芯片
- 🐚 **Shell 兼容**: 自动配置 bash 和 zsh 环境

## 快速开始

### 一键安装（推荐）

使用以下命令直接在线安装：

```bash
curl -fsSL https://github.com/liangdongye999/homebrew-cn-installer/raw/refs/heads/main/install.sh | bash
```

安装过程中会提示选择操作：
- 选择 `1` 为已安装的 Homebrew 换源
- 选择 `2` 安装 Homebrew 并自动配置镜像源

### 手动安装（备用）

如果在线安装遇到问题，可以使用手动方式：

1. **下载脚本**:
   ```bash
   curl -O https://github.com/liangdongye999/homebrew-cn-installer/raw/refs/heads/main/install.sh
   ```

2. **运行脚本**:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

## 接口函数说明

### `setup-homebrew()`

**功能**: 安装 Homebrew 并配置清华大学镜像源

**主要操作**:
- 配置 Homebrew 环境变量（写入 `~/.bash_profile` 和 `~/.zprofile`）
- 克隆 Homebrew 安装脚本
- 执行安装过程
- 根据 CPU 架构配置 shell 环境

**配置的环境变量**:
- `HOMEBREW_BREW_GIT_REMOTE`: Homebrew 核心仓库镜像
- `HOMEBREW_CORE_GIT_REMOTE`: Homebrew Core 仓库镜像
- `HOMEBREW_INSTALL_FROM_API`: 启用 API 安装模式
- `HOMEBREW_PIP_INDEX_URL`: Python 包索引镜像
- `HOMEBREW_API_DOMAIN`: Homebrew API 镜像
- `HOMEBREW_BOTTLE_DOMAIN`: 预编译包镜像

### `change-repo()`

**功能**: 为已安装的 Homebrew 切换镜像源

**主要操作**:
- 更新 Homebrew Core 仓库远程地址
- 重新绑定 core 和 cask tap 的远程仓库
- 执行 `brew update` 更新仓库索引

### `main()`

**功能**: 主函数，提供用户交互界面

**主要操作**:
- 显示选择菜单
- 根据用户输入调用相应功能
- 处理无效输入

## 维护指南

### 镜像源维护

脚本当前使用清华大学镜像源，如需要更换其他镜像源，请修改以下变量：

```bash
# 在 setup-homebrew 函数中修改
HOMEBREW_BREW_GIT_REMOTE="新的brew镜像地址"
HOMEBREW_CORE_GIT_REMOTE="新的core镜像地址"
HOMEBREW_API_DOMAIN="新的API镜像地址"
HOMEBREW_BOTTLE_DOMAIN="新的bottle镜像地址"

# 在 change-repo 函数中修改
HOMEBREW_CORE_GIT_REMOTE="新的core镜像地址"
```

### 兼容性维护

**Shell 兼容性**:
- 脚本同时配置 bash 和 zsh 环境
- 如需支持其他 shell，可添加相应的配置文件

**架构兼容性**:
- 自动检测 CPU 架构（Intel/Apple Silicon）
- 正确设置 Homebrew 安装路径

### 错误处理维护

脚本包含基本的错误处理，建议在以下方面加强：

1. **网络连接检查**: 添加网络连通性测试
2. **权限验证**: 检查脚本执行权限
3. **依赖检查**: 验证 git 等必要工具是否安装
4. **回滚机制**: 安装失败时的清理操作

### 测试维护

建议定期测试以下场景：
- 全新系统安装测试
- 已安装 Homebrew 的换源测试
- 不同 macOS 版本兼容性测试
- 网络异常情况处理测试

### 版本更新

当 Homebrew 安装方式或镜像源地址发生变化时：

1. **更新安装脚本**: 检查官方安装脚本变化
2. **验证镜像源**: 确保镜像源地址有效
3. **测试功能**: 全面测试安装和换源功能
4. **更新文档**: 同步更新 README 和注释

## 故障排除

### 常见问题

**Q: 安装后 Homebrew 命令找不到**
A: 执行 `source ~/.bash_profile` 或重新打开终端

**Q: 换源后更新失败**
A: 检查网络连接，或尝试切换其他镜像源

**Q: 权限错误**
A: 确保有足够的权限执行脚本和安装软件

### 手动恢复

如需恢复官方源：
```bash
# 删除镜像相关环境变量
sed -i '' '/HOMEBREW_/d' ~/.bash_profile ~/.zprofile

# 重置仓库远程地址
brew tap --custom-remote homebrew/core https://github.com/Homebrew/homebrew-core
brew tap --custom-remote homebrew/cask https://github.com/Homebrew/homebrew-cask
```

## 许可证

本项目采用 MIT 许可证开源。

## 贡献

欢迎提交 Issue 和 Pull Request 来改进这个项目。

## 免责声明

本脚本仅用于技术学习和交流，使用过程中产生的任何问题请自行承担风险。