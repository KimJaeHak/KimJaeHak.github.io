---
title: "C# Performace Deep Dive - Pooling Object"
categories:
 - C#
tags:
 - C#
 - C# Performace
 - Pooling Objects
published: false
---

# Pooling Object
## Pooling Object란?
`GC : Garbage Collection`
 - 대량의 객체를 생성할때, 특히 객체의 사이즈가 큰 경우라면 GC 자주 일어 납니다.
 - GC가 자주 발생한 다는것은 성능의 저하를 의미 합니다.
 - 그렇다면 객체를 계속 생성하지 않고 미리 생성해 한 후, **재사용** 할 수 없을까요?
 - 그래서 나온 방법이 바로 Pooling Object 입니다.

**[주의: 아래는 Snippets Code 입니다. 실제 프로젝트 적용시 수정이 필요 할 수 있음.]**
## Example Code
```cs
public class Pool<T> 
{
	private ConcurrentBag<T> pool = new ConcurrentBag<T>();
	private Func<T> objectFactory;

	public Pool(Func<T> factory) 
	{
		objectFactory = factory;
	}

	public T GetInstance() 
	{
		T result;
		if (!pool.TryTake(out result)) 
		{
			result = objectFactory();
		}
		
		return result;
	}

	public void ReturnToPool(T instance) 
	{
		pool.Add(instance);
	}
}


public class PoolableObjectBase<T> : IDisposable 
{
    private static Pool<T> pool = new Pool<T>();

    public void Dispose() 
    {
        pool.ReturnToPool(this);
    }

    ~PoolableObjectBase() 
    {
        GC.ReRegisterForFinalize(this);
        pool.ReturnToPool(this);
    }
}
```
## Summary