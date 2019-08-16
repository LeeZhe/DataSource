//
//  ViewController.swift
//  ShareDemoTest
//
//  Created by KiddieBao on 2019/8/14.
//  Copyright © 2019 Kiddie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /// （）匹配校验
//        print(isLegalBrackets(str: "()()))"));
//        print(isLegalBrackets(str: "sdf(ds(ew(we)rw)rwqq)qwewe"));
//        print(isLegalBrackets(str: "()()sd()(sd()fw))("))
        
        /// 逆波兰表达式
        let exp_1 = ["1", "2", "3", "*", "+", "2", "1", "-", "+"]
//        let exp_2 = ["10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"];
        print(calc_exp(exp: exp_1));
//        print(calc_exp(exp: exp_2));
        
        
        /// 最小栈
//        let minstack = KZMinStack()
//        minstack.push(item: 3);
//        minstack.push(item: 6);
//        minstack.push(item: 8);
//        print(minstack.min() ?? "无");
//        minstack.push(item: 2);
//        print(minstack.min() ?? "无");
//        minstack.push(item: 0);
//        print(minstack.min() ?? "无")
        
//        infix_exp_2_postfix_exp("()+-*/")
        
        
        // 中续转后续
//        print(infix_exp_2_postfix_exp(["1", "+", "2", "*", "3"]))
//        print(infix_exp_2_postfix_exp(["2","-", "3", "+", "2"]))
//        let exp = ["(","1","+","(","4","+","5","+","3",")","-","3",")","+","(","9","+","8",")"];
        
//        let exp = ["(", "1", "+", "(", "4", "+", "5", "+", "3", ")", "/", "4", "-", "3", ")", "+", "(", "6", "+", "8", ")", "*", "3"]
        // ["1", "4", "5", "+", "3", "+", "4", "/", "+", "3", "-", "6", "8", "+", "3"]

//        print(infix_exp_2_postfix_exp(exp))

    }
    /// 主要思路：
    // 遇到左括号压入栈中
    private func isLegalBrackets(str : String) -> Bool{
        let stack = KZStack()
        for x in str {
            if x == "(" {
                stack.push(x)
            } else if x == ")" {
                if stack.isEmpty() {
                    return false
                }
                _ = stack.pop()
            }
        }
        return stack.size() == 0
    }
    
    
    private func calc_exp(exp : [String]) -> String{
        let stack = KZStack()
        let calArr = ["+", "-", "*", "/"]
        for x in exp {
            // 有符号，弹出两个计算
            if calArr.contains(x) {
                let value1 = stack.pop() as? String ?? ""
                let value2 = stack.pop() as? String ?? ""
                let exp_str = value2 + x + value1
                let exp_double_string = String(eval(stringWithMathematicalOperation: exp_str))
                stack.push(exp_double_string)
            } else {
                stack.push(x)
            }
        }
        return stack.top() as! String
    }
    
    func infix_exp_2_postfix_exp(_ exp : [String]) -> [String] {
        /// 运算优先级map
        let priority_map = ["+" : 1, "-" : 1, "*" : 2, "/" : 2]
        /// 存储运算的数据
        var postfix_lst = [String]()
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
                _ = stack.pop()
            } else {
                while !stack.isEmpty() {
                    if let top = stack.top() as? String {
                        guard top.isPriority else {
                            break;
                        }
                        
                        guard priority_map[top]! >= priority_map[x]! else{
                            break;
                        }
                        postfix_lst.append(stack.pop() as! String)
                    }
                }
                stack.push(x)
            }
        }
        while !stack.isEmpty() {
            postfix_lst.append(stack.pop() as! String)
        }
        return postfix_lst
    }
    
    
    
    func eval(stringWithMathematicalOperation : String) -> Double {
        let exp: NSExpression = NSExpression(format: stringWithMathematicalOperation)
        return exp.expressionValue(with: nil, context: nil) as! Double
    }
}



