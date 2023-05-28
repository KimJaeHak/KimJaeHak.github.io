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
    svnadmin dump /path/to/repository > repository_dump
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