//
//  APIManager.swift
//  RxSwift+MVVM
//
//  Created by Dain Song on 2021/07/08.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift

class APIManager {
    
    static let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"
    
    // JSON url -> Observable<Data> // --(subscribe)--> Member model
    // Image url -> Observable<Data> // --(subscribe)--> UIImage
    
    static func fetchData(url: String) -> Observable<Data> {
        return Observable.create() { emitter in
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                // 데이터 수신 실패
                if let error = error {
                    emitter.onError(error)
                    return
                }
                // 데이터가 없을 때 http status code 전달
                guard let data = data else {
                    let httpResponse = response as! HTTPURLResponse
                    emitter.onError(NSError(domain: "no data", code: httpResponse.statusCode, userInfo: nil))
                    return
                }
                // 성공한 경우
                emitter.onNext(data)
                emitter.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel() // dispose 될 경우
            }
        }
    }
}
