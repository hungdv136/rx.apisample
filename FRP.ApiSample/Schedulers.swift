//
//  Schedulers.swift
//  FRP.ApiSample
//
//  Created by Hung Dinh on 10/15/16.
//  Copyright © 2016 Chu Cuoi. All rights reserved.
//

import RxCocoa
import RxSwift

struct Schedulers {
    static var main: SchedulerType {
        return MainScheduler.instance
    }
    
    static let backgroundDefault: SchedulerType = {
        return ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS: .background)
    }()
    
    static let backgroundUserInitiated: SchedulerType = {
        return ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS: .userInitiated)
    }()
}
