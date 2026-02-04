# Get 笔记知识库问答 Skill - 完整使用指南

## 📚 目录

1. [什么是 Skill？](#什么是-skill)
2. [安装 Skill](#安装-skill)
3. [使用 Skill](#使用-skill)
4. [Skill 工作原理](#skill-工作原理)
5. [有 Skill vs 无 Skill 对比](#有-skill-vs-无-skill-对比)
6. [常见问题](#常见问题)

---

## 什么是 Skill？

### Skill 的定义

**Skill（技能）** 是一个可重用的功能模块，类似于：

- **浏览器插件**：为浏览器添加新功能
- **VS Code 扩展**：为编辑器增加新能力
- **手机 App**：为系统提供特定服务

### 这个 Skill 的作用

**Get 笔记知识库问答 Skill** 的作用是：

```
你提出问题
    ↓
Skill 自动调用 Get 笔记 API
    ↓
从你的知识库中智能检索相关笔记
    ↓
返回格式化的答案和笔记内容
```

**简单来说**：Skill 让你可以用自然语言查询你的 Get 笔记知识库，就像和一个"超级助手"对话一样。

---

## 安装 Skill

### 方式 1: 直接下载（推荐）

```bash
# 1. 克隆仓库
git clone https://github.com/zzylanmengqingchuan/Getbiji-api-chat.git
cd Getbiji-api-chat

# 2. 赋予执行权限
chmod +x src/main.sh install.sh

# 3. （可选）运行安装脚本
./install.sh
```

### 方式 2: 下载压缩包

1. 访问：https://github.com/zzylanmengqingchuan/Getbiji-api-chat
2. 点击绿色按钮 **"Code"** → **"Download ZIP"**
3. 解压到本地目录
4. 进入目录并赋予执行权限：
   ```bash
   cd Getbiji-api-chat
   chmod +x src/main.sh
   ```

### 系统要求

**必需工具：**
- `bash` (命令行解释器)
- `curl` (HTTP 请求工具)
- `jq` (JSON 处理工具)

**安装依赖：**
```bash
# Ubuntu/Debian
sudo apt-get install curl jq

# macOS
brew install curl jq

# Windows (WSL)
sudo apt-get install curl jq
```

---

## 使用 Skill

### 1️⃣ 首次使用：配置 API 信息

#### 获取 Get 笔记 API 凭证

1. 登录 [Get 笔记](https://www.getnote.com/)
2. 进入你想查询的知识库
3. 点击顶部 **"API 设置"** 按钮
4. 复制以下信息：
   - **API Token**（类似：`wc5VlPMwQkss...`）
   - **知识库 ID**（类似：`rYMRBRP0`）

#### 方式 A：命令行直接传入（最简单）

```bash
./src/main.sh \
  "<你的API_TOKEN>" \
  "<你的知识库_ID>" \
  "你的问题"
```

**示例：**
```bash
./src/main.sh \
  "wc5VlPMwQkssAms+T6SdFskhi21TS3BXkVz3wuEyb+Q2zMlSol+mFw6g3kC1MA3OZDhOKpC8GA4aTPIQ+eKvXu2recfm/9uLFpPw" \
  "rYMRBRP0" \
  "五代十国历史"
```

#### 方式 B：使用配置文件（推荐）

```bash
# 1. 复制配置示例
cp config/config.example config/config.yaml

# 2. 编辑配置文件
vim config/config.yaml
```

填写你的信息：
```yaml
GETNOTE_API_TOKEN="你的API_TOKEN"
KNOWLEDGE_BASE_ID="你的知识库_ID"
DEFAULT_TOP_K=10
```

然后创建一个包装脚本 `my-query.sh`：
```bash
#!/bin/bash
source config/config.yaml
./src/main.sh "$GETNOTE_API_TOKEN" "$KNOWLEDGE_BASE_ID" "$1" ${DEFAULT_TOP_K}
```

使用：
```bash
./my-query.sh "五代十国历史"
```

---

### 2️⃣ 日常使用：查询知识库

#### 基本查询

```bash
./src/main.sh \
  "<TOKEN>" \
  "<KB_ID>" \
  "你的问题"
```

#### 查询示例

**示例 1：历史主题**
```bash
./src/main.sh "$TOKEN" "$KB_ID" "五代十国"
```

**示例 2：人物查询**
```bash
./src/main.sh "$TOKEN" "$KB_ID" "赵匡胤"
```

**示例 3：最近笔记**
```bash
./src/main.sh "$TOKEN" "$KB_ID" "最近的学习笔记"
```

#### 调整返回数量

```bash
# 返回 20 条结果
./src/main.sh "$TOKEN" "$KB_ID" "问题" 20

# 返回 50 条结果（最大值）
./src/main.sh "$TOKEN" "$KB_ID" "问题" 50
```

---

### 3️⃣ 查看结果

#### 命令行输出

```
==========================================
               相关笔记
==========================================

📌 标题: 《太平年》背后的五代十国历史密码
   相关度: 0.8127187235801289
   笔记ID: or10J2QeQqGyvpSlyaZ3naKGXMFERs2wSsGVeO9j2A8=
   内容摘要: 🏯 核心背景：五代十国的乱世图景...
```

#### JSON 文件

自动保存在当前目录，文件名格式：`getnote_YYYYMMDD_HHMMSS.json`

```json
{
  "h": {"c": 0, "e": "", "s": 1770107578, "t": 529},
  "c": {
    "data": [
      {
        "id": "note_id",
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

## Skill 工作原理

### 工作流程

```
┌─────────────────┐
│ 1. 用户输入问题  │
└────────┬────────┘
         │
         ▼
┌─────────────────────────────┐
│ 2. Skill 接收参数            │
│    - API Token              │
│    - 知识库 ID               │
│    - 问题                    │
│    - 返回数量                │
└────────┬────────────────────┘
         │
         ▼
┌─────────────────────────────┐
│ 3. 调用 Get 笔记 API         │
│    POST /knowledge/search    │
└────────┬────────────────────┘
         │
         ▼
┌─────────────────────────────┐
│ 4. API 返回 JSON 数据        │
│    - 相关笔记列表            │
│    - 标题、内容、相关度       │
└────────┬────────────────────┘
         │
         ▼
┌─────────────────────────────┐
│ 5. Skill 解析并格式化输出     │
│    - 命令行友好显示          │
│    - 保存 JSON 文件          │
└─────────────────────────────┘
```

### 技术细节

**使用的工具：**
- `curl`：发送 HTTP POST 请求到 Get 笔记 API
- `jq`：解析 JSON 响应数据
- `bash`：流程控制和逻辑处理

**API 调用示例：**
```bash
curl -X POST "https://open-api.biji.com/getnote/openapi/knowledge/search/recall" \
  -H "Authorization: Bearer <TOKEN>" \
  -H "Content-Type: application/json" \
  -d '{
    "question": "你的问题",
    "topic_id": "知识库ID",
    "top_k": 10
  }'
```

---

## 有 Skill vs 无 Skill 对比

### 🔴 没有 Skill 的情况

**查询 Get 笔记知识库你需要：**

1. 打开浏览器
2. 登录 Get 笔记网站
3. 进入知识库
4. 使用搜索功能手动查找
5. 逐条阅读笔记
6. 手动复制需要的内容

**痛点：**
- ❌ 需要手动操作，步骤繁琐
- ❌ 无法批量查询
- ❌ 无法集成到自动化流程
- ❌ 需要打开浏览器，依赖网络环境
- ❌ 无法获取原始 JSON 数据
- ❌ 难以进行二次开发

**实际场景：**
```bash
# 你想查询 10 个不同的主题
# 没有 Skill：需要重复打开浏览器 10 次
for topic in "历史" "政治" "军事" "经济"; do
  # 手动打开浏览器
  # 手动搜索
  # 手动复制结果
  # 耗时：每个主题 2-3 分钟
done
# 总耗时：20-30 分钟
```

---

### 🟢 有 Skill 的情况

**查询 Get 笔记知识库你只需：**

```bash
./src/main.sh "$TOKEN" "$KB_ID" "你的问题"
```

**优势：**
- ✅ 命令行一行搞定
- ✅ 支持批量查询
- ✅ 可集成到自动化脚本
- ✅ 无需打开浏览器
- ✅ 自动保存 JSON 数据
- ✅ 易于二次开发

**实际场景：**
```bash
# 查询 10 个不同的主题
for topic in "历史" "政治" "军事" "经济"; do
  ./src/main.sh "$TOKEN" "$KB_ID" "$topic" 10
done
# 总耗时：30 秒（自动完成）
```

---

### 📊 功能对比表

| 功能需求 | 没有 Skill | 有 Skill |
|---------|-----------|---------|
| 单次查询 | 🔴 需要打开浏览器，手动搜索 | 🟢 命令行一行完成 |
| 批量查询 | 🔴 需要重复操作 10+ 次 | 🟢 循环脚本自动完成 |
| 获取原始数据 | 🔴 无法获取 JSON | 🟢 自动保存 JSON 文件 |
| 集成到工作流 | 🔴 需要手动复制粘贴 | 🟢 可直接集成到脚本 |
| 自动化处理 | 🔴 无法自动化 | 🟢 完全支持自动化 |
| 二次开发 | 🔴 数据难以复用 | 🟢 JSON 格式易于处理 |
| 查询速度 | 🔴 每次查询 2-3 分钟 | 🟢 每次查询 2-3 秒 |
| 离线查看 | 🔴 必须在线 | 🟢 JSON 文件可离线查看 |

---

### 🎯 实际使用场景对比

#### 场景 1：批量导出笔记

**没有 Skill：**
```
1. 打开浏览器
2. 登录 Get 笔记
3. 搜索"历史"
4. 手动复制每条笔记（20 条）
5. 粘贴到文档
6. 重复 2-5 步 10 次（不同关键词）

总耗时：2-3 小时
```

**有 Skill：**
```bash
#!/bin/bash
keywords=("历史" "政治" "军事" "经济" "文化")
for kw in "${keywords[@]}"; do
  ./src/main.sh "$TOKEN" "$KB_ID" "$kw" 50
done

总耗时：30 秒
```

---

#### 场景 2：集成到 Obsidian

**没有 Skill：**
```
1. 浏览器打开 Get 笔记
2. 搜索笔记
3. 手动复制
4. 切换到 Obsidian
5. 粘贴并格式化

每次查询耗时：2-3 分钟
```

**有 Skill：**
```bash
# 创建脚本 export_to_obsidian.sh
#!/bin/bash
result=$(./src/main.sh "$TOKEN" "$KB_ID" "$1" 10)
# 自动转换为 Markdown 格式
# 自动保存到 Obsidian 仓库

每次查询耗时：3 秒（自动完成）
```

---

#### 场景 3：定时备份笔记

**没有 Skill：**
```
❌ 无法实现定时备份
```

**有 Skill：**
```bash
# 添加到 crontab
# 每天凌晨 2 点备份知识库
0 2 * * * /path/to/skill/backup_notes.sh
```

---

### 💡 Skill 的核心价值

#### 1. **效率提升**
```
手动查询：2-3 分钟/次
Skill 查询：2-3 秒/次

效率提升：60 倍
```

#### 2. **自动化能力**
```bash
# 批量查询 100 个主题
for i in {1..100}; do
  ./src/main.sh "$TOKEN" "$KB_ID" "主题$i" 10
done
# 5 分钟内完成（手动需要 3-5 小时）
```

#### 3. **数据可复用**
```bash
# JSON 数据可以：
# - 导入到数据库
# - 进行数据分析
# - 集成到其他应用
# - 训练 AI 模型
```

#### 4. **工作流集成**
```bash
# 可以和其他工具组合
./src/main.sh "$TOKEN" "$KB_ID" "问题" 10 \
  | jq '.c.data[].title' \
  | grep "关键词"
```

---

## 常见问题

### Q1: Skill 是如何触发的？

**A:** Skill 不是"自动触发"的，而是**主动调用**的：

```bash
# 你主动运行这个命令
./src/main.sh "$TOKEN" "$KB_ID" "你的问题"
```

**适用场景：**
- ✅ 你想查询某个主题时
- ✅ 你需要批量导出笔记时
- ✅ 你想集成到自动化脚本时

**不适用场景：**
- ❌ 被动自动触发（这不是设计目标）
- ❌ 后台持续监听（这不是工作方式）

---

### Q2: 什么时候需要提供 API Token 和知识库 ID？

**A:** 有两种方式：

#### 方式 A：每次查询时提供（推荐新手）

```bash
./src/main.sh "<TOKEN>" "<KB_ID>" "问题"
```

**适用情况：**
- 你刚开始使用
- 你有多个知识库
- 你不想管理配置文件

#### 方式 B：配置文件中设置（推荐高级用户）

```bash
# 1. 编辑配置
vim config/config.yaml

# 2. 填写凭证
GETNOTE_API_TOKEN="你的TOKEN"
KNOWLEDGE_BASE_ID="你的KB_ID"

# 3. 创建包装脚本
source config/config.yaml
./src/main.sh "$GETNOTE_API_TOKEN" "$KNOWLEDGE_BASE_ID" "$1"
```

**适用情况：**
- 你频繁使用 Skill
- 你只有一个主知识库
- 你想简化命令

---

### Q3: 安装后如何看到效果？

**步骤 1: 安装**
```bash
git clone https://github.com/zzylanmengqingchuan/Getbiji-api-chat.git
cd Getbiji-api-chat
chmod +x src/main.sh
```

**步骤 2: 获取凭证**
1. 访问 https://www.getnote.com/
2. 进入知识库 → API 设置
3. 复制 API Token 和知识库 ID

**步骤 3: 运行测试**
```bash
./src/main.sh \
  "你的API_TOKEN" \
  "你的知识库_ID" \
  "测试问题" \
  5
```

**预期输出：**
```
==========================================
               相关笔记
==========================================

📌 标题: 笔记标题
   相关度: 0.95
   笔记ID: xxxxx
   内容摘要: 笔记内容摘要...
```

**同时会生成：**
- JSON 文件：`getnote_YYYYMMDD_HHMMSS.json`

---

### Q4: Skill 安全吗？

**A:** 是的，Skill 本身是安全的：

1. **代码开源**：你可以审查每一行代码
2. **本地运行**：所有操作都在你的电脑上
3. **透明通信**：只和 Get 笔记官方 API 通信
4. **MIT 许可**：自由使用、修改、分享

**安全建议：**
- ❌ 不要将 `config/config.yaml` 提交到 Git
- ✅ 使用 `config/config.example` 作为模板
- ✅ 定期更换 API Token

---

### Q5: Skill 可以用于哪些场景？

**适用场景：**
- ✅ 学习笔记检索
- ✅ 知识库问答
- ✅ 批量导出笔记
- ✅ 数据分析
- ✅ 自动化备份
- ✅ 集成到工作流

**不适用场景：**
- ❌ 实时监听（不是设计目标）
- ❌ 自动触发（需要手动调用）
- ❌ 图形界面（纯命令行工具）

---

## 总结

### 🎯 核心要点

1. **Skill 是什么**：一个命令行工具，帮你查询 Get 笔记知识库
2. **如何使用**：`./src/main.sh <TOKEN> <KB_ID> "问题"`
3. **何时提供凭证**：每次查询时提供，或配置在文件中
4. **如何看效果**：运行命令后立即看到格式化结果

### 🚀 快速开始

```bash
# 1. 克隆
git clone https://github.com/zzylanmengqingchuan/Getbiji-api-chat.git
cd Getbiji-api-chat

# 2. 赋予权限
chmod +x src/main.sh

# 3. 运行
./src/main.sh "<TOKEN>" "<KB_ID>" "测试问题"
```

### 💪 相比手动查询的优势

| 方面 | 手动查询 | Skill 查询 |
|------|---------|-----------|
| 速度 | 2-3 分钟 | 2-3 秒 |
| 批量 | 不可能 | 轻松实现 |
| 自动化 | 困难 | 完全支持 |
| 数据复用 | 困难 | JSON 格式 |

**效率提升：60 倍！**

---

**需要帮助？**
- 📖 查看 [README.md](README.md)
- 🚀 查看 [QUICKSTART.md](QUICKSTART.md)
- 🐛 [提交 Issue](https://github.com/zzylanmengqingchuan/Getbiji-api-chat/issues)

---

<div align="center">

**⭐ 觉得有用？给个 Star！**

Made with ❤️ by Claudian

</div>
