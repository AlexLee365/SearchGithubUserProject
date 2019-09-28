//
//  SingletonData.swift
//  SearchGithubUserProject
//
//  Created by 행복한 개발자 on 2019/09/28.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

class SingletonData {
    static var shared = SingletonData()
    
    var likedUsersIDArray = [Int]()
    var likedUsersArray = [User]()
}
