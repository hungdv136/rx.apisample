//
//  APIService.swift
//  FRP.ApiSample
//
//  Created by Hung Dinh on 10/9/16.
//  Copyright © 2016 Chu Cuoi. All rights reserved.
//

import RxSwift
import RxCocoa

final class PostAPIService: BaseAPIService {
    func getPosts(searchText: String) -> Observable<[Post]> {
        let lowerSearchText = searchText.lowercased()
        return rx_requestArray(url: "https://jsonplaceholder.typicode.com/posts").map {
            $0.filter { searchText.isEmpty || $0.title.contains(lowerSearchText) }
        }
    }
    
    func getPostDetail(id: String) -> Observable<Post> {
        return rx_requestObject(url: "https://jsonplaceholder.typicode.com/posts/\(id)")
    }
}
