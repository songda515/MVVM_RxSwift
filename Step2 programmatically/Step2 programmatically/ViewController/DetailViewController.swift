//
//  DetailViewController.swift
//  Step2 programmatically
//
//  Created by Hani on 2021/07/05.
//

import UIKit
import RxSwift
import RxCocoa
class DetailViewController: UIViewController {
    
    lazy var member: Member? = nil
    var disposeBag = DisposeBag()

    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isOpaque = true
        imageView.clipsToBounds = true
        imageView.autoresizesSubviews = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.contentMode = .scaleToFill
        stackView.autoresizesSubviews = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Detail"
       
        addView()
        autoLayout()
        configure(member!)
        
    }
    
    func addView(){
        view.addSubview(detailStackView)
        
        detailStackView.addArrangedSubview(avatarImageView)
        detailStackView.addArrangedSubview(idLabel)
        detailStackView.addArrangedSubview(nameLabel)
        detailStackView.addArrangedSubview(jobLabel)
        detailStackView.addArrangedSubview(ageLabel)
    }
    
    func autoLayout(){
        NSLayoutConstraint.activate([
            detailStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            detailStackView.trailingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            detailStackView.leadingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
         
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1)
        ])
        
    }

    public func configure(_ member: Member) {
        Observable.just(member.avatar)
            .map { $0.replacingOccurrences(of: "size=50x50&", with: "") }
            .flatMap(APIService.loadImage)
            .observe(on: MainScheduler.instance)
            .bind(to: avatarImageView.rx.image)
            .disposed(by: disposeBag)
        avatarImageView.image = nil
        idLabel.text = "#\(member.id)"
        nameLabel.text = member.name
        jobLabel.text = member.job
        ageLabel.text = "(\(member.age))"
    }
    
}


