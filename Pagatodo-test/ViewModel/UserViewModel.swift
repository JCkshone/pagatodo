//
//  UserViewModel.swift
//  ceiba-test
//
//  Created by Jc on 22/04/20.
//  Copyright © 2020 Jc. All rights reserved.
//

import Foundation

class UserViewModel {
    private let http = HttpManager.shareInstance
    private var coreManager: CoreManager!
    
    var users: [User] = []
    var filterUsers: [User] = []
    var handleDataLoadComplete: (()->())?
    var handleSearchComplete: (()->())?
    var userEntities: [UserEntity] = []
    
    init(appDelegate: AppDelegate) {
        coreManager = CoreManager(delegate: appDelegate)
    }
    
    
    struct Constants {
        static let userPath = "users"
    }
    
    private func load() {
        http.getUsers(from: Constants.userPath) { users in
            self.users = users
            self.filterUsers = users
            self.handleDataLoadComplete?()
            self.coreManager.createData(users: users)
        }
    }
    
    func loadUsers() {
        let items = coreManager.getAll()
        if items.count == 0 {
            load()
            return
        }
        
        items.forEach { item in
            guard
                let lat   = item["lat"] as? String,
                let lng   = item["lng"] as? String,
                let id    = item["id"] as? Int,
                let name  = item["name"] as? String,
                let phone = item["phone"] as? String,
                let email = item["email"] as? String
                else { return }
            
            
            let geo = Geo(lat: lat, lng: lng)
            let address = Address(street: "", suite: "", city: "", zipcode: "", geo: geo)
            let user = User(id: id, name: name, username: "", email: email, address: address, phone: phone, website: "", company: nil)
            
            filterUsers.append(user)
            users.append(user)
        }
        
        handleDataLoadComplete?()
    }
    
    func getUser(from userId: Int) -> User? {
        let user = users.first { item -> Bool in
            return item.id == userId
        }
        return user ?? nil
    }
    
    func searchUser(from user: String) {
        users.removeAll()
        if user.isEmpty {
            users = filterUsers
            handleSearchComplete?()
            return
        }
        users = filterUsers.filter{$0.name.lowercased().contains(user.lowercased())}
        handleSearchComplete?()
    }
    
}
