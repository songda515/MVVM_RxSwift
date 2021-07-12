//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let viewModel = MemberViewModel.shared
    let disposeBag = DisposeBag()
    let cellId = "MemberCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setTimer()
        setBinding()
    }
    
    // MARK: - Custom method

    private func setTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }
    
    private func setBinding() {
        
        // tableView datasource -- 데이터 개수, 셀에 들어갈 내용
        viewModel.members
            .observe(on: MainScheduler.instance)
            .filter { !$0.isEmpty }
            .bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: MemberCell.self)) { index, item, cell in
                cell.updateUI(member: item)
            }
            .disposed(by: disposeBag)

        // activityIndicator
        viewModel.members
            .observe(on: MainScheduler.instance)
            .map { $0.isEmpty }
            .subscribe(onNext: { [weak self] visible in
                self?.setVisibleWithAnimation(self?.activityIndicator, visible)
            })
            .disposed(by: disposeBag)
        
        // tableView delegate
        // tableView.rx.itemSelected -> indexPath
        tableView.rx.modelSelected(Member.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] member in
                self?.presentDetail(of: member)
            })
            .disposed(by: disposeBag)
    }

    private func setVisibleWithAnimation(_ v: UIView?, _ s: Bool) {
        guard let v = v else { return }
        UIView.animate(withDuration: 0.3, animations: { [weak v] in
            v?.isHidden = !s
        }, completion: { [weak self] _ in
            self?.view.layoutIfNeeded()
        })
    }
    
    private func presentDetail(of member: Member) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "MemberDetailViewController") as? MemberDetailViewController else {
            return
        }
        viewModel.selectedMember = member
        present(detailVC, animated: true, completion: nil)
    }
    
    // MARK: - IBActions

    @IBAction func onLoad() {
        setVisibleWithAnimation(activityIndicator, true)
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        viewModel.reloadData()
    }
}
