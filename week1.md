## MVVM + RxSwift 스터디 1주차 

- 강의 : [RxSwift+MVVM 4시간에 끝내기 [시즌2]](https://github.com/iamchiwon/RxSwift_In_4_Hours)

### 1주차 학습 정리
- 다나 : [강의 요약](https://www.notion.so/jellysong/MVVM-RxSwift-da9fa84cd45744d4bea4fcb79269f3a1)
- 하원 : [링크1](https://levenshtein.tistory.com/452) [링크2](https://levenshtein.tistory.com/454) [링크3](https://levenshtein.tistory.com/456)
- 경훈 : [링크](https://www.notion.so/Rxswift-MVVM-20917b6cfb8c4cf592eeeabe62e501a4)
- 건우 : [링크](https://rldd.tistory.com/category/iOS/RxSwift)

### 논의
1. Observable 생성 시 thread를 지정하지 않으면, 어느 thread 에서 돌게되는지?
  > - create 나 subscribe 하는 시점의 thread 를 따라간다.
  > - observeOn, subscribeOn 메소드를 이용해서 thread 를 지정해서 위험이 발생하지 않도록 하자.
2. Disposebag을 왜 쓰는지, disposable 을 왜 dispose 해야하는지?
  > - Disposebag은 disposables 을 하나하나 dispose 하는 것 대신 이용할 수 있다.
  > - disposables를 왜 dispose 해야하는지? subscribe 할 때 전달하는 closure 때문!
  > - closure는 내부의 변수를 캡쳐링하기 때문에, View Controller 가 사라지더라도 참조가 사라지지 않아 메모리에 남게 된다. 
  > - 순환 참조가 발생하지 않기 위해 Dispose 하는 것이며, [weak self] 를 이용하는 방법도 있다.
