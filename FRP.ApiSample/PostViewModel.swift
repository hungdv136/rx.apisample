//
//  ViewModel.swift
//  FRP.ApiSample
//
//  Created by Hung Dinh on 10/9/16.
//  Copyright © 2016 Chu Cuoi. All rights reserved.
//

import RxSwift
import RxCocoa

final class PostViewModel {
    init(service: PostAPIService) {
        self.service = service
    }
    
    func getPosts(searchText: String) -> Observable<[Post]> {
        return service.getPosts(searchText: searchText).map { $0.sorted(by: { $0.title < $1.title })  }
    }
    
    private let service: PostAPIService
}
