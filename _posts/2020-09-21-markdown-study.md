---
title: "Mark Down 문법 정리"
categories:
 - markdown
tags:
 - markdown
 - markdown sytax
---

## 헷갈리는 문법 정리

### - **줄 바꿈**
보통 markdown에서 개행 할 때 문장의 마지막에 공백 문자를 두 번 넣는 것을 사용 할 수 있지만 `<br>` tag 을 넣어 주는것 이 좋다.
```markdown
줄 바꿈<br>
```
### - **Bold**
```md
I just love **bold text**.
I just love __bold text__.

```

### - **Italic**
```md
이것이 *italic* 입니다.
```
결과 : 이것이 *italic* 입니다.

### - **글자 색 변경**
MarkDown에서 글자 색 변경을 지원해 주지는 않는 듯 하다. 결국 `HTML`로 해결 하는 수 밖에 없음.
```md
<span style="color:blue">some *blue* text</span>.
```
결과 : <span style="color:blue">some *blue* text</span>.

### - **이미지**
```md
![imageName](/assets/images/tux.png)
```
결과 : ![imageName](/assets/images/tux.png)