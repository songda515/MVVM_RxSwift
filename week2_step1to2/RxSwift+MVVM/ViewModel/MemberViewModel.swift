//
//  ViewModel.swift
//  RxSwift+MVVM
//
//  Created by Dain Song on 2021/07/08.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift
//import RxCocoa

class MemberViewModel {

    static let shared = MemberViewModel() // singleton
    var members = BehaviorSubject<[Member]>(value: [])
    var selectedMember = Member.EMPTY

    init() {
        reloadData()
    }
    
    func reloadData() {
        // Observable<Data> --> subscribe --> members
        _ = APIManager.fetchData(url: APIManager.MEMBER_LIST_URL)
            .map { data -> [Member] in
                let members = try! JSONDecoder().decode([Member].self, from: data)
                return members
            }
            .take(1) // take(1) 네트워크 문제로 수행안될시 문제 없는지 ? -> 버튼 눌릴때마다 생성되어 // dispose 필요없는지?
            .subscribe(onNext: { self.members.onNext($0) })
        
        
        
            //.bind(to: members) // subscribe 로도 구현해보기 // bind vs subscribe ?
    }
}
