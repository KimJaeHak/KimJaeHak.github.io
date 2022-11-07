---
title: "Python 첫걸음"
categories:
 - python
tags:
 - Python, Python기초

toc: true
---

## File Open TextFile

- 텍스트 파일을 읽어서 전체 Line을 메모리 상에 올림
```py
#-*- encoding: utf8 -*-
import os as os
path = os.path.join(r"fullPath")
file = open(path)
lines = file.readlines()
```


## 배열에서 특정 값을 조건에 따라 바꾸는 방법1 (numpy를 이용)

```python
import numpy as np
#np를 이용하는 방법
arr = np.array([1,2,3,4,5,6])

# arr의 element의 값이 3과 같으면(조건에 부합하면) 1로 아니면 0으로 
# 값을 반환해 준다.
arr_changed = np.where(arr==3, 1, 0)

#print
#[0 0 1 0 0 0]
```

## 배열에서 특정 값을 조건에 따라 바꾸는 방법1 (Comprehension을 이용)

```python
arr = [1,2,3,4,5,6]
arr_changed = [True if x>3 else False for x in arr]
#print
#[False, False, False, True, True, True]
```

## matplotlib 그래프 활용법
```python
def f(t):
    return np.exp(-t) * np.cos(2*np.pi*t)

t1 = np.arange(0.0, 5.0, 0.1)
t2 = np.arange(0.0, 5.0, 0.02)

plt.figure()
plt.subplot(211)
plt.plot(t1, f(t1), 'bo', t2, f(t2), 'k')

plt.subplot(212)
plt.plot(t2, np.cos(2*np.pi*t2), 'r--')
plt.show()
```

## Contour Find
```python
def FindContours(layer , toContourValue, zIdx):
    filterdLayer = np.where(layer == toContourValue, 255, 0)
    return cv2.findContours(filterdLayer,cv2.RETR_CCOMP, cv2.CHAIN_APPROX_SIMPLE)
```

## Draw Contour (grey Scale)
```py
def ShowContourImage(contours, hierarchyIdx):
    img = np.zeros([height,width,1],dtype=np.uint8)
    cv2.drawContours(img, contours, -1, (255,255,255), 1)
    fig = plt.figure()
    rows = 1
    cols = 1
    ax2 = fig.add_subplot(rows,cols,1)
    ax2.imshow(img, cmap='gray', vmin=0, vmax=255)
    plt.show()
```

