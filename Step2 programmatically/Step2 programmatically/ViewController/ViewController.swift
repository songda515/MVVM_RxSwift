//
//  ViewController.swift
//  Step2 programmatically
//
//  Created by Hani on 2021/07/05.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    var members: [Member] = []
    var disposeBag = DisposeBag()
    let viewModel = MemberViewModel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.contentMode = .scaleAspectFill
        tableView.clipsToBounds = true
        tableView.autoresizesSubviews = true
        tableView.isOpaque = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
       return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "Members"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Members", style: .plain, target: self, action: nil)

        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.largeTitleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 36)
        ]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        
        
        setTableView()
        autoLayout()
        
        viewModel
            .members
            .filter { !$0.isEmpty }
            .bind(to: tableView.rx.items(cellIdentifier: MemberCell.cellIdentifier, cellType: MemberCell.self)) { _, item, cell in
            
               cell.configure(item)
           }
           .disposed(by: disposeBag)

        APIService.loadMembers()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { members in
                self.members = members
                self.tableView.reloadData() //main
            })
            .disposed(by: disposeBag)
    }
 
    func setTableView(){
        tableView.delegate = self
        tableView.register(MemberCell.self, forCellReuseIdentifier: MemberCell.cellIdentifier)
    }
    
    func autoLayout(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }

}

extension ViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.member = members[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

