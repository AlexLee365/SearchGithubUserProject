//
//  SearchUserViewController.swift
//  SearchGithubUserProject
//
//  Created by 행복한 개발자 on 2019/09/22.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import Alamofire

class SearchUserViewController: UIViewController {

    @IBOutlet weak var userListView: UserListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewsOptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        userListView.userListCollectionView.reloadData()
    }
    
    private func configureViewsOptions() {
        userListView.delegate = self
    }
    
    
    
    private func getServerData(searchText: String, completion: @escaping (UserList) -> ()) {
        let urlString = "https://api.github.com/search/users?q=\(searchText)in:login&per_page=10"
        
        guard let url = URL(string: urlString) else { print("‼️ : "); return }
        
        AF.request(url).responseDecodable { (result: DataResponse<UserList, AFError>) in
            
            guard let userListData = result.value else {
                print("‼️ userListArray convert Failed ")
                return
            }
            
            
            completion(userListData)
        }

    }
    
    
}

extension SearchUserViewController: UserListViewDelegate {
    func getSearchResult(searchText: String) {
        print("--------------------------[검색결과 with \(searchText)]--------------------------")
        
        getServerData(searchText: searchText) { (userListResult) in
            self.userListView.userList = userListResult
            userListResult.usersArray.forEach{
                print($0.login)
            }
            
            DispatchQueue.main.async {
                self.userListView.userListCollectionView.reloadData()
            }
        }
    }
    
    
}
