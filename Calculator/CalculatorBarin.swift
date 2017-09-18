//
//  CalculatorBarin.swift
//  Calculator
//
//  Created by Pushparaj Parab on 9/18/17.
//  Copyright © 2017 PushparajParab. All rights reserved.
//

import Foundation

func multiply(op1: Double, op2: Double) -> Double{
    return op1 * op2
}

struct CalculatorBrain {
    
    
    private var accumulator:Double?
    
    
    
    private enum operation
    {
        case constants(Double)
        case unaryOperations((Double) -> Double)
        case binaryOperations((Double,Double)-> Double)
        case equals
        
    }
    private var operations: Dictionary<String, operation> =
        [
            "π": operation.constants(Double.pi),
            "e": operation.constants(M_E),
            "√": operation.unaryOperations(sqrt),
            "cos": operation.unaryOperations(cos),
            "×" : operation.binaryOperations(multiply),
            "=" : operation.equals
    ]
    
    
    private var pbo: PendingBinaryOperation?
    
    private struct PendingBinaryOperation{
        let function:  (Double,Double) -> Double
        let firstOperand : Double
        func perform( with secondOperand : Double) -> Double{
            
            return function(firstOperand,secondOperand)
        }
        
    }
    
    
    private mutating func performBinaryOperation()
    {
        if pbo != nil && accumulator != nil
        {
            accumulator =  pbo!.perform(with: accumulator!)
            pbo = nil
        }
    }
    
    mutating func performOperation(_ symbol: String){
        if let symbol  = operations[symbol]{
            switch symbol {
            case operation.constants(let value):
                accumulator = value
            case operation.unaryOperations(let function):
                if accumulator != nil
                {
                    accumulator = function(accumulator!)
                }
            case .binaryOperations(let function):
                if accumulator != nil{
                    pbo = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
                
            case .equals:
                performBinaryOperation()
            }
        }
    }
    
    mutating func setOparand(_ operand: Double){
        self.accumulator = operand
    }
    
    
    var results: Double?{
        get{
            return accumulator
        }
    }
}
