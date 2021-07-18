//
//  MemberCell.swift
//  Step2 programmatically
//
//  Created by Hani on 2021/07/05.
//

import UIKit
import RxSwift
import RxCocoa
class MemberCell: UITableViewCell {
    
    static let cellIdentifier = "\(MemberCell.self)"
    var disposeBag = DisposeBag()
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isOpaque = true
        imageView.clipsToBounds = true
        imageView.autoresizesSubviews = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .natural
        label.contentMode = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .natural
        label.contentMode = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .natural
        label.contentMode = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobAndAgeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.contentMode = .scaleToFill
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.autoresizesSubviews = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.contentMode = .scaleToFill
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.autoresizesSubviews = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let memberCellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 24
        stackView.contentMode = .scaleToFill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("asdasd")
    }
    
    func addView(){
        contentView.addSubview(memberCellStackView)
        
        memberCellStackView.addArrangedSubview(avatarImageView)
        memberCellStackView.addArrangedSubview(infoStackView)
        
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(jobAndAgeStackView)
    
        jobAndAgeStackView.addArrangedSubview(jobLabel)
        jobAndAgeStackView.addArrangedSubview(ageLabel)
    }
    
    func autoLayout(){
        NSLayoutConstraint.activate([
            memberCellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            memberCellStackView.trailingAnchor.constraint(equalTo:  contentView.trailingAnchor, constant: -20),
            memberCellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            memberCellStackView.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor,constant: 20),
            
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    public func configure(_ member: Member) {
        APIService.loadImage(from: member.avatar)
            .observe(on: MainScheduler.instance)
            .bind(to: avatarImageView.rx.image)
            .disposed(by: disposeBag)
        nameLabel.text = member.name
        jobLabel.text = member.job
        ageLabel.text = "(\(member.age))"
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.avatarImageView.image = nil
        disposeBag = DisposeBag()
        
        
        //모든 Cell 객체의 생명주기가 prepare for reuse에서 끝나기 때문에.
        //cell이 재사용될 때 바인딩이 초기화가 될 수 있도록
    }
}
