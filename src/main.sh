#!/bin/bash

###############################################################################
# Get 笔记知识库问答 Skill
# 功能：通过 API 调用 Get 笔记知识库进行智能问答
# 作者：Claudian
# 版本：1.0.0
# 许可：MIT License
###############################################################################

set -e

# 脚本目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

###############################################################################
# 工具函数
###############################################################################

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1" >&2
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1" >&2
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1" >&2
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

###############################################################################
# API 调用函数
###############################################################################

# API 配置
API_BASE_URL="https://open-api.biji.com/getnote/openapi"

# 调用知识库召回接口
call_recall_api() {
    local api_token="$1"
    local topic_id="$2"
    local question="$3"
    local top_k="${4:-10}"

    log_info "正在调用 Get 笔记 API..."
    log_info "知识库 ID: $topic_id"
    log_info "问题: $question" >&2  # 输出到 stderr，避免混入 JSON

    local response=$(curl -s -X POST "${API_BASE_URL}/knowledge/search/recall" \
        -H 'Content-Type: application/json' \
        -H "Authorization: Bearer ${api_token}" \
        -H 'X-OpenAI-Version: 1' \
        -d "{
            \"question\": \"${question}\",
            \"topic_id\": \"${topic_id}\",
            \"top_k\": ${top_k},
            \"intent_rewrite\": false,
            \"select_matrix\": false
        }")

    echo "$response"
}

# 解析 API 响应
parse_response() {
    local response="$1"

    # 检查是否是有效的 JSON
    if ! echo "$response" | jq -e '.' > /dev/null 2>&1; then
        log_error "API 返回的不是有效的 JSON 格式"
        log_error "原始响应: $response"
        return 1
    fi

    # 检查错误代码
    local code=$(echo "$response" | jq -r '.h.c // empty')
    if [ -n "$code" ] && [ "$code" != "0" ]; then
        local error_msg=$(echo "$response" | jq -r '.h.e // "未知错误"')
        log_error "API 返回错误 (代码: $code): $error_msg"
        return 1
    fi

    # 检查是否有数据返回
    local data=$(echo "$response" | jq -r '.c.data // empty')
    if [ "$data" = "null" ] || [ -z "$data" ]; then
        log_warning "未找到相关笔记"
        return 0
    fi

    # 成功
    return 0
}

# 格式化输出结果
format_output() {
    local response="$1"

    log_success "API 调用成功！"

    # 提取笔记数量
    local count=$(echo "$response" | jq -r '.c.data | length' 2>/dev/null || echo "0")
    log_info "找到 ${count} 条相关笔记"

    echo ""
    echo "=========================================="
    echo "               相关笔记                   "
    echo "=========================================="
    echo ""

    # 遍历每条笔记
    echo "$response" | jq -r '.c.data[] | @json' | while IFS= read -r note; do
        local title=$(echo "$note" | jq -r '.title // "无标题"')
        local content=$(echo "$note" | jq -r '.content // ""' | head -c 300)
        local score=$(echo "$note" | jq -r '.score // "0"')
        local note_id=$(echo "$note" | jq -r '.id // "unknown"')

        echo "📌 标题: $title"
        echo "   相关度: $score"
        echo "   笔记ID: $note_id"
        echo "   内容摘要: ${content}..."
        echo ""
    done
}

# 保存原始 JSON 到文件
save_raw_response() {
    local response="$1"
    local output_file="${2:-getnote_response.json}"

    echo "$response" | jq '.' > "$output_file" 2>/dev/null || echo "$response" > "$output_file"
    log_info "完整响应已保存到: $output_file"
}

###############################################################################
# 主函数
###############################################################################

main() {
    # 参数检查
    if [ $# -lt 3 ]; then
        log_error "参数不足"
        echo ""
        echo "用法: $0 <API_TOKEN> <KNOWLEDGE_BASE_ID> <QUESTION> [TOP_K]"
        echo ""
        echo "参数说明:"
        echo "  API_TOKEN           - Get 笔记 API Token"
        echo "  KNOWLEDGE_BASE_ID   - 知识库 ID"
        echo "  QUESTION            - 问题内容"
        echo "  TOP_K               - 返回结果数量（可选，默认 10）"
        echo ""
        echo "示例:"
        echo "  $0 \"your_token_here\" \"rYMRBRP0\" \"五代十国历史\" 20"
        exit 1
    fi

    local api_token="$1"
    local topic_id="$2"
    local question="$3"
    local top_k="${4:-10}"

    # 调用 API
    local response=$(call_recall_api "$api_token" "$topic_id" "$question" "$top_k")

    # 解析响应
    if ! parse_response "$response"; then
        exit 1
    fi

    # 保存原始响应
    save_raw_response "$response" "getnote_$(date +%Y%m%d_%H%M%S).json"

    # 格式化输出
    format_output "$response"
}

# 执行主函数
main "$@"
