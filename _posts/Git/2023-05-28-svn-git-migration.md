---
title: "Svn To Git(Gitlab) Migration"
categories:
 - Git
tags:
 - git
 - svn git migration
 
toc: true
toc_sticky: true
---
<br><br>

# **[Migration 하기전에 SVN Repository Backup]**
## - Dump
```bash
    # 원격지 파일시스템에 직접 접근이 가능할 때
    svnadmin dump /path/to/repository > repository_dump

    # 원격지에 SVN 프로토콜을 통한 접근만 가능할 떄
    svnrdump dump http://svn.example.com/repo > repo_dumpfile
```

## - Dump File 복원(추후 Migration 오류 발생 시)
### 복원 1단계 : New Repository 생성
```bash
    svnadmin create /path/to/new/repository
```
### 복원 2단계 : Backup Data Load
```bash
    svnadmin load /path/to/new/repository < /path/to/backup/dumpfile
```
<br>

# **[SVN To Git Migration전 사전점검]**
1. **접근 권한**: 
SVN 서버에 액세스할 수 있는지 확인해야 합니다. 권한 문제는 마이그레이션을 방해할 수 있습니다. 필요한 경우 SVN 서버의 관리자에게 권한을 요청하거나 적절한 인증 정보를 사용하십시오.

2. **네트워크 연결**: 
SVN 서버와 로컬 시스템 간의 안정적인 네트워크 연결이 중요합니다. 대용량 리포지토리의 경우, 특히 그렇습니다.

3. **로컬 스토리지 공간**: 
SVN 리포지토리의 크기에 따라 충분한 로컬 디스크 공간이 필요합니다. SVN 리포지토리를 Git으로 변환하면 데이터의 크기가 약간 늘어날 수 있으므로, 여유 공간을 확보해야 합니다.

4. **로컬 시스템의 성능**: 
큰 SVN 리포지토리를 Git으로 마이그레이션하는 것은 시스템의 CPU와 메모리에 부담을 줄 수 있습니다. 로컬 시스템이 이 작업을 처리할 수 있는 충분한 성능이 있는지 확인해야 합니다.

5. **Git과 SVN 도구**: 
최신 버전의 Git과 SVN 클라이언트 도구가 로컬 시스템에 설치되어 있어야 합니다. 버전이 오래되면 예상치 못한 문제가 발생할 수 있습니다.

6. **SVN 리포지토리 구조**: 
SVN 리포지토리가 표준 레이아웃(trunk/, branches/, tags/)을 따르는지 확인해야 합니다. 만약 따르지 않는다면, 적절한 git svn clone 옵션을 사용하여 특정 폴더를 trunk, branches, tags로 지정해야 합니다.

<br>

# **[SVN To GitLab Migration]**
> - SVN에서 Gitlab으로 Migration하는 과정은 크게 2가지 과정으로 나눠진다.

1. SVN Repository를 Git Repository로 변경 한다.
2. New Git Repository를 GitLab에 Push 한다.

## Step 1 : Install Required Tools(필수 툴 설치)
- Git: You need Git installed on your machine. You can download it from [[Git Download]](https://git-scm.com/downloads)

- 대부분 git-svn도 git을 설치하면 자동으로 포함되어 있음
- 만약 없다면 git을 업데이트 하거나, git-svn을 따로 설치해야 할 수 있음

## Step 2 : SVN 리포지토리를 Git 리포지토리로 변환
1.  Git 리포지토리를 만들고 싶은 Directory 만듭니다.
2.  Directory 위치로 이동 합니다.
3.  다음 git svn clone 명령어를 사용하여 SVN 리포지토리를 복제합니다
```bash
    git svn clone <url_of_svn_repo>
```

- 위 과정은 SVN의 Repository의 크기에 따라서 다소 시간이 걸릴수 있음.
- SVN Repository와 동일한 히스토리를 갖는 Git Repository를 생성함.

## Step 3: Convert SVN Ignore Properties to Git Ignore
- SVN에 Ignore 속성이 있는 경우, .gitignore 파일로 변환하고 싶을 때
```bash
   cd <새로운_git_리포지토리_디렉토리>
   git svn show-ignore > .gitignore
   git add .gitignore
   git commit -m "Convert svn:ignore properties to .gitignore."
```

## Step 4 : 새 Git 리포지토리를 GitLab에 Push
1. Gitlab에서 새로운 프로젝트를 생성
2. Gitlab 프로젝트 페이지에서 Clone Button 에서 "Clone with HTTPS" 링크 복사
3. Git Repository로 돌아가서 Command window(git terminal)을 열고 아래의 명령을 실행
```bash
    # Git 원격 저장소 추가
    git remote add origin <gitlab_리포지토리_url>

    # 현재 브랜치를 push 하면서 Origin Master를 현재 브랜치의 추적 브랜치로 설정
    git push -u origin master
```
<br>

# [ Docker Clinet를 통해서 Gitlab을 실행]
## Step 1 : Install Docker Client
1. Docker Desktop 다운로드:  
Docker 클라이언트는 공식 Docker 웹사이트 [[Download Docker Desktop]](https://www.docker.com/products/docker-desktop/) 에서 다운로드할 수 있습니다.  
다운로드 페이지에서 서버 운영 체제에 맞는 버전을 선택하여 다운로드합니다.

2. Gitlab Docker Image Load(Docker나 혹은 다른곳에서 Gitlab Docker Image를 미리 구함)
```bash
    docker load -i gitlab.tar
```

3. Gitlab 컨테이너 실행
```bash
    docker run --detach \
                # 실제 URL로 대체
    --hostname gitlab.example.com \
    --publish 443:443 --publish 80:80 --publish 22:22 \
    --name gitlab \
    --restart always \
    --volume /srv/gitlab/config:/etc/gitlab \
    --volume /srv/gitlab/logs:/var/log/gitlab \
    --volume /srv/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ce:latest
```