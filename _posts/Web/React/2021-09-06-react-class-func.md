---
title: "리액트 클래스 스타일 vs. 함수 스타일 편"
categories:
 - React
tags:
 - React
toc: true
toc_sticky: true
---

## 클래스 스타일과 함수 스타일 비교


```react
function App() {
  return (
    <div className="container">
      <h1>Hello World</h1>
      <FuncComp></FuncComp>
      <ClassComp></ClassComp>
    </div> 
  );
}
```

> 함수형

```react
function FuncComp(){
  return (
    <div className="container">
      <h2>function style component</h2>
    </div>
  );
}
```

> 클래스형

```react
class ClassComp extends React.Component{
  render(){
    return (
      <div className="container">
        <h2>class style component</h2>
      </div>
    )
  }
}
```

## Props 사용법

```react
function App() {
  return (
    <div className="container">
      <h1>Hello World</h1>
      <FuncComp initNumber={2}></FuncComp>  //props 전달
      <ClassComp initNumber={2}></ClassComp>
    </div> 
  );
}

function FuncComp(props){ //함수형에서는 첫 번째 파라미터가 props로 약속되어 있음
  return (
    <div className="container">
      <h2>function style component</h2>
      <p>Number : {props.initNumber}</p>
    </div>
  );
}

class ClassComp extends React.Component{
  state = {
    number:this.props.initNumber  //클래스형 에서는 객체로 정의해 주고 사용함
  }
  render(){
    return (
      <div className="container">
        <h2>class style component</h2>
        <p>Number : {this.props.number}</p>
      </div>
    )
  }
}
```

## state 사용법
State는 예전에는 클래스 방식에서만 사용 할 수 있었다.  
하지만 현재는 **Hook**을 통해서 함수형 방식 에서도 사용 할 수 있게 되었다.  

> Hook에 대해서 먼저 알아 보자

### Hook 이란?
- React 16.8에 새로 추가 됨
- useXXXX로 시작된다.
- 내장 Hook도 있고, 사용자가 hook을 정의 할 수도 있다.

> 함수형 에서 state 사용법

```react
function FuncComp(props){
  var numberState = useState(props.initNumber); //state의 초기값을 설정
  var number = numberState[0];  //0번째 index가 state의 값
  var setNumber = numberState[1]; //1번째 index는 state값을 바꿀 수 있는 함수가 들어 있음

  setNumber(2) // state 값이 2로 바뀐다.
  ...
}
```

>좀더 간결하게 useState를 아래와 같이 표현 할 수 도 있다.

```react
var [numberState, setNumber] = useState(props.initNumber); //3줄짜리 코드를 한줄로 줄일 수 있다.
```

## 라이프 사이클
> 라이프 사이클 순서도

<img src="/assets/images/Web/React/react-life-cycle.png" width="50%">

### 클래스형 에서 라이프 사이클 이용
위 이 그림의 함수를 동일한 이름으로 구현하면, 특정 시점에 동작 하게 된다.
```react
class ClassComp extends React.Component{
  state = {
    number:this.props.initNumber,
    date:(new Date()).toString()
  }
  componentWillMount(){
    console.log('%cclass => componentWillMount', classStyle);
  }
  componentDidMount(){
    console.log('%cclass => componentDidMount', classStyle);
  }
  shouldComponentUpdate(nextProps, nextState){
    console.log('%cclass => shouldComponentUpdate', classStyle);
    return true;
  }
  componentWillUpdate(nextProps, nextState){
    console.log('%cclass => componentWillUpdate', classStyle);
  }
  componentDidUpdate(nextProps, nextState){
    console.log('%cclass => componentDidUpdate', classStyle);
  }
  ...
}
```

### 함수형 에서 라이프 사이클 이용
예전에는 사용할 수 없었지만, Hook을 이용해서 함수형 에서도 라이프 사이클이 동작 가능 하도록 함

`UseEffect` 를 사용 함
```react
function FuncComp(props){
  var numberState = useState(props.initNumber);
  var number = numberState[0];
  var setNumber = numberState[1];
  
    useEffect(function(){
        //TODO:
    }

  ...
}
```

UseEffect는 Function의 return function을 정의 해서 정리? 함수를 호출 할 수 있도록 해준다.

```react
  useEffect(function(){
    //TODO:
    return function(){
      //TODO: 정리 함수 내용  
    }
  });
```

성능을 위해서 값이 달라 졌을때만 호출 하도록 할 수 도 있다.
```react
function FuncComp(props){
  var numberState = useState(props.initNumber);
  var number = numberState[0];
  var setNumber = numberState[1];

  useEffect(function(){
    //TODO:
    document.title = number;
    return function(){
      //TODO:
    }
  }, [number]); //number가 다른 값인 경우에만 호출 된다.

  ...
}
```

## Summary