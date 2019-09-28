//
//  UserListCollectionCell.swift
//  SearchGithubUserProject
//
//  Created by 행복한 개발자 on 2019/09/28.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class UserListCollectionCell: UICollectionViewCell {
    static let identifier = "UserListCollectionCell"

    
    @IBOutlet weak var resultTableView: UITableView!
    
    var userListArray = [User]() {
        didSet {
            resultTableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViewsOptions()
    }
    
    private func configureViewsOptions() {
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.register(UINib(nibName: UserListTableCell.identifier, bundle: nil), forCellReuseIdentifier: UserListTableCell.identifier)
        resultTableView.separatorInset = .init(top: 0, left: 1000, bottom: 0, right: 0)
        resultTableView.rowHeight = 60
        resultTableView.keyboardDismissMode = .onDrag
    }

}


extension UserListCollectionCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userListCell = tableView.dequeueReusableCell(withIdentifier: UserListTableCell.identifier, for: indexPath) as! UserListTableCell
        
        let user = userListArray[indexPath.row]
        userListCell.userData = user
        userListCell.setUserData(userData: user)

        return userListCell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row != userListArray.count-1 else { return }
        cell.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
    }
}
