//
//  APIService.swift
//  Step2 programmatically
//
//  Created by Hani on 2021/07/18.
//

import Foundation
import RxSwift

 let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"

class APIService {
    
    static func loadMembers() -> Observable<[Member]> {
        return Observable.create { emitter in

            let task = URLSession.shared.dataTask(with: URL(string: MEMBER_LIST_URL)!) { data, _, error in
                
                if let error = error {
                    emitter.onError(error)
                    return
                }
                
                guard let data = data,
                    let members = try? JSONDecoder().decode([Member].self, from: data) else {
                    emitter.onCompleted()
                    return
                }

                emitter.onNext(members)
                emitter.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }

    
    static func loadImage(from url: String) -> Observable<UIImage?> {
        return Observable.create { emitter in
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
                if let error = error {
                    emitter.onError(error)
                    return
                }
                guard let data = data,
                    let image = UIImage(data: data) else {
                    emitter.onNext(nil)
                    emitter.onCompleted()
                    return
                }

                emitter.onNext(image)
                emitter.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
