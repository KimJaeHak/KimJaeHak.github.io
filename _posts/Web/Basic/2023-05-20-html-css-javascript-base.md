---
title: "HTML & CSS & Javascript 기초"
categories:
 - Html
tags:
 - Html 
 - Html tag
 - css
 - javascript
toc: true
toc_sticky: true
---

- [HTML](#html)
  - [- Getting Started](#--getting-started)
    - [- 개발 환경 셋팅](#--개발-환경-셋팅)
    - [- Html Fundmental](#--html-fundmental)
      - [- Head Element](#--head-element)
      - [- Reference Text](#--reference-text)
      - [- Styling Text](#--styling-text)
      - [- Types of Lists](#--types-of-lists)
      - [- Link](#--link)
      - [- Tables and Data](#--tables-and-data)
      - [- List](#--list)
      - [- Special Characters](#--special-characters)
      - [- Image](#--image)
- [CSS](#css)
  - [- Selector(선택기)](#--selector선택기)
- [JavaScript](#javascript)
- [Resources \[관련 자료 Link\]](#resources-관련-자료-link)
  - [- HTML](#--html)
  - [- CSS](#--css)
  - [- JavaScript](#--javascript)
  - [- Tools](#--tools)


<br>
# HTML
<hr/>
## - Getting Started
### - 개발 환경 셋팅
- [codePen.io](https://codepen.io/pen)는 Html & CSS & JavaScript의 Web Editor 주소 이다.
- 최고의 무료 개발 Tool 
  - Visual Studio Code 를 설치 
  - Live Server 확장 기능 설치  
![](/assets/images/auto/2023-05-20-02-01-10.png)

### - Html Fundmental

> html5의 기본 구조

```html
  <!DOCTYPE html>
  <html lang="en">
  <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Document</title>
  </head>
  <body>
      
  </body>
  </html>
```

#### - Head Element

<p align="left">
<img src="/assets/images/auto/2023-05-29-03-09-05.png" onclick="window.open(this.src)" width="60%">
</p>

>Body Element

<p align="left">
<img src="/assets/images/auto/2023-05-29-03-31-39.png" onclick="window.open(this.src)" width="60%">
</p>

#### - Reference Text

<p align="left">
<img src="/assets/images/auto/2023-05-29-03-55-53.png" onclick="window.open(this.src)" width="60%">
</p>

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Wired Brain Coffee</title>
</head>
<body>
    
    <header>
            <h1>Wired Brain Coffee</h1>
            <h2>Coffee to keep your brain wired</h2>
    </header>
    <article title="Wired Brain Coffee">

   
    <section id="main">
        At Wired Brain Coffee, we believe that coffee can be the fuel your active brain needs.

        <p>Coffee has long been known to provide a boost to brain activity and increase blood flow. </p>
        <p>Another dubious statement about coffee to try and sell it</p>
       
    </section>

    <section id="testimonials">
        <h4>Testimonials</h4>
        <hr />
        <blockquote cite="http://www.wiredbraincoffee.com/testimonials/test1.html"><abbr title="Wired Brain">WB</abbr> coffee makes my brain feel like it was on fire!</blockquote>
        <cite>Brenda &lt;Hoboken, NJ&gt;</cite>
        
        <p>
            <q>I'm productive<sup>3</sup> when I drink this coffee!</q>
            &nbsp; <!--<br />-->
            <cite>Jamal &lt;Chicago, IL&gt;</cite>
        </p>

    </section>
    </article>
    <footer>
        &copy; Matt Milner
    </footer>
</body>
</html>
```

<p align="left">
<img src="/assets/images/auto/2023-05-30-05-36-38.png" onclick="window.open(this.src)" width="80%">
</p>

#### - Styling Text

```html
<style>
span.important {
color:red;
}
</style>

Our cups are labeled with
<span class="important">Warning: Coffee is hot!</span>
to help keep you safe.
```
<p align="left">
<img src="/assets/images/auto/2023-05-30-05-38-54.png" onclick="window.open(this.src)" width="80%">
</p>

#### - Types of Lists

- UnOrder List

```html
  <ul>
    <li>2 T Wired Brain Coffee Hot Cocoa Mix</li>
    <li>8 oz Milk</li>
    <li>Marshmallows (optional)</li>
  </ul>
```

- Order List

```html
<ol>
  <li>Scoop Hot Cocoa Mix into a mug.</li>
  <li>Heat milk on the stove or in the microwave to just below a boil</li>
  <li>Pour milk into the mug, stirring gently as you pour.</li>
  <li>Stir until mix is fully dissolved in the milk.</li>
  <li>Top with marshmallows if you must.</li>
</ol>
```

- Definition List

```html
<dl>
  <dt>Cocoa</dt>
  <dd>Cocoa is the powdered substance left after processing cacao beans and has little or now cacoa  butter.</dd>
  
  <dt>Chocolate</dt>
  <dd>Chocolate is basically cocoa with the cacoa butter and often sugar and milk.</dd>
</dl>
```

- Sytle List

```html
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
  <ol class="breadcrumb">
      <li class="breadcrumb-item">Wired Brain Coffee</li>
      <li class="breadcrumb-item">Recipes</li>
      <li class="breadcrumb-item active">Hot Cocoa</li>
  </ol>
</body>
```

#### - Link

```html
//외부 URL에 대한 link , target : 새창으로 열기
<a href="https://pluralsight.com/" target="_blank" rel="noreferrer noopener">

//내부 경로에 대한 link
<a href="./content/recipes.html">Recipes</a>

//Reference local anchor
<a href="#loc2">Location 2</a>

<div id=“locations”>
  <div id="loc1">First</div>
  <div id="loc2">Second</div>
</div>

// Reference anchor in another document
<a href="locations.html#loc2"></a>

//Mail
<p>Contact us via <a href="mailto:info@bethanyspieshop.com">email</a></p>

//Down Load
<p>Download our full <a href="downloads/Price list.zip">price list</a></p>
```

#### - Tables and Data
  
```html
        <table >
            <caption>Wired Brain Nutrition Information</caption>
            <thead>
              <tr>
                  <th rowspan="2">Drink</th>
                  <th></th>
                  <th></th>
                  <th></th>
                  <th></th>
                  <th colspan="2">Carbohydrates</th>
                      
                </tr>
                <tr>
                    <th>Serving Size</th>
                    <th>Calories</th>
                    <th>Fat (g)</th>
                    <th>Protein (g)</th>
                    <th>Sugar (g)</th>
                    <th>Fiber (g)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                        <td>Hot Cocoa</td>
                        <td>8 oz</td>
                        <td>250</td>
                        <td>5</td>
                        <td>2</td>
                        <td>25</td>
                        <td>0</td>
                </tr>
                <tr>
                        <td>Mocha</td>
                        <td>8 oz</td>
                        <td>250</td>
                        <td>5</td>
                        <td>2</td>
                        <td>25</td>
                        <td>0</td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td>Max</td>
                    <td></td>
                    <td>250</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
```

>Simple Table Style

```html
        table,
        td,
        th {
            border: 1px solid black;
            border-collapse: collapse;
            padding: 5px;
        }
```

<p align="left">
<img src="/assets/images/auto/2023-05-30-07-01-41.png" onclick="window.open(this.src)" width="70%">
</p>

#### - List

- ol: ordered list
- ul: unordered list
- li: list item

> Example

```html
<!-- 순서가 있는 -->
<ol>
    <li>
      첫 번째
    </li>
    <li>
      두 번째
    </li>
    <li>
      세 번째
    </li>
</ol>

<!-- 순서가 없는 -->
<ul>
    <li>Butter</li>
    <li>Eggs</li>
    <li>Sugar</li>
    <!-- 하위 목록 -->
    <ul>
        <li>Regular sugar</li>
        <li>Brown sugar</li>
        <li>Caster sugar</li>
    </ul>
    <li>Flour</li>
    <li>Cinnamon</li>
    <li>Ginger</li>
    <li>Nutmeg</li>
    <li>Apples</li>
    <li>Lemons</li>
</ul>
```

#### - Special Characters

> 주요 특수문자
- 아래 이외에도 많은 특수 문자가 있고 찾아 보면 된다.

```
&lt; : < (less than)
&gt; : > (greater than)
&amp; : & (ampersand)
&quot; : " (double quote)
&apos; : ' (single quote)

[수학/논리 기호]:
&plus; : + (plus sign)
&minus; : − (minus sign)
&times; : × (multiplication sign)
&div; : ÷ (division sign)
&ne; : ≠ (not equal to)
&le; : ≤ (less-than or equal to)
&ge; : ≥ (greater-than or equal to)

[화폐 기호]:
&cent; : ¢ (cent sign)
&pound; : £ (pound sign)
&yen; : ¥ (yen sign)
&euro; : € (euro sign)

[기타 기호]:
&copy; : © (copyright sign)
&reg; : ® (registered sign)
&trade; : ™ (trade mark sign)
&sect; : § (section sign)
&para; : ¶ (pilcrow sign)
&deg; : ° (degree sign)

[발음 기호]:
&uml; : ¨ (diaeresis)
&acute; : ´ (acute accent)
&grave; : ` (grave accent)
&circ; : ˆ (circumflex accent)
&tilde; : ˜ (small tilde)

```

#### - Image

```html
<img
  src=“wired-brain-coffee-logo.png”
  alt=“wiredbraincoffee.com”
  srcset="logo.png 500w, logo-250.png 250w"
  sizes="(max-width: 30em) 25vw, 33vw"/>
```

`<img>`:  
이 태그는 웹 페이지에 이미지를 삽입하는데 사용됩니다.

`style="float:left"`:  
이 부분은 CSS 스타일을 적용하는데 사용되며, 이미지를 화면의 왼쪽에 정렬하도록 설정합니다.

`src="content/wired-brain-coffee-logo.png"`:  
src 속성은 브라우저가 이미지를 어디에서 찾아야 하는지를 알려주는 속성입니다. 여기서는 "content"라는 폴더 내의 "wired-brain-coffee-logo.png" 이미지 파일을 참조하고 있습니다.

`alt="Wired Brain Coffee Logo"`:  
alt 속성은 이미지가 로드되지 않을 때 또는 사용자가 스크린 리더를 사용하는 경우에 표시되는 대체 텍스트입니다.

`srcset`:  
이 속성은 브라우저가 디스플레이의 해상도에 따라 로드해야 할 이미지 버전을 선택할 수 있게 합니다. 여기서는 500w와 250w의 두 가지 버전의 이미지가 제공되고 있습니다.

`sizes`:  
이 속성은 각 미디어 조건(화면 크기 등)에 대한 최적의 이미지 크기를 지정합니다. 여기서는 화면 크기가 500px 이하일 때 이미지가 뷰포트의 25%를 차지하도록, 그렇지 않을 경우 뷰포트의 50%를 차지하도록 설정되어 있습니다.

<br>
# CSS
<hr/>
## - Selector(선택기)
1. 요소 선택기 (Element Selector)
```**css**
  p {
      color: blue;
  }
```

1. 클래스 선택기 (Class Selector)
```css
.myClass {
    color: red;
}
```

1. ID 선택기 (ID Selector)
```css
#myID {
    color: green;
}
```

5. 속성 선택기 (Attribute Selector)
```css
a[target="_blank"] {
    color: purple;
}
```

6. 자식 선택기 (Child Selector)
```css
div > p {
    color: orange;
}
```

7. 후손 선택기 (Descendant Selector)
```css
div p {
    color: yellow;
}
```

8. 인접 형제 선택기 (Adjacent Sibling Selector)
```css
h1 +
```
<br>

# JavaScript



<hr/>

# Resources [관련 자료 Link]
<hr/>
## - HTML

- [Overview](https://developer.mozilla.org/docs/Web/HTML)
- [`doctype` element](https://developer.mozilla.org/docs/Web/HTML/Quirks_Mode_and_Standards_Mode)
- [Elements](https://developer.mozilla.org/docs/Web/HTML/Element)
- [What is the difference between HTML tags and elements?](https://stackoverflow.com/questions/8937384/what-is-the-difference-between-html-tags-and-elements)
- [HTML tags vs. elements vs. attributes](https://www.456bereastreet.com/archive/200508/html_tags_vs_elements_vs_attributes/)
- Images
  - [`img` element](https://developer.mozilla.org/docs/Web/HTML/Element/Img)
  - [Responsive images](https://developer.mozilla.org/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images)
- [Links (anchor element)](https://developer.mozilla.org/docs/Web/HTML/Element/a)
- Tables
  - [`table` element](https://developer.mozilla.org/docs/Web/HTML/Element/table)
  - [Table basics](https://developer.mozilla.org/docs/Learn/HTML/Tables/Basics)
- Forms
  - [`form` element](https://developer.mozilla.org/docs/Web/HTML/Element/form)
  - [`input` element](https://developer.mozilla.org/docs/Web/HTML/Element/Input)
  - [`label` element](https://developer.mozilla.org/docs/Web/HTML/Element/label)
  - [Form basics](https://developer.mozilla.org/docs/Learn/Forms)
  - [Sending data](https://developer.mozilla.org/docs/Learn/Forms/Sending_and_retrieving_form_data)
  - [Difference between `name` and `id` attributes](https://stackoverflow.com/questions/1397592/difference-between-id-and-name-attributes-in-html)
  - [Validation](https://developer.mozilla.org/docs/Learn/Forms/Form_validation)
- [Using the viewport meta tag to control layout on mobile browsers](https://developer.mozilla.org/docs/Mozilla/Mobile/Viewport_meta_tag)
- [`meta` element](https://developer.mozilla.org/docs/Web/HTML/Element/meta)
  - [`http-equiv` attribute](https://stackoverflow.com/questions/6771258/what-does-meta-http-equiv-x-ua-compatible-content-ie-edge-do)

## - CSS

- [Overview](https://developer.mozilla.org/docs/Web/CSS)
- [`style` element](https://developer.mozilla.org/docs/Web/SVG/Element/style)
- [`link` element](https://developer.mozilla.org/docs/Web/HTML/Element/link)
- [How cascading works](https://developer.mozilla.org/docs/Learn/CSS/Building_blocks/Cascade_and_inheritance)
- [Selectors](https://developer.mozilla.org/docs/Learn/CSS/Building_blocks/Selectors)
  - [Cheat sheet](https://frontend30.com/css-selectors-cheatsheet/)
- [Layout techniques](https://developer.mozilla.org/docs/Learn/CSS/CSS_layout/Introduction)
- [Beginner's guide to media queries](https://developer.mozilla.org/docs/Learn/CSS/CSS_layout/Media_queries)

## - JavaScript

- [Overview](https://developer.mozilla.org/docs/Web/javascript)
- [`script` element](https://developer.mozilla.org/docs/Web/HTML/Element/script)
- [Client-side APIs](https://developer.mozilla.org/docs/Learn/JavaScript/Client-side_web_APIs/Introduction)
- [`DOMContentLoaded` event](https://developer.mozilla.org/docs/Web/API/Document/DOMContentLoaded_event)
- [List of Web APIs](https://developer.mozilla.org/docs/Web/API)
- [Web Storage](https://developer.mozilla.org/docs/Web/API/Web_Storage_API)
  - localStorage
- Geolocation
  - [API](https://developer.mozilla.org/docs/Web/API/Geolocation_API)
  - [`getCurrentPosition` method](https://developer.mozilla.org/docs/Web/API/Geolocation/getCurrentPosition)
  - [`GeolocationPosition` interface](https://developer.mozilla.org/docs/Web/API/GeolocationPosition)
  - [`GeolocationCoordinates` interface](https://developer.mozilla.org/docs/Web/API/GeolocationCoordinates)

## - Tools

- [Visual Studio Code](https://code.visualstudio.com/)
- [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer)
- [Can I Use](https://caniuse.com/)
- [HTML Validator](https://validator.w3.org/)
- [CSS Validator](http://www.css-validator.org/)
- [20 Best Emmet Tips to Help You Code HTML/CSS Crazy Fast](https://beebom.com/best-emmet-tips-to-code-htmlcss-fast/)


