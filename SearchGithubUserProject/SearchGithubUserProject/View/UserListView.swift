//
//  UserListView.swift
//  SearchGithubUserProject
//
//  Created by 행복한 개발자 on 2019/09/22.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

protocol UserListViewDelegate: class {
    func getSearchResult(searchText: String)
}

class UserListView: UIView {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
//    @IBOutlet weak var resultTableView: UITableView!
    
    @IBOutlet weak var userListCollectionView: UICollectionView!
    
    weak var delegate: UserListViewDelegate?
    
    var userList: UserList?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibInit()
        configureViewsOptions()
    }
    
    private func xibInit() {
        guard let xibName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last else {
            print("‼️ xibName extraction Failed ")
            return
        }

        guard let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as? UIView else {
            print("‼️ loadNib From Name Failed ")
            return
        }

        view.frame = self.bounds
        self.addSubview(view)
        
    }
    
    private func configureViewsOptions() {
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldEidtingChanged), for: .editingChanged)
        searchTextField.autocorrectionType = .no
        searchTextField.autocapitalizationType = .none
        
        searchButton.addTarget(self, action: #selector(searchButtonDidTap(_:)), for: .touchUpInside)
        
        userListCollectionView.delegate = self
        userListCollectionView.dataSource = self
        userListCollectionView.register(UINib(nibName: UserListCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: UserListCollectionCell.identifier)
        
        
    }
    
    @objc private func searchButtonDidTap(_ sender: UIButton) {
        
        delegate?.getSearchResult(searchText: searchTextField.text ?? "")
    }
    
}

extension UserListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cellCount = userList?.totalCount ?? 1
        return (cellCount % 10 == 0) ? cellCount/10 : (cellCount/10 + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserListCollectionCell.identifier, for: indexPath) as! UserListCollectionCell
        
        guard let userListData = userList else {
            print("userListData convert failed")
            return cell
        }
        
        cell.userListArray = userListData.usersArray
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        return cellSize
    }
    
    
}



extension UserListView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    @objc private func textFieldEidtingChanged(_ sender: UITextField) {
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.getSearchResult(searchText: textField.text ?? "")
        return true
    }
    
    
}



