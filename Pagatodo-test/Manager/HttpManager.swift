//
//  HttpManager.swift
//  ceiba-test
//
//  Created by Jc on 22/04/20.
//  Copyright © 2020 Jc. All rights reserved.
//

import Foundation
import Alamofire

class HttpManager {
    static var shareInstance: HttpManager {
        HttpManager()
    }
    
    struct Constant {
        static let baseUrl = "https://jsonplaceholder.typicode.com/"
    }
    
    enum httpResponse {
        case done
        case error
    }
    
    func getUsers(from path: String, handledResponse: @escaping (_ data: [User])->()) {
        let request = AF.request("\(Constant.baseUrl)\(path)")
        request.responseDecodable(of: [User].self) { response in
            guard let data = response.value else {return}
            handledResponse(data)
        }
    }
    
    func getPost(by path: String, handledResponse: @escaping (_ data: [Post])->()) {
        let request = AF.request("\(Constant.baseUrl)\(path)")
        request.responseDecodable(of: [Post].self) { response in
            guard let data = response.value else {return}
            handledResponse(data)
        }
    }
}
