//
//  MemberCell.swift
//  RxSwift+MVVM
//
//  Created by Dain Song on 2021/07/09.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MemberCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        // cell reuse 시에 초기화되도록 작업하기
        avatarImage.image = nil
        disposeBag = DisposeBag()
    }
    
    func updateUI(member: Member) {
        setImage(url: member.avatar)
        nameLabel.text = "\(member.name)"
        jobLabel.text = "\(member.job)"
        ageLabel.text = "(\(member.age))"
    }
    
    func setImage(url: String) {
        APIManager.fetchData(url: url)
            .observe(on: MainScheduler.instance)
            .map({ data in
                return UIImage(data: data)!
            })
            .bind(to: avatarImage.rx.image)
            .disposed(by: disposeBag)
    }
}
