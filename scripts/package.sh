#!/usr/bin/env bash
# 打发布包：生成可直接上传到 SkillHub / 扣子编程 / Trae 的 zip
# 用法：bash scripts/package.sh
set -euo pipefail

cd "$(dirname "$0")/.."
VERSION=$(grep -E '^version:' manifest.yaml | head -1 | awk '{print $2}' | tr -d '"')
OUT="dist/lhg-refund-${VERSION}.zip"

mkdir -p dist
rm -f "$OUT"

zip -rq "$OUT" \
  SKILL.md manifest.yaml README.md LICENSE \
  references templates examples automation \
  -x '*.DS_Store' '*/.DS_Store'

echo "已生成：$OUT"
unzip -l "$OUT" | tail -2
