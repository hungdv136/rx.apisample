//
//  BaseAPIService.swift
//  FRP.ApiSample
//
//  Created by Hung Dinh on 10/10/16.
//  Copyright © 2016 Chu Cuoi. All rights reserved.
//

import RxSwift
import RxCocoa
import Alamofire

enum ServiceError : Error {
    case InvalidJSON
}

typealias JSON = [String: AnyObject]
class BaseAPIService {
    func rx_requestArray<T: JSONDecodable>(url: String) -> Observable<[T]> {
        return rx_requestJSON(url: url).map { try $0.flatMap { try T.init(dict: $0) } }
    }
    
    func rx_requestObject<T: JSONDecodable>(url: String) -> Observable<T> {
        return rx_requestJSON(url: url).map { try T.init(dict: $0.first!)} 
    }
    
    func rx_requestJSON(url: String) -> Observable<[JSON]> {
        return Observable.create { o in
            let request = Alamofire.request(url)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
            
            request.responseJSON { data in
                guard data.result.error == nil, let json = data.result.value as? [JSON] else {
                    o.onError(data.result.error ?? ServiceError.InvalidJSON)
                    o.onCompleted()
                    return
                }
                o.onNext(json)
                o.onCompleted()
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

class B {
    
    typealias JSONHandler = (_ data: [JSON]?, _ error: Error?) -> Void
    typealias ArrayHandler<T> = (_ data: [T]?, _ error: Error?) -> Void
    typealias ObjectHandler<T> = (_ data: T?, _ error: Error?) -> Void
    
    func rx_requestJSON(url: String, completion: @escaping(JSONHandler)) -> Void {
        let request = Alamofire.request(url)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
        request.responseJSON { data in
            let json = data.result.value as? [[String: AnyObject]]
            completion(json, data.result.error)
        }
    }
    
    func rx_requestArray<T: JSONDecodable>(url: String, completion: @escaping (ArrayHandler<T>)) -> Void {
        rx_requestJSON(url: url) { (data, error) in
            do {
                let array = try data?.map { try T.init(dict: $0) }
                completion(array, error)
            }
            catch {
                completion(nil, ServiceError.InvalidJSON)
            }
        }
    }
    
    func rx_requestObject<T: JSONDecodable>(url: String, completion: @escaping (ObjectHandler<T>)) -> Void {
        rx_requestJSON(url: url) { (data, error) in
            do {
                let object = try data?.map { try T.init(dict: $0) }.first
                completion(object, error)
            }
            catch {
                completion(nil, ServiceError.InvalidJSON)
            }
        } 
    }
}





