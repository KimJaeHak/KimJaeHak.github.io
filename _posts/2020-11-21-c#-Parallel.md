---
title: "C# Parallel"
categories:
 - C#
tags:
 - C#
 - Asynchronous
 - Parallel
 - Concurrency
---

# \[Task 기반 Programming\]
## \- 병렬 처리 관련 알아두면 좋은 사전지식 ^^;
### \[Shared Memory\] Vs \[Distributed Memory\]
[![이미지](/assets/images/parallel/memory_compare.png)](/assets/images/parallel/memory_compare.png)

### HARDWARE THREADS 와 SOFTWARE THREADS 의 이해

Multi-core 프로세서는 보통 여러개의 Physical Core를 가지고 있다.  
이러한 Multi-core를 활용 하려면 여러 프로세스를 실행 하거나, 또는 프로세스에서 Multi-thread를 실행해야 한다.

여기서 **Physical Core(물리적 코어)**는 우리가 흔히 알고 있는 컴퓨터에 물리적으로 존재하는 코어이며,

**Logical-Core(논리적 코어)**를 2개 이상 제공 할 수 있다.  
**Logical-Core(논리적 코어)**를 **Hardware Thread(하드웨어 쓰레드)** 라고 한다.  
보통 Intel Hyper-Threading Technology (HT 또는 HTT)가 적용된 마이크로 프로세서는 물리적 코어 보다 많은**Hardware Threads**를 제공 한다.

그렇다면 **Software-thread**란 무엇일까? 그것은 우리가 만든 프로그램이 실행되면서 부터 생성되는 Thread인 것이다. 이것은 한개 혹은 여러개가 생성 될 수 있다.

**\[요약\]**

> - **Physical Core(물리적 코어)** : 실제 Cpu에 물리적으로 존재 하는 코어 이다.  
> - **Logical-Core(논리적 코어) 또는 Hardware Thread(하드웨어 쓰레드)** : 물리적 코어의 성능을 높이기 위해 추상화 한 개념의 Core.(Hyper-Threading)  
> - **Software-Thread** : 실행중인 프로그램(Process)에서 생성된 Thread

실제 프로그램에서 만들어진 Software-Thread가 OS 스케쥴러에 따라 Hardware-Thread에 할당 되어 실행 되는 것이다.  
아래 그림을 보면 이해가 편할 것이다.

[![image](/assets/images/parallel/thread_structure.png)](/assets/images/parallel/thread_structure.png)

### NUMA(non-uniform memory access)

**TPL(Task-Parallel-Lib)** 는 NUMA와 함께 작동 하도록 최적화 되어 있다고 함.  
아래의 그림은 NUMA를 그림으로 간략 하게 표현 함.

[![image](/assets/images/parallel/numa.png)](/assets/images/parallel/numa.png)

---

## Data Parallelism
우리는 Task를 직접 생성해서 사용 할 수도 있지만, 아래의 함수를 이용 할 수도 있다.<br>
**Parallel.For** — 고정된 수의 독립적 For 루프 반복에 대한 병렬 실행을 제공한다.  
**\[예제\]**

```cs
var loopCnt = 100;
Parallel.For(1, loopCnt, (int i) =>
{
    //TODO
});
```

**Parallel.ForEach** — 고정된 수의 독립적인 For Each 루프 반복에 대해 병렬 실행.(Partitioner 지원)

**\[예제\]**
```cs
Parallel.ForEach(Partitioner.Create(0, 100), range =>
{
    //TODO:
});
```
**Parallel.Invoke** — 독립 작업의 잠재적 병렬 실행을 제공.

---

먼저 Parallel.Invoke 부터 살펴 보자. 이 기능은 동시에 독립적인 함수를 실행 시킬 때 사용 한다.  
하지만 여러 함수를 동시에 실행 시켜도 실행이 완료되는 시점은 다를 수 있다.

**\[예제\]**
```cs
static void Main(string[] args)
{
  Parallel.Invoke(
    () => Method_1(),
    () => Method_2(),
    () => Method_3(),
    () => Method_4());
  System.Console.ReadLine();
}
```

> 결과는 아래와 같이 상황에 따라 다르게 발생 할 수 있다.

[![image](/assets/images/parallel/parallel_invoke.png)](/assets/images/parallel/parallel_invoke.png)

**\[주의사항\]**

1.  4개의 함수를 동시에 실행 시켰을때 가장 긴 시간을 기준으로 반환 하게 되며,<br>
    이것으로 인해 나머지 Thread들이 유휴 상태가 될 수 있다.
2.  단지 4개의 함수만 실행 되기 때문에 만약 8개의 Hardware-Thread가 존재 한다면, 4개의 쓰레드가<br>
    유휴 상태로 남아 있게 된다.

**\- 예외 처리**

> 병렬화 된 각 반복에서 호출되는 대리자 내부의 코드가 대리자 내부에서 캡처되지 않은 예외를 throw하면 예외 집합의 일부가 됩니다.  
> 새로운 AggregateException 클래스는이 예외 집합을 처리 함. 

```cs
try
{
  Parallel.ForEach(partitioner, (range, state) =>
  {
  	throw new Exception("test");
  });
}
catch (AggregateException ex)
{
  foreach (Exception innerEx in ex.InnerExceptions)
  {
    Debug.WriteLine(innerEx.ToString());
    // Do something considering the innerEx Exception
  }
}
```

## ParallelOptions

**\- MaxDegreeOfParallelism**<br>
    TPL을 사용하면 새 ParallelOptions 클래스의 인스턴스를 만들고 MaxDegreeOfParallelism의 값을 변경하여
    최대 병렬 처리 수준을 지정할 수 있습니다.  
**\- CancellationToken**<br>
    병렬 처리 하는 중 작업을 취소 할 수 있는 옵션.  
**\- TaskScheduler**<br>
    특별한 알고리즘을 사용 하지 않는 이상, 수정 할 일이 없음.  

## Task Parallelism

> TPL은 새로운 작업 기반 프로그래밍 모델을 도입하여 저수준, 복잡하고 무거운 스레드로 작업하지 않고도<br>
> 멀티 코어 성능을 애플리케이션 성능으로 변환합니다.  
> **Thread를 대체 하는 것은 아님.**

**\- 아래의 그림을 보면 Task와 Thread의 관계를 알 수 있다.**

[![](/assets/images/parallel/task_vs_thread.png)](/assets/images/parallel/task_vs_thread.png)

**Task 에 대해서 간단하게 정리해 보자.**  
1\. Thread보다 경량화된 구조이며 Overhead가 적게 발생 한다.  
2\. 새로운 Thread를 만들면 큰 오버헤드가 발생 하지만, Task를 만들면 작업 대기열을 사용하여<br>
    적은 오버헤드 발생. 이미 존재하는 Thread에 작업이 할당 된다.  
3\. 기본 작업 스케줄러는 Thread Pool 엔진에 의존 한다.  

#### Task 작업 취소 (CancellationTokenSource and CancellationToken)

```cs
class Program
    {
        static void Main(string[] args)
        {
            var cts = new System.Threading.CancellationTokenSource();
            var ct = cts.Token;

            var t1 = Task.Factory.StartNew(() => CancelTest1(ct), ct);
            var t2 = Task.Factory.StartNew(() => CancelTest2(ct), ct);
            Thread.Sleep(1000 * 1);
            cts.Cancel();

            try
            {
                Task.WaitAll(new Task[] {t1, t2});
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
            if (t1.IsCanceled)
            {
                Console.WriteLine("The task running CancelTest1 was cancelled.");
            }
            if (t2.IsCanceled)
            {
                Console.WriteLine("The task running CancelTest2 was cancelled.");
            }
            Console.ReadLine();

        }

        private static void CancelTest1(CancellationToken ct)
        {
            for (int i = 0; i < 10; i++)
            {
                Task.Delay(1000 * 1).Wait();
                Console.WriteLine(nameof(CancelTest1) + "  Index " + i);
                ct.ThrowIfCancellationRequested();
            }
        }

        private static void CancelTest2(CancellationToken ct)
        {
            for (int j = 0; j < 10; j++)
            {
                Task.Delay(1000 * 1).Wait();
                Console.WriteLine(nameof(CancelTest2) + "  Index " + j);
                ct.ThrowIfCancellationRequested();
            }
        }
    }
```

**\[실행 결과\]**

```cs
CancelTest2  Index 0
CancelTest1  Index 0
System.AggregateException: 하나 이상의 오류가 발생했습니다. ---> System.Threading.Tasks.TaskCanceledException: 작업이 취소되었습니다.
   --- 내부 예외 스택 추적의 끝 ---
   위치: System.Threading.Tasks.Task.WaitAll(Task[] tasks, Int32 millisecondsTimeout, CancellationToken cancellationToken)
   위치: System.Threading.Tasks.Task.WaitAll(Task[] tasks, Int32 millisecondsTimeout)
   위치: System.Threading.Tasks.Task.WaitAll(Task[] tasks)
   위치: ConsoleApp1.Program.Main(String[] args)
---> (내부 예외 #0) System.Threading.Tasks.TaskCanceledException: 작업이 취소되었습니다.<---

---> (내부 예외 #1) System.Threading.Tasks.TaskCanceledException: 작업이 취소되었습니다.<---

The task running CancelTest1 was cancelled.
The task running CancelTest2 was cancelled.
```

#### Task Chaining Continuation
프로그램 실행시 이전 Task의 실행 결과를 가지고 새로운 Task를 실행 해야 하는 경우가 발생 한다.  
이 때 **.net TPL** 에서 지원해 주는 기능이 **Task.ContinueWith** 이다.  

**\[샘플 코드\]**  
```cs
var t1 = Task.Factory.StartNew(() => GenerateTest(ct), ct);
var t2 = t1.ContinueWith((t) =>
{
	//Task(t1) 의 델리게이트 반환결과를 가지고 작업.
	for (int i = 0; i < t.Result.Count; i++)
	{
		Console.WriteLine(t.Result[i]);
	}
});  
```  

## Coordination Data Structure(데이터 동기화)
#### \- Race Conditions(경쟁 상태)
<span style="color:blue">경쟁 상태</span>란 공유 자원에 대해 여러 개의 프로세스가 동시에 접근을 시도할 때 접근의 타이밍이나 순서 등이<br>
결과값에 영향을 줄 수 있는 상태를 말한다. 동시에 접근할 때 자료의 일관성을 해치는 결과가 나타날 수 있다.

#### \- Lock Free With Local Storage
Multi-thread 코드에서 Thread 별로 Local Storage를 보유하는 방법이다. 동작이 완료 되면  
Thread별 결과를 합산 해서 결과를 도출 한다.
이러한 작업은 **Race Condtion**과 **Dead Lock**에 대한 걱정은 덜 수 있다.  
하지만 **Thread Local Storage**를 합산하는 작업이 존재하며 이것은 어디선가 Sequential한 작업이 존재 한다는 뜻이다.  

#### \- 동기화 메커니즘에 대한 이해.
기본적으로 .NET 4.0 에서는 동기화에 대한 메커니즘은 다음과 같다.
> 1. Concurrent collection classes  
> 2. Lightweight synchronization primitives  
> 3. Types for lazy initialization  

#### Lightweight synchronization primitives : 
1. **Barrier** : Multiple tasks에 대해서 여러 단계별로 동기화를 시킬 수 있도록 함.
2. **CountdownEvent** : Fork and Join 시나리오를 단순화 한다. 카운트가 0에 도달하면 신호를 받는<br>
매우 가벼운 동기화 기본요소 물론 Parallel.Invoke나 Continuations등 으로 Fork/Join의 더 쉬운 접근 방법을 제공한다.<br>
이럴경우 우리는 Task 인스턴스에 대한 정보가 필요하지만 CountdownEvent는 개체 참조가 필요하지 않다는 장점이 있다.
3. **ManualResetEventSlim** : Thread , Task 가 대기상태가 된다. 다른 Task에 의해서 Event Handle<br>이 Manually Signaled가 될 때까지
4. **SemaphoreSlim** : 리소스 또는 리소스 풀에 동시에 액세스 할 수있는 작업 수를 제한 할 수 있다. 대기 시간이 매우 짧을 것으로 예상하면 헤비급 Semaphore보다 더 나은 성능을 제공.
5. **SpinLock** : 루프에서 대기하는 절차를 Spinning 이라고 한다. 상호배제 잠금(Mutual Excusion Lock)을 획득 할 때 까지<br>
   반복적으로 확인 하면서 루프에서 대기 하는 방법이며, Structure구조 이기 때문에 성능상 이점도 존재 한다.
6. **spinWait** : Task에서 지정된 조건이 충족 될 때까지 스핀 기반 대기를 수행 할 수 있다.

#### 1. Barrier
- 특정 위치에서 모든 Task(thread)가 완료 될 때 까지 대기 하도록 장벽(Barrier)을 세운다.
- 병렬처리 하는 로직 내부가 여러 Step으로 되어 있고, 이전스텝에서 **모든 결과 데이터**를 다음 스텝에서 사용해야 할 때.
- Task의 ContinueWhenAll을 사용할 수 있지만, 반복 횟수가 많아 지면 Task생성에 대한 오버헤드가 생긴다.<br>
  
>그렇다면 다음 예제를 한번 살펴 보자. 개발자는 코드가 편하니까.<br>

**\[샘플 코드\]**<br>
```cs
public class ConcurrentTest
    {
        public static void BarriersTest()
        {
            var participants = Environment.ProcessorCount;
            var tasks = new Task[participants];
            var barriers = new Barrier(participants, barrier => 
                                       { Console.WriteLine($"Current phase: {barrier.CurrentPhaseNumber}" + Environment.NewLine);});

                for (int i = 0; i < participants; i++)
                {
                    tasks[i] = Task.Factory.StartNew((num) =>
                    {
                        var participantNumber = (int)num;
                        for (int j = 0; j < 10; j++)
                        {
                            MethodStepOne(participantNumber);
                            barriers.SignalAndWait();   //All Tasks Wait Step One
                            MethodStepTwo(participantNumber);
                            barriers.SignalAndWait();   //All Tasks Wait Step Two
                            MethodStepThree(participantNumber);
                            barriers.SignalAndWait();   //All Tasks Wait Step Three
                            MethodStepFour(participantNumber);
                            barriers.SignalAndWait();   //All Tasks Wait Step Four
                            MethodStepFive(participantNumber);
                            barriers.SignalAndWait();   //All Tasks Wait Step Five
                        }
                    }, i);
                }

                var finalTask = Task.Factory.ContinueWhenAll(tasks, (task) =>
                {
                    // Wait for all the tasks to ensure
                    // the propagation of any exception occurred
                    // in any of the tasks
                    Task.WaitAll(tasks);
                    Console.WriteLine("All the phases were executed.");
                    // Dispose the Barrier instance
                    barriers.Dispose();
                });
                // Wait for finalTask to finish
                finalTask.Wait();
                Console.ReadLine();
        }

        private static void MethodStepOne(int participantNumber)
        {
            Console.WriteLine($"MethodStepOne # {participantNumber}");
        }

        private static void MethodStepTwo(int participantNumber)
        {
            Console.WriteLine($"MethodStepTwo # {participantNumber}");
        }

        private static void MethodStepThree(int participantNumber)
        {
            Console.WriteLine($"MethodStepThree # {participantNumber}");
        }

        private static void MethodStepFour(int participantNumber)
        {
            Console.WriteLine($"MethodStepFour # {participantNumber}");
        }

        private static void MethodStepFive(int participantNumber)
        {
            Console.WriteLine($"MethodStepFive # {participantNumber}");
        }
    }
```

**\[실행 결과\]**<br>
[![](/assets/images/parallel/barrier_result.png)](/assets/images/parallel/barrier_result.png)