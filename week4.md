## MVVM + RxSwift 스터디 4주차 

- Time-Based Operators
- Intro To Scheduler
- Cocoa GCD, Dispatch Queue

### 3주차 학습 정리
- 다나 : [W4. Time-Based Operators / Scheduler](https://www.notion.so/jellysong/W4-Time-Based-Operators-Scheduler-90c76a308cb3482b9e7727e925936c61)
- 건우 : [링크](https://rldd.tistory.com/category/iOS/RxSwift)

### 논의
1. share 사용되는 예시 더 알아보기
  > https://jusung.github.io/shareReplay/
2. "hot" and "cold" observables
  > - 🔥 Hot Observable
  >   - 구독과 상관없이 시퀀스가 시작되고, 구독하는 시점에 중간 아이템을 방출한다.
  >   - Live Streaming 방송을 생각해보자.
  >   - RxSwift 에서는 Timer, Subject, UIEvent 등
  > - 🧊 Cold Observable
  >   - 구독하는 시점에 시퀀스가 시작되고, 아이템을 방출한다.
  >   - VOD 방송을 생각해보자.
  >   - RxSwift 에서 보통 HTTP 요청으로 Observable 을 생성해 사용하는 경우
3. observeOn, subscribeOn misuse 
  > - 🔥 Hot observable 의 경우 구독과 관계없이 이벤트를 방출한다. 즉, 특정 시점부터 영구적으로 작동한다. hot observable 에 대해 구독하는 입장에서, observeOn 에 대해서는 자유롭게 사용 가능하지만. hot observable 이 자신만의 context(thread or scheduler) 를 가지고 있다면 그 context 는 RxSwift 가 컨트롤 할 수 없다고 한다.
  > - 🧊 cold 는 다시 정리          
