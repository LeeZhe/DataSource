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


extension String {
    /// 是否为Int
    var isInt : Bool {
        let digits = CharacterSet.decimalDigits
        if let x = unicodeScalars.first {
            return digits.contains(x)
        }
        return false
    }
    /// 是否是运算符
    var isPriority : Bool {
         let priority_list = ["+", "-", "*", "/"];
        return priority_list.contains(self)
    }
    
    
    func eval() -> Double {
        let exp: NSExpression = NSExpression(format: self)
        return exp.expressionValue(with: nil, context: nil) as! Double
    }

}



func isLegalBrackets(str : String) -> Bool{
    let stack = KZStack()
for item in str {
        if item == "(" {
            // 将左括号压入栈
            stack.push(item)
        } else if item == ")" {
            // 如果栈为空则说明没有左括号与之抵消
            if stack.isEmpty() {
                return false
            }
            
            _ = stack.pop()
        }
    }
    return stack.isEmpty()
}

//isLegalBrackets(str: "()()")


private func calc_exp(exp : [String]) -> String{
    let stack = KZStack()
    for x in exp {
        if x.isInt {
            stack.push(x)
        } else {
            let value_last = stack.pop() as? String ?? ""
            let value_first = stack.pop() as? String ?? ""
            let exp_str = value_first + x + value_last
            let res = String(exp_str.eval())
            // 计算结果入栈
            stack.push(res);
        }
    }
    return stack.top() as? String ?? ""
}

/// 逆波兰表达式
        let exp_1 = ["4", "13", "5", "/", "+"];
        let exp_2 = ["10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"];
//        calc_exp(exp: exp_1)
//        calc_exp(exp: exp_2)


func infix_exp_2_postfix_exp(_ exp : [String]) -> [String] {
    /// 存储数据的lst
    var postfix_lst = [String]()
    
    let priority_map = ["+" : 1, "-" : 1, "*" : 2, "/" : 2]
    let stack = KZStack()
    for x in exp {
        if x.isInt {
            postfix_lst.append(x)
        } else if x == "(" {
            stack.push(x)
        } else if x == ")" {
            while stack.top() as! String != "(" {
                postfix_lst.append(stack.pop() as! String)
            }
            stack.pop()
        } else {
            while !stack.isEmpty() {
                if let top = stack.top() as? String {
                    guard top.isPriority else {
                        break;
                    }
                    
                    guard priority_map[top]! >= priority_map[x]! else {
                        break;
                    }
                    postfix_lst.append(stack.pop() as! String)
                }
            }
            stack.push(x)
        }
    }
    
    return postfix_lst
}

let exp = ["(", "1", "+", "(", "4", "+", "5", "+", "3", ")", "/", "4", "-", "3", ")", "+", "(", "6", "+", "8", ")", "*", "3"]
infix_exp_2_postfix_exp(exp)
// ["1", "4", "5", "+", "3", "+", "4", "/", "+", "3", "-", "6", "8", "+", "3"]








