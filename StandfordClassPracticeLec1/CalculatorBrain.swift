//
//  CalculatorBrain.swift
//  StandfordClassPracticeLec1
//https://www.youtube.com/watch?v=-auG-myu02Q&index=2&list=PLPA-ayBrweUz32NSgNZdl0_QISw-f12Ai
//  Created by Daning Miao on 10/7/18.
//  Copyright © 2018 Daning Miao. All rights reserved.
// This file is Model for this project
//

import Foundation
// class and struct are kind of similar. String, double, Array and Dictionary can be considered as a kind of struct. class has inheritance, but struct doesn't. so no subclass to struct.struct is copy style type, class is heap type. struct no needs for initializer. if you want to make a change on property within the strcut, you need to add "mutating" keyword in the front of func, becasue struct is copy style.
//understanding private variables

//正负数变换
func changeSign(operand: Double)-> Double{
    return -operand
}

func multiply(opt1:Double,opt2:Double)->Double{
    return opt1 * opt2
}

struct CalculatorBrain {
    
    private var accumulator : Double?
    // attention: dictionary syntax, how to create a dictionary with mixed type? we create a new type. enum is type. like optional, we can make constant associate with a value using (Double)
    private enum Operation {
        case constant(Double)
        // like above we can associate constant with a double value, how about to associate with a function. like √, input a double and output a double
        case unaryOperation((Double)->Double)
        case binaryOperation((Double,Double)->Double)
        case equal
    }
    // so this dictionary contains two different type of data, string and operation which we just enum above. it has two types. pi and e are constant, but symbols like squareroot and cos are unaryOperation.
    private var operations: Dictionary<String,Operation>=[
        "Pi": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "±": Operation.unaryOperation(changeSign),
        "×": Operation.binaryOperation(multiply),
        // practice using the closure to get the following things done
        "+": Operation.binaryOperation({(opt1:Double, opt2:Double)->Double in
            return opt1 + opt2}),
        //shorten the closure
        "-": Operation.binaryOperation({$0-$1}),
        "÷": Operation.binaryOperation({$0/$1}),
        "=": Operation.equal
    ]
    
    mutating func performOperation(_ symbol: String){
        if let operation = operations[symbol]{
            // we switch private enum operation above
            switch operation {
            case .constant(let Value):
                accumulator = Value
           // refer to func changeSign
            case .unaryOperation(let function):
                if accumulator != nil{
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil{
                    pbo = pendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equal:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation(){
        if pbo != nil && accumulator != nil{
            accumulator = pbo!.perfom(with: accumulator!)
            pbo = nil
        }
    }
    
    private var pbo: pendingBinaryOperation?
    
   private struct pendingBinaryOperation{
        let function:(Double,Double)->Double
        let firstOperand: Double
        func perfom(with secondOperand:Double)->Double{
            return function(firstOperand,secondOperand)
        }
    }
    
    /* private var is internal var, other can't access this var, only within this class. Plesse thinking why we set accumulator here as optional. the following code, is a bit tideous, so we replace it with creating a dictionary.
    private var accumulator: Double?
    
   mutating func performOperation(_ symbol: String){
        switch symbol {
        case "Pi":
            accumulator = Double.pi
        case "√":
            if let operand = accumulator{
           accumulator = sqrt(operand)
            }
        default:
            break
            
        }
        */
   
   //if you want to make a change on property within the strcut, you need to add "mutating" keyword in the front of func, becasue struct is copy style
   mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
    // result is read only property, so we use get statement here
    // thinking why we set result as optional
    var result: Double?{
        get{
            return accumulator
        }
    }
}
