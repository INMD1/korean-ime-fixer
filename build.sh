#!/bin/bash

# Korean IME Fixer 패키지 빌드 스크립트

set -e

echo "Korean IME Fixer 패키지 빌드를 시작합니다..."


# 필요한 의존성 확인
echo "의존성 확인 중..."
if ! command -v dpkg-buildpackage &> /dev/null; then
    echo "오류: dpkg-buildpackage가 설치되지 않았습니다."
    echo "다음 명령으로 설치하세요: sudo apt install build-essential devscripts"
    exit 1
fi

cd src/

# 빌드 실행
dpkg-buildpackage -us -uc -b

cd ..

# 결과 확인
if [ -f "korean-ime-fixer_1.0-1_all.deb" ]; then
    echo ""
    echo "✅ 패키지 빌드가 완료되었습니다!"
    echo ""
    echo "생성된 파일들:"
    ls -la korean-ime-fixer_1.0-1*
    echo ""
    echo "설치 방법:"
    echo "  sudo dpkg -i korean-ime-fixer_1.0-1_all.deb"
    echo "  sudo apt-get install -f  # 의존성 해결 (필요시)"
    echo ""
    echo "설치 후 시스템을 재부팅하세요."
else
    echo "❌ 패키지 빌드에 실패했습니다."
    exit 1
fi
