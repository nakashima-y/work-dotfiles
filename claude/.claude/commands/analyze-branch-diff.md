---
description: ブランチとの差分を安全に分析するコマンド（マージなし）| 引数: ブランチ名
---

# 安全なブランチ差分分析

## 0. 対象ブランチの決定

以下の条件に従って対象ブランチを決定してください：

**引数が指定されている場合：**
```bash
TARGET_BRANCH=$ARGUMENTS
```

**引数が指定されていない場合：**
```bash
TARGET_BRANCH=$(git remote show origin | grep "HEAD branch" | cut -d' ' -f5)
```

## 1. 最新情報の取得（マージはしない）

リモートから最新情報を取得してください（ローカルブランチは変更しません）：

```bash
git fetch
```

## 2. 現在の状況確認

現在の状況を確認するため、以下の情報を表示してください：

```bash
echo "現在のブランチ: $(git branch --show-current)"
echo "比較対象ブランチ: $TARGET_BRANCH"
echo "マージ状況: ローカルブランチは変更されていません"

echo -e "\n=== ステージング状況 ==="
if git diff --cached --quiet; then
    echo "ステージング: 変更なし"
else
    echo "ステージング: $(git diff --cached --name-only | wc -l) ファイルがステージング済み"
    git diff --cached --name-only
fi

echo -e "\n=== ワーキングディレクトリ状況 ==="
if git diff --quiet; then
    echo "ワーキングディレクトリ: 変更なし"
else
    echo "ワーキングディレクトリ: $(git diff --name-only | wc -l) ファイルに変更あり"
fi
```

## 3. 差分の取得と分析

対象ブランチとの差分を**安全に**取得し、分析してください：

```bash
git diff origin/$TARGET_BRANCH
```

上記のgit diffの結果を分析して、以下の観点から説明してください：

### 分析項目
- **全体的な仕様の変更概要**
  - どのような機能追加・修正が行われたか

- **各ファイルの変更内容**
  - 各ファイルでの主な変更点
