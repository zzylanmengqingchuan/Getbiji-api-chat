# Get 笔记知识库问答 Skill - 快速参考卡

<div align="center">

## 🚀 3 分钟上手

</div>

---

## 📦 安装（一行命令）

```bash
git clone https://github.com/zzylanmengqingchuan/Getbiji-api-chat.git && cd Getbiji-api-chat && chmod +x src/main.sh
```

---

## 🔑 获取凭证

1. 访问 https://www.getnote.com/
2. 进入知识库 → **API 设置**
3. 复制 **API Token** 和 **知识库 ID**

---

## 💻 使用（一行命令）

```bash
./src/main.sh "<API_TOKEN>" "<知识库_ID>" "你的问题"
```

**示例：**
```bash
./src/main.sh \
  "wc5VlPMwQkss..." \
  "rYMRBRP0" \
  "五代十国历史" \
  10
```

---

## 📊 有 Skill vs 无 Skill

| 场景 | 无 Skill | 有 Skill |
|------|---------|---------|
| 单次查询 | 打开浏览器，手动搜索（2-3分钟） | 命令行一行搞定（2-3秒） |
| 批量查询 | 重复操作 10 次（20-30分钟） | 循环脚本自动（30秒） |
| 数据导出 | 手动复制粘贴 | JSON 文件自动保存 |
| 自动化 | ❌ 不可能 | ✅ 完全支持 |

**效率提升：60 倍！**

---

## 🎯 核心问题解答

### Q1: Skill 如何触发？
**A:** 主动调用，不是自动触发
```bash
# 你想查询时主动运行
./src/main.sh "<TOKEN>" "<KB_ID>" "问题"
```

### Q2: 什么时候提供凭证？
**A:** 两种方式

**方式 A（推荐）：每次查询时提供**
```bash
./src/main.sh "<TOKEN>" "<KB_ID>" "问题"
```

**方式 B：配置文件**
```bash
cp config/config.example config/config.yaml
vim config/config.yaml  # 填写凭证
```

### Q3: 如何看效果？
**A:** 运行后立即看到

**命令行输出：**
```
==========================================
               相关笔记
==========================================

📌 标题: 笔记标题
   相关度: 0.95
   内容摘要: 笔记内容...
```

**JSON 文件：**
- 文件名：`getnote_YYYYMMDD_HHMMSS.json`
- 位置：当前目录

---

## 📚 完整文档

| 文档 | 说明 |
|------|------|
| [SKILL_GUIDE.md](SKILL_GUIDE.md) | 📖 完整使用指南 |
| [README.md](README.md) | 📄 项目说明 |
| [QUICKSTART.md](QUICKSTART.md) | 🚀 快速开始 |

---

## 🎓 使用场景

### 场景 1：学习笔记检索
```bash
./src/main.sh "$TOKEN" "$KB_ID" "历史知识点"
```

### 场景 2：批量导出
```bash
for topic in "历史" "政治" "军事"; do
  ./src/main.sh "$TOKEN" "$KB_ID" "$topic" 50
done
```

### 场景 3：定时备份
```bash
# 添加到 crontab
0 2 * * * /path/to/backup.sh
```

---

## 🔧 系统要求

```bash
# Ubuntu/Debian
sudo apt-get install curl jq

# macOS
brew install curl jq
```

---

## ✅ 核心优势

1. **速度快**：2-3 秒完成查询（vs 手动 2-3 分钟）
2. **可批量**：一次查询多个主题
3. **可自动化**：集成到工作流
4. **数据可复用**：JSON 格式易于处理
5. **完全开源**：MIT 许可，安全可控

---

## 📮 获取帮助

- 📖 详细文档：[SKILL_GUIDE.md](SKILL_GUIDE.md)
- 🐛 报告问题：[GitHub Issues](https://github.com/zzylanmengqingchuan/Getbiji-api-chat/issues)
- 💡 讨论交流：[GitHub Discussions](https://github.com/zzylanmengqingchuan/Getbiji-api-chat/discussions)

---

<div align="center">

**⭐ 觉得有用？给个 Star！**

https://github.com/zzylanmengqingchuan/Getbiji-api-chat

Made with ❤️ by Claudian

</div>
