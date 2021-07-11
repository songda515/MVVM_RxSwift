//
//  Model.swift
//  RxSwift+MVVM
//
//  Created by Dain Song on 2021/07/08.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

struct Member: Codable {
    let id : Int
    let name: String
    let avatar: String
    let job: String
    let age: Int
}

extension Member {
    static let EMPTY = Member(id: 0, name: "name", avatar: "", job: "job", age: 0)
}
