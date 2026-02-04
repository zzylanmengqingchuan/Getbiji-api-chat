#!/bin/bash

###############################################################################
# Get 笔记知识库问答 Skill - 安装脚本
###############################################################################

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

echo "=========================================="
echo "  Get 笔记知识库问答 Skill - 安装向导"
echo "=========================================="
echo ""

# 检查依赖
log_info "检查系统依赖..."

missing_deps=()

# 检查 curl
if ! command -v curl &> /dev/null; then
    missing_deps+=("curl")
fi

# 检查 jq
if ! command -v jq &> /dev/null; then
    missing_deps+=("jq")
fi

if [ ${#missing_deps[@]} -ne 0 ]; then
    log_error "缺少以下依赖: ${missing_deps[*]}"
    echo ""
    echo "请先安装缺少的工具："
    echo "  Ubuntu/Debian: sudo apt-get install ${missing_deps[*]}"
    echo "  macOS: brew install ${missing_deps[*]}"
    echo ""
    exit 1
fi

log_success "依赖检查通过 ✓"

# 赋予执行权限
log_info "设置脚本执行权限..."
chmod +x src/main.sh
log_success "权限设置完成 ✓"

# 创建配置文件
if [ ! -f "config/config.yaml" ]; then
    log_info "创建配置文件..."
    cp config/config.example config/config.yaml
    log_success "配置文件已创建: config/config.yaml"
else
    log_warning "配置文件已存在，跳过创建"
fi

# 创建响应目录
log_info "创建响应保存目录..."
mkdir -p responses
log_success "目录创建完成 ✓"

# 完成安装
echo ""
log_success "安装完成！"
echo ""
echo "=========================================="
echo "  后续步骤"
echo "=========================================="
echo ""
echo "1. 编辑配置文件，填写你的 API 信息："
echo "   vim config/config.yaml"
echo ""
echo "2. 运行测试："
echo "   ./src/main.sh <API_TOKEN> <KNOWLEDGE_ID> '测试问题'"
echo ""
echo "3. 查看详细文档："
echo "   cat README.md"
echo ""
echo "=========================================="
echo ""
