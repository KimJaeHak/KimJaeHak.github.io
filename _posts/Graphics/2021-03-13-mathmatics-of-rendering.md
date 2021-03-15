---
title: "Mathmatics of Rerndering"
categories:
 - Graphics
tags:
 - math
 - game engine
 - mathmatics
 - rendering
use_math : true
---
[Table Of Contents]
- [Vectors and Matrices](#vectors-and-matrices)
  - [Basic Vector Operations](#basic-vector-operations)
    - [Vector Magnitude(백터의 크기)](#vector-magnitude백터의-크기)
    - [unit Vector](#unit-vector)
    - [Vector의 덧셈 및 곱셈에 관한 성질](#vector의-덧셈-및-곱셈에-관한-성질)
  - [Matrix(행렬) 의 기초](#matrix행렬-의-기초)
      - [Matrix Multiplication Transpose](#matrix-multiplication-transpose)
      - [antisymmetic matrix OR skew-symmetric matrix](#antisymmetic-matrix-or-skew-symmetric-matrix)
      - [벡터의 표기법](#벡터의-표기법)
  - [Vector Multiplication](#vector-multiplication)
    - [Dot Product (내적)](#dot-product-내적)
    - [Cross Product](#cross-product)
    - [Scalar Triple Product](#scalar-triple-product)


# Vectors and Matrices
## Basic Vector Operations
### Vector Magnitude(백터의 크기)
- 백터의 크기를 구하는 공식은 다음과 같다.

$$
\|V\| = \sqrt{\sum_{i=0}^{n-1} v_i^2}
$$

- 3-Dimensions(3차원 공간)에서 위 공식을 적용해 보면 $\|V\| = \sqrt{V_x^2 + V_y^2 + V_z^2}$ 으로 된다.  
- 벡터의 각각의 성분을 제곱해서 $\sqrt{}$ 연산을 하면 우리는 벡터의 크기를 구할 수 있다.

### unit Vector
- unit vector는 크기가 1인 벡터를 의미한다.  
- 방향성만 가진 벡터를 구하기 위한 방법이다. 벡터의 크기로 벡터를 나누어 주면 된다.  
- 우리는 이것을 Vector를 Normalize 했다고 한다.
공식은 아래와 같다. 

$$
 \hat{V} = \frac{V}{\|V\|}
$$

### Vector의 덧셈 및 곱셈에 관한 성질  

| 속성  |  설명  |
|---|---|
| $(a+b) + c = a + (b+c)$  |  덧셈에 관한 결합법칙 |
|$a+b = b+a$| 덧셈 교환법칙|
|$(st)a = s(ta)$| 스칼라 곱에 관한 결합 법칙|
|$ta = at$| 스칼라 곱에 관한 교환 법칙|
|$t(a+b) = ta +tb$|스칼라 곱에 대한 분배법칙|
|$(s+t)a = sa +ta$|스칼라 곱에 대한 분배법칙|

> 벡터 끼리의 곱셈에서 교환 법칙은 성립하지 않으며, 스칼라 곱에 대한 교환법칙만 존재 한다.

## Matrix(행렬) 의 기초

- A 행력과 B 행렬이 다음과 같다.  
A는 $n \times p$ 행렬 이고 B는 $p\times m$ 인 경우, i 와 j 번째 요소를 구하는 식은 다음과 같다.  

$$
    (AB)_{ij} = \sum_{k=0}^{p-1}A_{ik}B_{kj}
$$

#### Matrix Multiplication Transpose
- 행렬에서 곱셈을 Transpose 하는 공식은 다음과 같다.

$$
 (AB)_{ij}^T = \sum_{k=0}^{p-1}B_{ik}^{T}A_{kj}^{T}
$$

#### antisymmetic matrix OR skew-symmetric matrix  
-  반대칭 혹은 비대칭 행렬이라고 한다.  
- 공식은 $$M^{T}_{ij}=-M_{ij}$$ 이다.

$$
    \begin{bmatrix}
        0 & 1 & -4 \\[0.5em]
       -1 & 0 & 7 \\[0.5em]
       4 & -7 & 0 \\[0.5em]

    \end{bmatrix}
$$

#### 벡터의 표기법

> Column Vector  

$$
    v= (v_0, v_1, \dots, v_{n-1}) = \begin{bmatrix}
                                 v_0    \\
                                 v_1    \\
                                 \vdots \\
                                 v_{n-1}
                                 \end{bmatrix}
$$

> Row Vector  

$$
    v^T = \begin{bmatrix}
        v_0 & v_1 & \dots v_{n-1}
    \end{bmatrix}
$$

## Vector Multiplication
### Dot Product (내적)  

$$
    a \cdot b = \sum_{i=0}^{n-1}a_ib_i
$$

> 위 공식을 3차원 에서 적용해 보면 아래와 같다.  
> 각 성분끼리 곱해서 더한다.  

$a \cdot b = a_xb_x + a_yb_y + a_zb_z$

> 아래와 같이 표현 하기도 한다.  

$$a \cdot b = \begin{bmatrix}
                a_0 & a_1 & \dotsb & a_{n-1}
              \end{bmatrix}
              \begin{bmatrix}
                b_0 \\[0.2em]
                b_1 \\[0.2em]
                \vdots \\[0.2em]
                b_{n-1}                
              \end{bmatrix}
$$ 

> 벡터의 기하학적 의미 공식은  

$$
    a \cdot b = \|a\|\|b\|\cos\theta
$$  

여기서 우리가 알 수 있는 사실은 $\theta$ 가 $90^\circ$인 경우 내적의 값은 0이 되며,  
a 벡터와 b벡터가 직교하는 경우 내적의 값은 0이 된다는 것을 알수 있다.  


> 여기서 특별한 케이스인 자기 자신과 dot product는 아래와 같은 특징이 있다.

$$v^2 = V \cdot V = \|V\|^2$$

참고로 $\|V\|$ 는 아래와 같다. 

$$\|V\| = \sqrt{\sum_{i=0}^{n-1}v_i^2}$$

> 내적의 속성

|  속성  |  설명 |
|---|---|
|$a \cdot b = b \cdot a$| 교환 법칙  |
|$a \cdot (b+c) = a \cdot b + a \cdot c$| 분배 법칙  |
|$(ta)\cdot b = a \cdot (tb) = t(a \cdot b)$| 인수분해  |

### Cross Product

2개의 3차원 Vector에서 다음과 같은 공식

$$
    a \times b = (a_yb_z - a_zb_y, a_zb_x - a_xb_z, a_xb_y - a_yb_x)
$$

외적(Cross Product)는 특수한 3X3 비대칭 행렬을 정의해서 나타낼 수도 있다.

$$
    [a]_X = \begin{bmatrix}
                    0 & -a_z & a_y \\
                    a_z & 0 & -a_x \\
                    -a_y & a_x & 0

              \end{bmatrix}
$$

$$
    a \times b = [a]_Xb = \begin{bmatrix}
                    0 & -a_z & a_y \\
                    a_z & 0 & -a_x \\
                    -a_y & a_x & 0
                  \end{bmatrix}
                  \begin{bmatrix}
                      b_x \\
                      b_y \\
                      b_z
                  \end{bmatrix}
                   = 
                   \begin{bmatrix}
                       -a_zb_y + a_yb_z \\
                       a_zb_x - a_xb_z \\
                       -a_yb_x + a_xb_y \\
                   \end{bmatrix}
$$

> 외적의 크기 공식  

$$
    \|a \times b\| = \|a\| \|b\|\sin{\theta}
$$

>또한 외적의 크기는 기하학적 의미로는 평행사변형의 넓이에 해당 한다.  

![image](/assets/images/Graphics/parallelogram.png){:width="50%" height="50%"}

> 외적은 $a \times b = -b \times a$ **비가환성** 특징을 가진다.

> **외적의 속성**

| 속성  | 설명  |
|---|---|
| $a \times b = -b \times a$  |  외적의 비가환성 |
|$a \times (b + c) = a \times b + a \times c$| 외적의 분배법칙|
|$(ta)\times b = a \times (tb) = t(a \times b)$| 스칼라 인수분해|
|$a\times (b\times c) = b(a\cdot c) - c(a\cdot b)$| Vector triple product|
|$(a\times b)^2 = a^2b^2 - (a\cdot b)^2$| 라그랑주 항등식|

### Scalar Triple Product
순서에 상관없이 동일한 결과를 나타 냅니다.

$$
    [a,b,c] = (a\times b)\cdot c = (b\times c)\cdot a = (c\times a)\cdot b
$$

Scalar Triple Product의 기하학적 의미는 (parallelepiped)**평행육면체의 부피**와 같습니다.

![image](/assets/images/Graphics/parallelepiped.png){:width="30%" height="30%"}

위 그림으로 부터 아래와 같은 공식을 유도할 수 있습니다. ($\theta = 90-\varphi$)

$$
 (a\times b)\cdot c = \|{a\times b}\|\|c\|\cos\theta = \|a\times b|\|c\|\sin\varphi
$$
