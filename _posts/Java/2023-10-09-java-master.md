---
title: "Java 기초"
categories:
 - Java

toc: true
toc_sticky: true
---

# Maven 이란
 - Build Tool
 - 하나의 결과물
 - 의존성 관리
 - 폴더구조
   - src/main/java/.java file (Maven이 찾는 구조?)
 - 명령어
   - mvn clean : 처음 실행 종속성 다운로드
   - mvn compile : 모든 플러그인 다시 확인/ 다운로드 - 컴파일
   - mvn package : .jar 패키징 - 라이브러리를 만드는 것 같음.

```xml
<!-- porm.xml -->

<project>
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.pluralsight</groupId>
    <artifactId>FitnessTracker</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>HelloWorld</name>
</project>

<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.8.0</version>
            <configuration>
            <!-- JAVA Version -->
            <release>10</release> 
            </configuration>
        </plugin>
    </plugins>
</build>

```

# Maven 구조
## Folder Structure
- `src/main/java` 폴더를 기준으로 한다.
- `src/test/java` 단위 테스트 코드를 위한 공간.
- Java 코드가 저장되어 있어야 할 공간


## POM file Basics

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
http://maven.apache.org/maven-v4_0_0.xsd">
    <groupId>com.pluralsight</groupId>
    <artifactId>HelloWorld</artifactId>
    <version>1.0-SNAPSHOT</version>
    <modelVersion>4.0.0</modelVersion>
    <packaging>jar</packaging>
</project>
```
# Dependency 의존성

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
http://maven.apache.org/maven-v4_0_0.xsd">
    <groupId>com.pluralsight</groupId>
    <artifactId>HelloWorld</artifactId>
    <version>1.0-SNAPSHOT</version>
    <modelVersion>4.0.0</modelVersion>
    <dependencies>
        <dependency>
        <!-- 아래 3개의 element가 중요함. -->
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
            <version>3.8.1</version>
        </dependency>
    </dependencies>
</project>
```

- 위 와 같이 설정한 후 mvn clean을 실행 하면 로컬 저장소에 다운로드 된다.
- Dependency 저장소 위치는 아래와 같다.
- c:\Users\User(계정)\.m2\repository

# Repositories

- Maven은 Local Storage를 먼저 찾고 여기에 없으면, 원격 저장소에서 다운로드 한다.

- Maven은 중앙 레포지토리를 통해 필요한 의존성을 다운로드 받습니다. 기본적으로 Maven Central Repository에서 의존성을 받아옵니다. 그러나 종종 특정 라이브러리를 다른 저장소에서 받아야 할 경우도 있습니다. 이 경우에는 pom.xml 파일에 저장소를 추가해야 합니다.

```xml
<project>
  ...
  <repositories>
    <repository>
      <id>my-repo-id</id>
      <name>My Repository</name>
      <url>http://example.com/my/repo</url>
    </repository>
  </repositories>
  ...
</project>
```

- 저장소의 배포를 위해서는 <distributionManagement> 섹션에 <repository> 및 <snapshotRepository> 태그를 추가할 수 있습니다.

```xml
<project>
  ...
  <distributionManagement>
    <repository>
      <id>my-repo-id</id>
      <name>My Release Repository</name>
      <url>http://example.com/my/release-repo</url>
    </repository>
    <snapshotRepository>
      <id>my-snapshot-repo-id</id>
      <name>My Snapshot Repository</name>
      <url>http://example.com/my/snapshot-repo</url>
    </snapshotRepository>
  </distributionManagement>
  ...
</project>
```

- 위의 설정을 통해 Maven은 릴리즈 버전의 아티팩트를 'My Release Repository'에, 스냅샷 버전의 아티팩트를 'My Snapshot Repository'에 배포하게 됩니다.

- 주의사항으로, 저장소에 대한 인증이 필요한 경우 ~/.m2/settings.xml 파일에 인증 정보를 추가해야 합니다.

# Plugins



# IDE 통합
