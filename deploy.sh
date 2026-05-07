#!/bin/bash
# Quick deploy script for XD Brand jersey system
# ใช้: bash deploy.sh           → deploy preview
#      bash deploy.sh prod      → deploy production

set -e

echo "🚀 XD Brand jersey - Vercel Deploy"
echo "==================================="

if ! command -v vercel &> /dev/null; then
  echo "📦 ยังไม่มี Vercel CLI กำลังติดตั้ง..."
  npm install -g vercel
fi

echo "🚢 กำลัง deploy..."
if [ "$1" == "prod" ] || [ "$1" == "--prod" ]; then
  vercel --prod
else
  vercel
fi

echo "✅ เสร็จแล้ว!"
