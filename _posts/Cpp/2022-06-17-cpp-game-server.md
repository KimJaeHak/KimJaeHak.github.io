---
title: "C++ Game Server"
categories:
 - C++
tags:
 - C++
 - Game
 - Unreal
published: false
---


## Lock-Guard
- 생성자와 소멸자를 사용해서 안전하게 Lock을 걸고 해제 하는 방법.

## unique_lock

- condition_varialble

## 메모리 모델
- 모든 쓰레드가 동일 객체에 대해서 동일 수정 순서를 관찰
```cpp
atomic<bool> flag;

{
    flag.exchange(true)    

}

{
    bool expected =  false;
    bool desired = true;
    flag.compare_exchange_strong(expected, desired);
}
```

memory model 정책

1) Sequentially Consistent(seq_cst)=>가장 엄격 = 컴파일러 최저고하 여지 적음
2) Acquire-Release(acquire, release)
3) Relaxed (relaxed) => 자유롭다. 컴파일러 최적화 여지 많음 , 직관적이지가 앖다.

## Thread Local
```cpp
{
    thread_local int32 LThreadId = 0;
}
```

## Lock-based Stack/Queue


## Lock-free Stack/Queue
