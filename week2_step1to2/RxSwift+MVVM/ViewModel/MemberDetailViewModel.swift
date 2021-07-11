//
//  MemberDetailViewModel.swift
//  RxSwift+MVVM
//
//  Created by Dain Song on 2021/07/11.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

class MemberDetailViewModel {
    
    static let shared = MemberDetailViewModel()
    var member: Member
    
    init() {
        member = Member.EMPTY
    }
    
}
