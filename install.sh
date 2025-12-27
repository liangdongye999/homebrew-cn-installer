#! /bin/env bash
# 梁栋烨作品，以MIT协议开源，自由分发，代码部分来自https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/

setup-homebrew() {
# 配置Homebrew镜像
cat << EOF

export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_INSTALL_FROM_API=1
export HOMEBREW_PIP_INDEX_URL="https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple"
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

EOF | tee -a ~/.bash_profile | tee -a ~/.zprofile

# 安装Homebrew
git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install
/bin/bash brew-install/install.sh
rm -rf brew-install

# 配置Homebrew环境变量
if [ $(uname -m) = "arm64" ]; then
test -r ~/.bash_profile && echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bash_profile
test -r ~/.zprofile && echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
fi
}

change-repo() {
# 切换Homebrew仓库为清华大学镜像
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
for tap in core cask; do
brew tap --custom-remote "homebrew/${tap}" "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-${tap}.git"
done
brew update
}

main() {
# 主函数
echo "请选择换源还是安装Homebrew（如果你没有安装Homebrew请选择安装、如果你已经安装Homebrew请选择换源）"
echo "1) 换源"
echo "2) 安装Homebrew"
read -p "请输入你的选择（1或2）：" CHOICE
case $CHOICE in
1)
change-repo
;;
2)
setup-homebrew
;;
*)
echo "无效选择"
;;
esac
}

main