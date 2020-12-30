---
title: "C# Performace(성능) Deep Dive"
categories:
 - C#
tags:
 - C#
 - C# Performace
---

# C# 성능을 높이는 방법

## - Type Internals (value Type 과 Reference Type)

 ### **Memory 관점**
아래의 2가지 Type을 한번 살펴 봅니다. 제공하는 데이터는 동일 합니다.<br>
이제 1000만 Point2D를 배열의 메모리에 저장 한다고 가정 하면 얼마나 많은 공간이 필요 할까요?
Value Type 인지 Reference Type 인지에 따라서 크게 달라 집니다.

- **Reference Type** : 1000만 참조를 저장 합니다. 32bit 시스템에서 **대략 40MB** 의 메모리를 사용 합니다.<br> (실제로 Point2D Instance는 최소 12Byte 메모리를 차지하여 총 메모리는 **160MB**에 
이릅니다.)

- **Value Type** : 1000만 Point2D값을 저장합니다. **40MB** 로 참조 유형보다 4배 적습니다.

> 이것은 우리가 특정 상황에서 Value Type을 사용을 고려해야 하는 이유 입니다.

```c#
//short is 16bit(2Byte)
class Point2D
{
    short X;
    short Y;
}

struct Point2D
{
    short X;
    short Y;
}
```

> Reference Type Vs Value Type 배열 메모리 구조<br>

![배열구조 이미지](/assets/images/csharp/point2d_array.png)

> 사이즈가 큰 배열을 순차적으로 순회하는 경우 메모리의 연속성이 보장되지 않는 Reference Type 보다,  
> 연속 배열이 보장된 Value Type 에 Access 하는 것이 훨씬 쉬우며 CPU Cache 영향을 고려하면 매우 큰 차이가
> 날 수 있습니다.

### **Stack Vs Heap**

Value Type 과 Refrence Type을 이야기 할 때 빠질수 없는 이야기가 있습니다.<br>
바로 Stack Memory 와 Heap Memory 입니다.  
- Stack Memory : Value Type이 할당 되는 공간.
- Heap Memory : Reference Type이 할당 되는 공간.

헌데 **.net framework** 에서 과연 Heap 과 Stack에 많은 차이가 있을까요?  
우리가 익히 알고 있는 것과는 다르게 **Heap과 Stack은 별 차이가 없습니다**.
>stacks and heaps are nothing more than ranges of addresses in virtual memory, and there is no inherent<br>
advantage in the range of addresses reserved to the stack of a particular thread compared to the range<br>
of addresses reserved for the managed heap. Accessing a memory location on the heap is neither faster<br>
nor slower than accessing a memory location on the stack.

**특정 Thread에 예약된 주소라는 것 빼고는 별반 차이가 없다는 말입니다.**

생각해보면 사실 우리가 흔히 알고 있는 GC(Garbage Collector)에서 주소를 할당 하는 방법은   
단지 Pointer를 증가 시키는 간단한 동작 이기에 별반 차이가 없을것도 같습니다.

<span style="color:lightblue"> **그럼 Heap 과 Stack은 성능 차이가 전혀 없나요?** </span>  
<span style="color:red">아니요, 차이가 있습니다. ^^;</span>

다음과 같은 이유로 Stack의 성능상 이점이 있다는 주장을 뒷받침 합니다.

1. 시간상 서로 가깝게 만들어진 메모리 할당은 공간상 서로 가까움을 의미 합니다.  
동일한 시간에 할당된 객체들은 함께 Access 될 확률이 높습니다.  
때문에 Stack은 CPU 캐시 및 운영 체제 페이징 시스템과 관련하여 더 나은 성능을 보이는 경향이 있습니다.

2. Stack Memory의 밀도는 참조 유형 오버헤드로 인해 힙보다 높은 경향이 있습니다.  
메모리 밀도가 높을 수록 성능이 향상되는 경향이 있는데, 이는 더 많은 개체가  
CPU Cache에 Fit in 될 수 있기 때문입니다.

3. Thread Stack은 상당히 작은 경향이 있습니다. 최신 시스템에서는 모든 응용프로그램의 Thread Stack이  
CPU Cache에 들어 갈 수 있으므로 일반적인 Stack 개체의 Access가 매우 빨라 집니다.  
(반면에 Heap은 CPU Cache에 거의 맞지가 않습니다.)


### Value Type 의 사용시 주의 사항.

- 단순히 Value Type을 사용하는 것만으로 성능상 이점이 있습니다.  
하지만 성능저하를 일으키지 않으려면 주의 사항이 있습니다.

## Boxing
컴파일러가 Value Type을 Refrence Type으로 처리해야 할 때마다. 다음과 같은 일이 벌어 집니다.
1. Heap 에 메모리를 할당 합니다.
2. Value Type에 내용을 Heap에 복사 합니다.
3. Value Type에 내용을 Object의 Header로 Wrapping 하는 Method를 호출 합니다.

> Box는 원래의 Value Type 의 Instance와 분리 되었고, 서로 연관성이 없습니다.

![이미지](/assets/images/csharp/boxing_valuetype.png)

> 다음 코드를 봅니다.
```c#
List<Point2D> polygon = new List<Point2D>();
//1000만개의 Point2D가 삽입 되었다고 가정 합니다.
Point2D point = new Point2D { X = 5, Y = 7 };
bool contains = polygon.Contains(point);
```

위 Contains 안에서 안타깝게도 virtual Equals가 호출 됩니다.   
`public override bool Equals(object obj)`  
1000만번 비교하는 동안 2000만번의 Boxing이 발생 하며, Heap Memory에 복사를 반복 합니다.  
**이것은 성능을 굉장히 악화 시킵니다.**


## Avoid Boxing(Equals Method)
Equals의 Boxing을 피하기 위해서는 Equals를 Type에 맞게 재정의 해주는 것입니다.

```C#
public struct Point2D
{
    public int X;
    public int Y;
    public override bool Equals(object obj)
    {
        if (!(obj is Point2D)) return false;
        Point2D other = (Point2D)obj;
        return X == other.X && Y == other.Y;
    }
    public bool Equals(Point2D other)
    {
        return X == other.X && Y == other.Y;
    }
}
```

위 와 같이 정의하게 되면 Point2D에 대한 호출을 선택 하게 되므로 Boxing을 피할 수 있습니다.<br>
또 우리는 `!= 또는 ==` 을 통해서 비교하기도 합니다.  
>아래의 코드가 좀 더 완벽해 보입니다. **하지만 완벽 할까요?**

```C#

public struct Point2D
{
    public int X;
    public int Y;
    public override bool Equals(object obj)
    {
        if (!(obj is Point2D)) return false;
        Point2D other = (Point2D)obj;
        return X == other.X && Y == other.Y;
    }
    public bool Equals(Point2D other)
    {
        return X == other.X && Y == other.Y;
    }

    public static bool operator==(Point2D a, Point2D b)
    {
        return a.Equals(b);
    }
    public static bool operator!= (Point2D a, Point2D b)
    {
        return !(a == b);
    }
}

```

List<T>는 Generic을 사용하고 있습니다. 이 경우 여전히 Equals를 호출 할때 Boxing이 발생합니다.  
Generic객체는 Equals를 호출 할 때 Parameter로 T를 사용하기 때문입니다.

> 아래는 최종 완성 코드 입니다. 달라진 점은 IEquatable<T>를 상속했을 뿐입니다.
``` C#
//IEquatable<Point2D> 상속받아 구현함.
public struct Point2D : IEquatable<Point2D>
{
    public int X;
    public int Y;
    public override bool Equals(object obj)
    {
        if (!(obj is Point2D)) return false;
        Point2D other = (Point2D)obj;
        return X == other.X && Y == other.Y;
    }
    public bool Equals(Point2D other)
    {
        return X == other.X && Y == other.Y;
    }

    public static bool operator==(Point2D a, Point2D b)
    {
        return a.Equals(b);
    }
    public static bool operator!= (Point2D a, Point2D b)
    {
        return !(a == b);
    }
}
```
## Summary
특정 상황에서는 Value Type의 사용을 고려해 보아야 한다는 내용으로 글을 썼습니다.  
Memory 와 Value Type의 Boxing에 대한 관점에서 내용을 작성 했습니다.  
혹시 위 내용이 잘못된 것이 있다면 알려주십시요.  
또한 Value Type에 대한 중요 내용중 GetHashCode에 대한 것도 있으니 관심있으신 분은 찾아보세요.  
