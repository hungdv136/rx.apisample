//
//  Post.swift
//  FRP.ApiSample
//
//  Created by Hung Dinh on 10/10/16.
//  Copyright © 2016 Chu Cuoi. All rights reserved.
//

final class Post: JSONDecodable {
    init(dict: [String: AnyObject]) throws {
        userId = dict["userid"] as? String ?? ""
        id = dict["id"] as? String ?? ""
        title = dict["title"] as? String ?? ""
        body = dict["body"] as? String
    }
    let userId: String
    let id: String
    let title: String
    let body: String?
}
