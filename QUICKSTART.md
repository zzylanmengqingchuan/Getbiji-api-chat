# Get 笔记知识库问答 Skill - 快速开始指南

## 🚀 5 分钟快速上手

### 步骤 1: 安装依赖

```bash
# Ubuntu/Debian
sudo apt-get install curl jq

# macOS
brew install curl jq
```

### 步骤 2: 下载 Skill

```bash
git clone https://github.com/yourusername/get-note-qa-skill.git
cd get-note-qa-skill
chmod +x src/main.sh install.sh
```

### 步骤 3: 获取 API 凭证

1. 访问 [Get 笔记](https://www.getnote.com/)
2. 进入你的知识库
3. 点击 **"API 设置"**
4. 复制 **API Token** 和 **知识库 ID**

### 步骤 4: 运行测试

```bash
./src/main.sh \
  "<你的API_TOKEN>" \
  "<你的知识库_ID>" \
  "测试问题" \
  5
```

**示例：**
```bash
./src/main.sh \
  "wc5VlPMwQkssAms+T6SdFskhi21TS3BXkVz3wuEyb+Q2zMlSol+mFw6g3kC1MA3OZDhOKpC8GA4aTPIQ+eKvXu2recfm/9uLFpPw" \
  "rYMRBRP0" \
  "五代十国历史" \
  10
```

### 步骤 5: 查看结果

✅ **命令行输出**：格式化的笔记列表
✅ **JSON 文件**：保存在当前目录，文件名格式 `getnote_YYYYMMDD_HHMMSS.json`

---

## 📖 常用命令

### 查询不同主题

```bash
# 历史主题
./src/main.sh "$TOKEN" "$KB_ID" "历史"

# 人物查询
./src/main.sh "$TOKEN" "$KB_ID" "赵匡胤"

# 最近笔记
./src/main.sh "$TOKEN" "$KB_ID" "最近的学习笔记"
```

### 调整返回数量

```bash
# 返回 20 条结果
./src/main.sh "$TOKEN" "$KB_ID" "问题" 20

# 返回 50 条结果（最大值）
./src/main.sh "$TOKEN" "$KB_ID" "问题" 50
```

### 批量查询

```bash
#!/bin/bash

TOKEN="your_token"
KB_ID="rYMRBRP0"

for topic in "历史" "政治" "军事" "经济"; do
  echo "查询: $topic"
  ./src/main.sh "$TOKEN" "$KB_ID" "$topic" 10
  echo "---"
  sleep 2
done
```

---

## 🔧 配置文件（可选）

创建 `config/config.yaml`：

```bash
cp config/config.example config/config.yaml
vim config/config.yaml
```

填写配置：
```yaml
GETNOTE_API_TOKEN="your_api_token_here"
KNOWLEDGE_BASE_ID="your_knowledge_base_id_here"
DEFAULT_TOP_K=10
```

---

## 📂 项目结构

```
get-note-qa-skill/
├── src/
│   └── main.sh          # 主脚本
├── config/
│   ├── config.example   # 配置示例
│   └── config.yaml      # 你的配置（自行创建）
├── skill.yaml           # Skill 元数据
├── README.md            # 完整文档
├── LICENSE              # MIT 许可证
└── install.sh           # 安装脚本
```

---

## ❓ 常见问题

### Q: 如何获取 API Token？
A: Get 笔记 Web 版 → 知识库 → API 设置

### Q: 找不到相关笔记？
A: 尝试更换关键词或使用更宽泛的搜索词

### Q: API 返回错误 21102？
A: 检查知识库 ID 是否正确，确认笔记在指定知识库中

### Q: 如何批量导出所有笔记？
A: 使用不同关键词多次调用，合并 JSON 结果

---

## 🎯 下一步

- 📚 阅读完整文档：`cat README.md`
- 🐛 报告问题：[GitHub Issues](https://github.com/yourusername/get-note-qa-skill/issues)
- 💡 提出建议：[GitHub Discussions](https://github.com/yourusername/get-note-qa-skill/discussions)

---

## 📮 获取帮助

```bash
# 查看帮助
./src/main.sh

# 检查版本
cat skill.yaml | grep version
```

---

<div align="center">

**⭐ 觉得有用？给个 Star！**

Made with ❤️ by Claudian

</div>
