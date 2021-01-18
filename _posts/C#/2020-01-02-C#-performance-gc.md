---
title: "C# Performace Deep Dive - GC(Garbage Collection)"
categories:
 - C#
tags:
 - C#
 - C# Performace
 - Garbage Collection
---

# Garbage Collection(GC)

## Garbage Collection이란?
- 개발자가 메로리의 할당/해제를 관리 할 필요가 없도록 하는 높은 수준의 추상화 입니다.
- 메모리 관리를 하면서 나타나는 버그 및 복잡성을 낮춥니다.
- Native의 수동 할당 이상의 메모리 관리성능을 제공합니다.

## Garbage Collection Mechanism
## Tracing Garbage Collection
> - .Net CLR에서 사용되는 GC 메커니즘 입니다.
> - Reference Counting 기반의 GC를 수행하지 않습니다.
> - 개발자가 명시적으로 메모리 해제를 수행할 필요가 없으며, 메모리 사용량 임계치에  
도달하기 전까지 할당 취소비용이 발생하지 않음.
> - **Mark Phase -> Sweep -> Compact** 단계로 수행됨.

### 1. Mark Phase
 - 응용 프로그램에서 참조하는 모든 개체의 그래프를 탐색.
 - GC에 의해 형성된 객체의 참조 그래프와 Root를 설정함.
 - Root부터 참조순회를 하며 Alive/Dead Object에 Marking을 합니다.

### 2. Sweep Phase
 - Mark Phase 단계에서 Dead Object로 표시된 객체의 메모리를 해제 합니다.

### 3. Compact Phase
 - Sweep 단계에서 해제된 메모리가 곳곳에 구멍처럼 있으며, 이것을 조각화라고 합니다.<br>
 조각화된 메모리를 압축하는 단계 입니다.

> Sweep And Compact Result

![이미지](/assets/images/csharp/sweep_compact.png)

## Garbage Collection Mode
 - Garbage Collector는 사용자가 커스터마이징 할 수 없습니다.
 - 하지만 여러가지 모드로 제공 됩니다. 
 - 클라이언트 / 고성능 서버 프로그램등에 시나리오에 대응하기 위해서 입니다.

### **[GC Mode]**
- **Workstation GC**
  - Concurrent Workstation GC
  - Non-Concurrent Workstation GC
- **ServerGC**

이제 위 GC Mode의 특징을 하나씩 살펴 봅니다.

## [Workstation GC] Concurrent Workstation GC
 - 우리가 Mode설정을 하지 않는다면, 이것이 **Default 설정** 입니다.
 - 별도의 전용 GC Thread가 존재 합니다.
 - Sweep Phase 가 수행되면, 모든 Application Thread는 멈춥니다.
 - GC Thread가 따로 존재,    UI 반응성이 좋아 집니다.
 - **UI Thread 에서 GC가 Trigger 않도록 해야 합니다.** 이 경우 UI 반응성에 대한 이점이 사라질 수 있습니다.
  
>다음은 GC의 동작을 나타냅니다.<br>
 `--- Dash Line은 Blocked Thread 상태.`

- **GC Trigger by Ui-Thread (Bad)**
![이미지](/assets/images/csharp/concurrency_work_uithread.png)
  - Ui Thread가 blocked 되어 멈춥니다.
  - GC-thread 와 Work(other)-thread가 경합하며 진행 됩니다.
  - 경합 과정에서 메모리 해제가 늦어지고, 이는 Ui-thread의 대기상태가 길어짐을 의미합니다.
  - 결국 ui에 응답성이 떨어집니다.
  
----
- **GC Trigger by Work-Thread (Good)**
![이미지](/assets/images/csharp/corrency_work_workthread.png)
  - work(other)-thread 가 Blocked 되어 멈춥니다.
  - ui-thread 와 GC-thread가 경합하며 진행 됩니다.
  - ui-thread는 이상적인 상황이라면 적절히 자원이 할당되어 **응답성을 높일 것입니다.**


> 위 내용을 기반으로 아래와 같은 결론을 얻을 수 있습니다.
> 1. Ui-thread에서 GC(garbage collection)가 Trigger되지 않도록 해야 합니다.
> 2. Work-thread에서 자원할당(GC가 Trigger될 가능성이 있는) 작업을 하도록 합니다.
> 3. Ui-thred에서 GC.Collect를 명시적으로 호출하지 않도록 합니다.

## [Workstation GC] Non-Concurrent Workstation GC
- **GC Trigger by Ui-thread**
![이미지](/assets/images/csharp/nonconcurrency_uithread.png)
  - Mark Phase 와 Sweep Phase 모두, Application Thread를 일시 중단합니다.
  - GC Thread가 따로 존재 하지 않습니다.
  - GC Trigger한 Thread가 직접 Collection을 수행 합니다.
  - Ui-thread에서 GC Trigger되면 Work-Threads와 경쟁하지 않고, **Waiting** 상태에서 더 빨리 해제됩니다.**(응답성↓)**

## [Server GC]
- 별도의 GC-Thread가 존재 합니다. 
- 높은 처리 속도 및 확장성이 필요한 서버 어플리케이션에 사용합니다.
- 분리된 Managed Heap은 경합을 최소화 합니다.
- 병렬할당 및 병렬해제를 수행할 수 있도록 합니다.
- **마지막에 Collection을 마친 GC-Thread를 기준으로, Applicaton Thread가 기동합니다.**
  
![이미지](/assets/images/csharp/gc-server.png)

## Backgound GC 등장

- Workstation GC(.net 4.0 이상)
- Server GC(.net 4.5 이상)
- 2세대 수집과 0, 1세대 수집을 분리하여 Application의 응답성을 높임.
- Background GC 설명 [[Link]](https://docs.microsoft.com/ko-kr/dotnet/standard/garbage-collection/background-gc)

## GC Configuration
- GC Mode를 설정 하는 방법은 .net 버전과 환경에 따라 여러가지가 있을수 있습니다.
- 제가 설정한 방법은 아래와 같습니다.
- 응용 프로그램을 만들면 App.config파일이 생성 됩니다.
- ![이미지](/assets/images/csharp/gc-config.png)
- 아래와 같이 설정 하면 Server Mode로 동작 하게 됩니다.<br>

```xml
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <runtime>
    <gcServer enabled="true" />
  </runtime>
</configuration>
```

## Summary
- .net Garbage Collection에 대해 간략하게 정리해 보았습니다.
- 대용량 처리의 성능을 개선을 위한 **GC Server Mode**를 설명 했습니다.
- 실제 GC Mode 설정방법을 설명했습니다.
- GC에 대한 설명이 잘되어있는 **아래 사이트**도 한번 방문해 보세요.
  
닷넷 가비지 컬렉션 다시 보기 - Part I 기본 작동 방식  
 http://www.simpleisbest.net/post/2011/04/01/Review-NET-Garbage-Collection.aspx

닷넷 가비지 컬렉션 다시 보기–Part II 세대별 가비지 콜렉션  
 http://www.simpleisbest.net/post/2011/04/05/Generational-Garbage-Collection.aspx

닷넷 가비지 컬렉션 다시 보기 - Part III LOH  
 http://www.simpleisbest.net/post/2011/04/11/Large-Object-Heap-Intro.aspx

닷넷 가비지 컬렉션 다시 보기 - Part IV 가비지 컬렉션 발생 시기  
 http://www.simpleisbest.net/post/2011/04/18/When-GC-Occurs.aspx

닷넷 가비지 컬렉션 다시 보기 - Part V 가비지 컬렉션 모드  
 http://www.simpleisbest.net/post/2011/04/25/Garbage-Collection-Modes.aspx

닷넷 가비지 컬렉션 다시 보기 - Part VI 가비지 컬렉션 모드 활용  
 http://www.simpleisbest.net/post/2011/04/27/Using-Garbage-Collection-Modes.aspx