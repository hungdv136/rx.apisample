//
//  JSONDecodable.swift
//  FRP.ApiSample
//
//  Created by Hung Dinh on 10/15/16.
//  Copyright © 2016 Chu Cuoi. All rights reserved.
//

protocol JSONDecodable {
    init(dict: [String: AnyObject]) throws
}
