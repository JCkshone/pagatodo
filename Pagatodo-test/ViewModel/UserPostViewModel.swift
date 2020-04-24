//
//  UserPostViewModel.swift
//  ceiba-test
//
//  Created by Jc on 22/04/20.
//  Copyright © 2020 Jc. All rights reserved.
//

import Foundation

class UserPostViewModel {
    private let http = HttpManager.shareInstance
    var user: User?
    var posts: [Post] = []
    var handleDataLoadComplete: (()->())?
    
    struct Constants {
        static let postPath = "posts"
    }
    
    func loadUserPost() {
        guard let userId = user?.id else { return }
        http.getPost(by: "\(Constants.postPath)?userId=\(userId)") { posts in
            self.posts = posts
            self.handleDataLoadComplete?()
        }
    }
}
