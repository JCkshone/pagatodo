//
//  PostModel.swift
//  ceiba-test
//
//  Created by Jc on 22/04/20.
//  Copyright © 2020 Jc. All rights reserved.
//

import Foundation

struct Post: Decodable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
    
    enum CondingKeys: String, CodingKey {
        case id
        case userId
        case title
        case body
    }
}
