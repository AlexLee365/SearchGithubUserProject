//
//  SaveUserViewController.swift
//  SearchGithubUserProject
//
//  Created by 행복한 개발자 on 2019/09/22.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit


class SaveUserViewController: UIViewController{
    
    @IBOutlet weak var userListView: UserListView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewsOptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let likedUserData = SingletonData.shared.likedUsersArray
        print(likedUserData)
        userListView.userList = UserList(totalCount: likedUserData.count, incompleteResults: false, usersArray: likedUserData)
        userListView.userListCollectionView.reloadData()
    }
    
    private func configureViewsOptions() {
        
//        userListView.searchTextField.isEnabled = false
        userListView.searchTextField.isUserInteractionEnabled = false
        userListView.searchButton.isEnabled = false
    }
    
    
    
}

