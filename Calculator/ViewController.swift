//
//  ViewController.swift
//  Calculator
//
//  Created by Pushparaj Parab on 9/17/17.
//  Copyright © 2017 PushparajParab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsTyping = false
    
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let currtentText  = display.text!
        
        if userIsTyping
        {
            display.text = currtentText + digit
            print("you pressed \(digit)")
        }
        else{
            display!.text = digit
            userIsTyping = true
        }
        
        
        
    }
    
    
    var myDisplayText:Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    
    private var brain = CalculatorBrain()
    
    @IBAction func touchOperator(_ sender: UIButton) {
        
        if userIsTyping
        {
            brain.setOparand(myDisplayText)
            userIsTyping = false
            
        }
        
        if let op = sender.currentTitle
        {
            brain.performOperation(op)
        }
        
        if let results = brain.results
        {
            myDisplayText = results
        }
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

