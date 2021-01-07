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
 - Garbage Collector는 사용자가 커스터마이징 여지가 거의 없지만, 여러가지 형태로 제공이 됩니다.
 - 클라이언트 / 고성능 서버 프로그램등에 시나리오에 대응하기 위해서 입니다.

**[GC Mode]**
- **Workstation GC**
  - Concurrent Workstation GC
  - Non-Concurrent Workstation GC
- **ServerGC**






