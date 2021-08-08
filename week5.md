## MVVM + RxSwift 스터디 5주차 

- Beginning RxCocoa
- Intermediate RxCocoa

### 5주차 학습 정리
- 다나 : [W5. RxCocoa](https://jellysong.notion.site/W5-RxCocoa-590170add02443399ec7a8cf19d1701b)
- 건우 : [링크](https://rldd.tistory.com/category/iOS/RxSwift)

### 논의
1. RxCocoa 예제코드에서 URLSession.rx.data 메소드는 어떻게 구성되어있는지?
> - `URLSession.rx.data(request:)` 메소드를 통해 네트워킹 작업을 할 수 있다.
> - data 메소드의 인자는 URLRequest 타입이다.
> - data 메소드는 Observable<Data> 타입을 반환하는 메소드이다.
> - 기본적으로 200 ~ 300 statusCode 에 대한 에러 처리를 해준다.
> - [RxCocoa 라이브러리의 URLSession+Rx.swift](https://github.com/ReactiveX/RxSwift/blob/main/RxCocoa/Foundation/URLSession%2BRx.swift)
```swift
    public func data(request: URLRequest) -> Observable<Data> {
        return self.response(request: request).map { pair -> Data in
            if 200 ..< 300 ~= pair.0.statusCode {
                return pair.1
            }
            else {
                throw RxCocoaURLError.httpRequestFailed(response: pair.0, data: pair.1)
            }
        }
    }
```
2. Alamofire 라이브러리 이용시에 Rx를 적용하려면 어떻게 해야하는지?
> Alamofire의 경우, RxAlamofire 라이브러리로 Rx를 이용할 수 있다.
> https://github.com/RxSwiftCommunity/RxAlamofire
