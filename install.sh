#!/bin/bash

# Korean IME Fixer 설치 스크립트

set -e

echo "Korean IME Fixer 설치를 시작합니다..."

# 패키지 파일 확인
PACKAGE_FILE="korean-ime-fixer_1.0-1_all.deb"

if [ ! -f "$PACKAGE_FILE" ]; then
    echo "오류: $PACKAGE_FILE을 찾을 수 없습니다."
    echo "먼저 build.sh를 실행하여 패키지를 빌드하세요."
    exit 1
fi

# 현재 설치된 입력기 확인
echo "현재 입력기 설정 확인 중..."
if command -v im-config &> /dev/null; then
    echo "현재 설정: $(im-config -l 2>/dev/null | grep -E '^  .*active' || echo '없음')"
fi

# 패키지 설치
echo "패키지 설치 중..."
sudo dpkg -i "$PACKAGE_FILE"

# 의존성 해결
echo "의존성 해결 중..."
sudo apt-get install -f

# 설치 확인
if dpkg -l korean-ime-fixer &> /dev/null; then
    echo ""
    echo "✅ Korean IME Fixer가 성공적으로 설치되었습니다!"
    echo ""
    echo "⚠️  중요: 시스템을 재부팅해야 설정이 적용됩니다."
    echo ""
    echo "재부팅 후:"
    echo "  1. Ctrl+Space로 한영 전환 테스트"
    echo "  2. 문제 발생시: fcitx5-diagnose 실행"
    echo "  3. 설정 변경: fcitx5-configtool 실행"
    echo ""
    echo "지금 재부팅하시겠습니까? (y/N)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        sudo reboot
    fi
else
    echo "❌ 설치에 실패했습니다."
    exit 1
fi
