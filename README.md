# Korean IME Fixer for Ubuntu

우분투 시스템에서 한국어 입력 문제를 해결하는 자동화된 솔루션입니다.

## 기능

- **자동 환경 감지**: GNOME, KDE, XFCE 데스크톱 환경과 Wayland/X11 세션 자동 감지
- **Fcitx5 기반**: 안정적이고 현대적인 Fcitx5 입력기 프레임워크 사용
- **시스템 통합**: systemd 환경 변수 및 im-config 시스템과 완전 통합
- **브라우저 호환성**: Chrome, Firefox 등 웹 브라우저에서의 한글 입력 문제 해결
- **완전 제거**: 패키지 제거 시 모든 설정을 깔끔하게 정리

## 시스템 요구사항

- Ubuntu 20.04 LTS 이상
- systemd (대부분의 현대적인 Ubuntu 시스템에 기본 포함)
- 권장: GNOME 데스크톱 환경

## 설치 방법

### 1. 패키지 빌드 (개발자용)

```bash
# 의존성 설치
sudo apt update
sudo apt install build-essential debhelper devscripts

# 패키지 빌드
cd korean-ime-fixer-1.0
dpkg-buildpackage -us -uc

# 빌드된 패키지 설치
cd ..
sudo apt install fcitx5 fcitx5-hangul
sudo dpkg -i korean-ime-fixer_1.0-1_all.deb
```

### 2. 직접 설치 (최종 사용자용)

```bash
# 패키지 설치
sudo apt install fcitx5 fcitx5-hangul
sudo dpkg -i korean-ime-fixer_1.0-1_all.deb

# 의존성 해결 (필요시)
sudo apt-get install -f
```

## 설치 후 설정

1. **시스템 재부팅**
   ```bash
   sudo reboot
   ```

2. **Fcitx5 설정 도구 실행** (선택사항)
   ```bash
   fcitx5-configtool
   ```

3. **한글 입력 방법 추가**
   - Input Method 탭에서 "+" 클릭
   - "Hangul" 검색 후 추가

## 사용법

- **한영 전환**: `Ctrl + Space` (기본값)
- **설정 변경**: `fcitx5-configtool` 실행
- **상태 확인**: `fcitx5-diagnose` 실행

## 지원되는 애플리케이션

### 완전 지원
- LibreOffice (모든 구성 요소)
- Gedit, Kate 등 텍스트 에디터
- Firefox 브라우저
- GNOME 기본 애플리케이션들

### 설정 필요
- **Google Chrome/Chromium**: chrome://flags에서 Wayland 관련 설정 활성화
- **Flatpak 애플리케이션**: 수동 환경 변수 설정 필요
- **Snap 애플리케이션**: 제한적 지원

## 문제 해결

### 한글 입력이 안 되는 경우

1. **시스템 재부팅 확인**
2. **Fcitx5 프로세스 확인**
   ```bash
   ps aux | grep fcitx5
   ```
3. **환경 변수 확인**
   ```bash
   echo $GTK_IM_MODULE
   echo $QT_IM_MODULE
   echo $XMODIFIERS
   ```

### Chrome에서 한글 입력이 안 되는 경우

1. **chrome://flags 설정**
   - "Preferred Ozone platform" → "Wayland" 설정
   - "Wayland text-input-v3" → "Enabled" 설정

2. **명령줄 옵션으로 실행**
   ```bash
   google-chrome --enable-wayland-ime --ozone-platform=wayland
   ```

### 진단 도구 실행

```bash
fcitx5-diagnose
```

## 제거 방법

```bash
sudo apt remove korean-ime-fixer
sudo apt purge korean-ime-fixer  # 설정 파일까지 완전 제거
sudo reboot  # 재부팅 권장
```

## 기술적 세부사항

### 구성 파일 위치

- **GNOME Wayland**: `/etc/environment.d/60-korean-ime-fixer.conf`
- **KDE Plasma**: `/etc/xdg/plasma-workspace/env/60-korean-ime-fixer.sh`  
- **X11 환경**: `/etc/profile.d/korean-ime-fixer.sh`
- **자동 시작**: `~/.config/autostart/korean-ime-fixer.desktop`

### 환경 변수

```bash
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
```

## 라이선스

MIT 라이선스

## 기여하기

이슈 리포트나 풀 리퀘스트는 GitHub 저장소에서 환영합니다.

## 버전 이력

- **1.0-1**: 초기 릴리스
  - GNOME Wayland 지원
  - KDE Plasma 지원
  - X11 세션 지원
  - 완전한 설치/제거 지원
