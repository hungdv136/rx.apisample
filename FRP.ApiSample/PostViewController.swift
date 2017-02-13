//
//  ViewController.swift
//  FRP.ApiSample
//
//  Created by Hung Dinh on 10/9/16.
//  Copyright © 2016 Chu Cuoi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class PostViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("Timeline", comment: "")
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        
        let seachBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        tableView.tableHeaderView = seachBar
        
        seachBar.rx.text
            .throttle(0.25, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { [weak self] text -> Observable<[Post]> in
                return self?.viewModel.getPosts(searchText: text).catchErrorJustReturn([]) ?? Observable.just([])
            }
            .bindTo(tableView.rx.items(cellIdentifier: "TableCell", cellType: UITableViewCell.self)) { (row, post, cell) in
                cell.textLabel?.text = "\(post.title)\n\(post.body)"
            }
            .addDisposableTo(disposeBag)
    }
    
    var viewModel: PostViewModel!
    private let disposeBag = DisposeBag()
}

