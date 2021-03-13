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

toc: true
toc_sticky: true
---

# Vectors and Matrices
## Basic Vector Operations
### Vector Magnitude(백터의 크기)
- 백터의 크기를 구하는 공식은 다음과 같다.

$$
\|V\| = \sqrt{\sum_{i=0}^{n-1} V_i^2}
$$

- 3-Dimensions(3차원 공간)에서 위 공식을 적용해 보면 $\|V\| = \sqrt{V_x^2 + V_y^2 + V_z^2}$ 으로 된다.  
- 벡터의 각각의 성분을 제곱해서 $\sqrt{}$ 연산을 하면 우리는 벡터의 크기를 구할 수 있다.

### unit Vector
- unit vector는 크기가 1인 벡터를 의미한다. 방향성만 가진 벡터를 구하기 위한 방법이다. 벡터의 크기로 벡터를 나누어 주면 된다. 공식은 아래와 같다.

$$
 \hat{V} = \frac{V}{\|V\|}
$$

