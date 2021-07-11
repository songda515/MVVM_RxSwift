## MVVM + RxSwift 스터디 2주차 

- 곰튀김님 강의 : [RxSwift+MVVM 4시간에 끝내기 [시즌2]](https://github.com/iamchiwon/RxSwift_In_4_Hours)

### 2주차 학습 정리
- 다나 : [곰튀김님 강의 Ex1 > Ex2로 변경해보기 - 포스팅 예정](https://www.notion.so/jellysong/W2-RxSwift-8ff138f8c27344fa82a2969b2803befd)
- 하원 : [[RxSwift] Closure ARC / Memory Leak 실험](https://levenshtein.tistory.com/470) [subscribe, observe / thread 관리](https://levenshtein.tistory.com/471)
- 건우 : [링크](https://rldd.tistory.com/category/iOS/RxSwift)

### 논의
1. Disposable을 disposeBag에 넣음에도 클로저의 [weak self] 써야하는 것인지?
  > - 예를 들어, completed를 하지않는 Observable의 경우
  > - disposable 을 disposeBag에 넣더라도, 순환 참조로 인해 View Controller 가 deinit 되지 않아 메모리 해제가 되지 않는다.
  > - UI 작업 등 계속 유지되어 completed 를 하지않는 경우에는 [weak self] 를 함께 고려해주자.
  > - 자세한 실험 결과는 하원님 링크 참고 👀
2. observable = sequence = stream 라고 하는데, stream이 무엇인지? 
  > - 마블다이어그램에서 화살표로 나타내는 일종으 흐름을 stream 이라고 하는것같다. 
3. Subject 종류 중 variable 은 무엇인지?
  > - Sopt 스터디에서 정리한 문서 중 Subject 종류로 variable 이 있지만, reactive.io 문서에서 설명하는 4가지 Subject 에는 async, publish, behavior, replay 로 variable 은 존재하지 않는다.
  > - RxSwift4.0 부터 variable 은 deprecated 되어 BehaviorRelay 가 새로나오게 되었다고 한다.
  > - 현재도 사용되는 것인지 건우님이 조사예정 👀
4. Observable 을 hot, cold 라고 부르는 것이 무엇인지?
  > - 다나님이 조사예정 👀
5. Observable 생성 시 thread를 지정하지 않으면, 어느 thread 에서 돌게되는지? (1주차 논의)
  > - 하원 링크 참고
