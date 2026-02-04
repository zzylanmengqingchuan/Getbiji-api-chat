# Get 笔记知识库问答 Skill

<div align="center">

**🚀 通过 Get 笔记 API 进行知识库智能问答**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/yourusername/get-note-qa-skill)

</div>

---

## 📖 简介

这是一个开源的 Bash Skill，用于调用 **Get 笔记 OpenAPI** 进行知识库智能问答。你可以通过命令行直接查询你的 Get 笔记知识库，获取相关的笔记内容。

### ✨ 主要特性

- 🔍 **智能召回**：基于语义搜索找到相关笔记
- 🎯 **精确查询**：支持指定知识库 ID 进行精准搜索
- 📊 **结果数量可控**：可自定义返回结果数量（1-50 条）
- 💾 **自动保存**：API 响应自动保存为 JSON 文件
- 🎨 **格式化输出**：友好的命令行输出格式
- 🔒 **安全配置**：API Token 通过配置文件管理，不硬编码

---

## 📋 系统要求

- **操作系统**：Linux / macOS / Windows (WSL)
- **依赖工具**：
  - `bash` 4.0+
  - `curl`
  - `jq` (JSON 处理工具)

### 安装依赖

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install curl jq
```

**macOS:**
```bash
brew install curl jq
```

**Windows (WSL):**
```bash
sudo apt-get update
sudo apt-get install curl jq
```

---

## 🚀 快速开始

### 1️⃣ 获取 API Token 和知识库 ID

1. 登录 [Get 笔记 Web 版](https://www.getnote.com/)
2. 进入你的知识库
3. 点击顶部 **"API 设置"** 按钮
4. 复制 **API Token** 和 **知识库 ID**

### 2️⃣ 安装 Skill

```bash
# 克隆仓库
git clone https://github.com/yourusername/get-note-qa-skill.git
cd get-note-qa-skill

# 赋予执行权限
chmod +x src/main.sh
```

### 3️⃣ 配置

```bash
# 复制配置示例文件
cp config/config.example config/config.yaml

# 编辑配置文件，填写你的 API Token 和知识库 ID
vim config/config.yaml
```

### 4️⃣ 使用

```bash
# 基本用法
./src/main.sh \
  "<你的API_TOKEN>" \
  "<你的知识库_ID>" \
  "五代十国历史"

# 指定返回结果数量（默认 10 条）
./src/main.sh \
  "<你的API_TOKEN>" \
  "<你的知识库_ID>" \
  "最近的学习笔记" \
  20
```

---

## 📖 使用说明

### 命令行参数

```bash
./src/main.sh <API_TOKEN> <KNOWLEDGE_BASE_ID> <QUESTION> [TOP_K]
```

| 参数 | 说明 | 必填 | 示例 |
|------|------|------|------|
| `API_TOKEN` | Get 笔记 API Token | ✅ | `wc5VlPMwQkssAms...` |
| `KNOWLEDGE_BASE_ID` | 知识库 ID | ✅ | `rYMRBRP0` |
| `QUESTION` | 要问的问题 | ✅ | `"五代十国历史"` |
| `TOP_K` | 返回结果数量 | ❌ | `20` (默认 10) |

### 使用示例

**示例 1：查询历史笔记**
```bash
./src/main.sh \
  "wc5VlPMwQkssAms+T6SdFskhi21TS3BXkVz3wuEyb+Q2zMlSol+mFw6g3kC1MA3OZDhOKpC8GA4aTPIQ+eKvXu2recfm/9uLFpPw" \
  "rYMRBRP0" \
  "五代十国历史"
```

**示例 2：查询最新笔记（返回 30 条）**
```bash
./src/main.sh \
  "your_token" \
  "rYMRBRP0" \
  "最近的学习笔记" \
  30
```

**示例 3：搜索特定主题**
```bash
./src/main.sh \
  "your_token" \
  "rYMRBRP0" \
  "赵匡胤 陈桥兵变"
```

---

## 📂 项目结构

```
get-note-qa-skill/
├── skill.yaml              # Skill 配置文件
├── README.md               # 使用文档（本文件）
├── LICENSE                 # MIT 许可证
├── src/
│   └── main.sh            # 主脚本（API 调用逻辑）
├── config/
│   ├── config.example     # 配置示例文件
│   └── config.yaml        # 你的配置文件（需自行创建）
└── responses/              # API 响应保存目录（自动创建）
    └── getnote_20260204_142853.json
```

---

## ⚙️ 配置说明

编辑 `config/config.yaml`：

```yaml
# Get 笔记 API Token
GETNOTE_API_TOKEN="your_api_token_here"

# 知识库 ID
KNOWLEDGE_BASE_ID="your_knowledge_base_id_here"

# 默认返回结果数量（可选）
DEFAULT_TOP_K=10

# API 基础 URL（一般不需要修改）
API_BASE_URL="https://open-api.biji.com/getnote/openapi"
```

---

## 📤 输出格式

### 命令行输出

```
[INFO] 正在调用 Get 笔记 API...
[INFO] 知识库 ID: rYMRBRP0
[INFO] 问题: 五代十国历史
[SUCCESS] API 调用成功！
[INFO] 找到 15 条相关笔记

==========================================
               相关笔记
==========================================

📌 标题: 五代十国深度解析：乱世中的政权更迭与历史影响
   相关度: 0.04977344860541247
   笔记ID: xVYGLjyIqwDagS6cGMhSnaYya2nYy7gmoorupAe2aDA=
   内容摘要: 📜 历史背景与核心特征。五代十国的定义：唐朝灭亡后...

📌 标题: 《太平年》剧集深度解析
   相关度: 0.025908020914060952
   笔记ID: FrtQDbhlSBv77OWlMgCxiBLv0B9Cmx0sO93BlB3ErnQ=
   内容摘要: 📽️ 剧集背景与核心价值（引言）...
```

### JSON 文件

API 响应会自动保存到 `responses/` 目录：

```json
{
  "h": {
    "c": 0,
    "e": "",
    "s": 1770107578,
    "t": 529
  },
  "c": {
    "data": [
      {
        "id": "note_id_here",
        "title": "笔记标题",
        "content": "笔记内容...",
        "score": 0.95,
        "type": "NOTE"
      }
    ]
  }
}
```

---

## 🔧 高级用法

### 批量查询

创建一个脚本进行多次查询：

```bash
#!/bin/bash

TOKEN="your_token"
KB_ID="rYMRBRP0"

questions=("五代十国" "赵匡胤" "陈桥兵变" "钱弘俶")

for q in "${questions[@]}"; do
  echo "查询: $q"
  ./src/main.sh "$TOKEN" "$KB_ID" "$q" 10
  echo "---"
  sleep 2
done
```

### 导出所有笔记

使用不同的关键词尽可能多地获取笔记：

```bash
keywords=("历史" "政治" "军事" "经济" "文化" "人物")

for kw in "${keywords[@]}"; do
  ./src/main.sh "$TOKEN" "$KB_ID" "$kw" 50
done
```

---

## 🐛 故障排查

### 问题 1：API 返回错误 21102

**原因**：知识库 ID 不正确或未指定

**解决**：
- 检查 `KNOWLEDGE_BASE_ID` 是否正确
- 确认笔记确实在指定的知识库中

### 问题 2：找不到相关笔记

**原因**：
- 问题与知识库内容相关性太低
- 知识库中没有相关笔记

**解决**：
- 尝试更换问题关键词
- 使用更宽泛的搜索词

### 问题 3：jq 命令未找到

**解决**：
```bash
# Ubuntu/Debian
sudo apt-get install jq

# macOS
brew install jq
```

---

## 📚 API 参考

### Get 笔记 OpenAPI 文档

- **API Base URL**: `https://open-api.biji.com/getnote/openapi`
- **接口文档**: [Get 笔记知识库 OpenAPI](https://dedao.feishu.cn/wiki/QfMcwcoHqic5urkTBQKcAPIWnJe)

### 主要接口

**知识库召回接口**

```
POST /knowledge/search/recall
```

**请求参数**：

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `question` | string | ✅ | 问题 |
| `topic_id` | string | ❌ | 知识库 ID |
| `topic_ids` | array | ❌ | 知识库 ID 列表 |
| `top_k` | int | ❌ | 召回结果数量（1-50） |
| `intent_rewrite` | bool | ❌ | 意图重写 |
| `select_matrix` | bool | ❌ | 结果选择 |

---

## 🤝 贡献

欢迎贡献代码、报告问题或提出改进建议！

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

---

## 📝 许可证

本项目采用 **MIT License** 开源许可证。详见 [LICENSE](LICENSE) 文件。

---

## 🙏 致谢

- [Get 笔记](https://www.getnote.com/) - 提供的 OpenAPI 服务
- [Claudian](https://github.com/yourusername) - Skill 开发者

---

## 📮 联系方式

- **Issues**: [GitHub Issues](https://github.com/yourusername/get-note-qa-skill/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/get-note-qa-skill/discussions)

---

<div align="center">

**⭐ 如果这个项目对你有帮助，请给个 Star！**

Made with ❤️ by Claudian

</div>
