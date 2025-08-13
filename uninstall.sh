#!/bin/bash

# Korean IME Fixer 제거 스크립트

set -e

echo "Korean IME Fixer 제거를 시작합니다..."

# 설치 여부 확인
if ! dpkg -l korean-ime-fixer &> /dev/null; then
    echo "Korean IME Fixer가 설치되어 있지 않습니다."
    exit 0
fi

# 제거 확인
echo "Korean IME Fixer를 완전히 제거하시겠습니까? (y/N)"
read -r response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
    echo "제거가 취소되었습니다."
    exit 0
fi

# 패키지 제거 (설정 파일 포함)
echo "패키지 제거 중..."
sudo apt purge korean-ime-fixer

# 자동 제거
sudo apt autoremove

echo ""
echo "✅ Korean IME Fixer가 완전히 제거되었습니다."
echo ""
echo "⚠️  시스템을 재부팅하여 변경사항을 완전히 적용하세요."
echo ""
echo "지금 재부팅하시겠습니까? (y/N)"
read -r response
if [[ "$response" =~ ^[Yy]$ ]]; then
    sudo reboot
fi
