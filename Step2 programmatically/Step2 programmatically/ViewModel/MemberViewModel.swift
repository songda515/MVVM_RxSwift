//
//  MemberViewModel.swift
//  Step2 programmatically
//
//  Created by Hani on 2021/07/18.
//

import Foundation
import RxSwift

class MemberViewModel {
    
    //static let shared = MemberViewModel()
    var members = BehaviorSubject<[Member]>(value: [])
    var disposeBag = DisposeBag()
    
    init(){
        APIService
            .loadMembers()
            .subscribe { self.members.onNext($0) }
            .disposed(by: disposeBag)
    }

}
