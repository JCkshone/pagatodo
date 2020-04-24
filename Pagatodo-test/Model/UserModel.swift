//
//  UserModel.swift
//  ceiba-test
//
//  Created by Jc on 22/04/20.
//  Copyright © 2020 Jc. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company?
    
    enum CondingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
}

struct Address: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
    
    enum CondingKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geo
    }
}

struct Company: Decodable {
    let name: String
    let catchPhrase: String
    let bs: String
    
    enum CondingKeys: String, CodingKey {
        case name
        case catchPhrase
        case bs
    }
}

struct Geo: Decodable {
    let lat: String
    let lng: String
    
    enum CondingKeys: String, CodingKey {
        case lat
        case lng
    }
}
