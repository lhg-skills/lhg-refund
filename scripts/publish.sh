#!/usr/bin/env bash
# 发布到 GitHub：老仓库改名 → 推送 main → 打 tag
# 前提：gh 已登录（gh auth login -h github.com -p https -w）
# 用法：bash scripts/publish.sh
set -euo pipefail
cd "$(dirname "$0")/.."

OLD="lhg-skills/lhg-coze-refund"
NEW_NAME="lhg-refund"
NEW="lhg-skills/${NEW_NAME}"
TAG="v2.1.0"

if ! gh auth status >/dev/null 2>&1; then
  echo "✗ gh 未登录，先跑： gh auth login -h github.com -p https -w"
  exit 1
fi

# 1) 改名（已经改过就跳过）
if gh repo view "$OLD" >/dev/null 2>&1; then
  echo "→ 改名：${OLD}  →  ${NEW_NAME}"
  gh repo rename "$NEW_NAME" --repo "$OLD" --yes
  echo "  GitHub 会自动重定向旧地址，外部链接不会断"
else
  echo "→ ${OLD} 不存在（可能已改名），跳过"
fi

git remote set-url origin "https://github.com/${NEW}.git"

# 2) 推送前确认是 fast-forward：本地 main 必须包含远端 main 的历史
git fetch -q origin main 2>/dev/null || true
if git rev-parse -q --verify origin/main >/dev/null; then
  if ! git merge-base --is-ancestor origin/main HEAD; then
    echo "✗ 不是 fast-forward，远端有你本地没有的提交，先人工确认"
    exit 1
  fi
  echo "→ fast-forward 检查通过（v1 历史已并入）"
fi

echo "→ 推送 main"
git push -u origin main

# 3) 打 tag（已存在就跳过）
if ! git rev-parse -q --verify "refs/tags/${TAG}" >/dev/null; then
  git tag -a "$TAG" -m "v2.1.0 全平台退费助手：12 平台事实库 + 三份执行手册 + 平台话术"
fi
git push origin "$TAG"

echo ""
echo "✓ 完成：https://github.com/${NEW}"
echo "  下一步：skillhub.cn 提交（仓库地址填上面这个）"
