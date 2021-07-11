//
//  DetailViewController.swift
//  RxSwift+MVVM
//
//  Created by Dain Song on 2021/07/11.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MemberDetailViewController: UIViewController {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var job: UILabel!
    @IBOutlet weak var age: UILabel!
    
    let viewModel = MemberViewModel.shared
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    // MARK: - Custom method
    func initUI() {
        let member = viewModel.selectedMember
        id.text = "ID : \(member.id)"
        name.text = member.name
        job.text = member.job
        age.text = "(\(member.age))"
        setImage(url: member.avatar) // binding
    }
    
    func setImage(url: String) {
        let orginalImageURL = url.replacingOccurrences(of: "size=50x50&", with: "")
        // Observable<Data> -> UIImage(data: )
        APIManager.fetchData(url: orginalImageURL)
            .observe(on: MainScheduler.instance)
            .map { UIImage(data: $0)! }
            .bind(to: avatarImage.rx.image)
            .disposed(by: disposeBag)
    }
}
