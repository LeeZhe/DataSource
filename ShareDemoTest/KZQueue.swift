//
//  KZQueue.swift
//  ShareDemoTest
//
//  Created by Kiddie on 2019/9/4.
//  Copyright © 2019年 Kiddie. All rights reserved.
//

import UIKit

class KZQueue: NSObject {
    var items = [Any]()
    
    func enqueue(_ item : Any) -> Void {
        items.append(item)
    }
    
    func dequeue() -> Any {
        return items.removeFirst()
    }
    
    func head() -> Any? {
        return items.first
    }
    
    func size() -> Int {
        return items.count
    }
    
    func clear() {
        items.removeAll()
    }
}
