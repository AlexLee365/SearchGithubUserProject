//
//  UserListTableCell.swift
//  SearchGithubUserProject
//
//  Created by 행복한 개발자 on 2019/09/22.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import Kingfisher

class UserListTableCell: UITableViewCell {
    static let identifier = "UserListTableCell"

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var userLikeButton: UIButton!
    
    var userData: User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        userLikeButton.addTarget(self, action: #selector(userLikeButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func userLikeButtonDidTap() {
        userLikeButton.isSelected.toggle()
        
        guard let user = userData else { return }
        if let savedIndex = SingletonData.shared.likedUsersIDArray.firstIndex(of: user.id) {
            // 해당 아이디가 좋아요된 유저배열에 있으면 => 삭제
            SingletonData.shared.likedUsersIDArray.remove(at: savedIndex)
            SingletonData.shared.likedUsersArray.remove(at: savedIndex)
        } else {
            // 좋아요된 유저배열에 없으면 => 추가
            SingletonData.shared.likedUsersIDArray.append(user.id)
            SingletonData.shared.likedUsersArray.append(user)
        }
    }
    
    private func updateLikedUsersData() {
        
    }

    
    func setUserData(userData: User) {
        if let imageURL = URL(string: userData.avatarURL) {
            userImageView.kf.setImage(with: imageURL)
        }
        userNameLabel.text = userData.login
        userScoreLabel.text = "\(Int(userData.score)) 점"
        
        userLikeButton.isSelected = SingletonData.shared.likedUsersIDArray.contains(userData.id) ? true : false
    }
    
}
