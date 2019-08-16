//
//  KZStack.swift
//  ShareDemoTest
//
//  Created by KiddieBao on 2019/8/14.
//  Copyright © 2019 Kiddie. All rights reserved.
//

import UIKit

class KZStack: NSObject {
    private var array = [Any]()
    
    func push(_ item : Any) -> Void {
        array.append(item)
    }
    
    func pop() -> Any? {
        return array.popLast()
    }
    
    func top() -> Any? {
        return array.last
    }
    
    func isEmpty() -> Bool {
        return array.isEmpty
    }
    
    func size() -> Int {
        return array.count
    }
    
    func clear() {
        array.removeAll()
    }
}


class KZMinStack : KZStack {
    private let data_stack = KZStack()
    private let min_stack = KZStack()
    
    override func push(_ item: Any) {
        guard item is Int || item is String else {
            return;
        }
        var x = 0;
        if item is String {
            x = Int(item as! String)!
        } else {
            x = item as! Int
        }
        data_stack.push(x);
        if min_stack.isEmpty() {
            min_stack.push(x);
        } else {
            let top = min_stack.top() as! Int
            if x < top {
                // 如果item大于等于栈顶元素,把min_stack的栈顶元素再放入一次
                // min_stack的元素个数要和data_stack 保持一致
                min_stack.push(x)
            } else {
                min_stack.push(top)
            }
        }
    }
    
    
    override func pop() -> Any? {
        _ = min_stack.pop()
        return data_stack.pop()
    }
    
    func min() -> Int? {
        return min_stack.top() as? Int
    }
}
