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

 > #### - Head Element

<p align="left">
<img src="/assets/images/auto/2023-05-29-03-09-05.png" onclick="window.open(this.src)" width="60%">
</p>

>Body Element

<p align="left">
<img src="/assets/images/auto/2023-05-29-03-31-39.png" onclick="window.open(this.src)" width="60%">
</p>

> #### - Reference Text

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

> #### - Styling Text

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

> #### - Types of Lists

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

> #### - Linking Document

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
```

> #### - Tables and Data

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

<p align="left">
<img src="/assets/images/auto/2023-05-30-07-01-41.png" onclick="window.open(this.src)" width="80%">
</p>

<br>
# CSS
<hr/>
## - Selector(선택기)
1. 요소 선택기 (Element Selector)
```css
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


