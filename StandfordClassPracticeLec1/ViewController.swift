//
//  ViewController.swift
//  StandfordClassPracticeLec1
//
//  Created by Daning Miao on 9/7/18.
//  Copyright © 2018 Daning Miao. All rights reserved.
/* Check List:
    Task 1: practice upglaod project to Github
    Task 2: comprehend the MVC
 controller can communicate with Model and View. But Model and View can't directly communicate with each other, it require controller through variables and delegate, a kind of method called protocol. View doesn't own the data.Every time View wants to acquire data, it ask Controller and controller access and interprete data from Model through protocol.
    Task 3: Revise if else statement
    Task 4: comprehend UIButton
 */

import UIKit

class ViewController: UIViewController {
    
    // assign a initial value to initilize the variable. or use init method.
    var userIsInTheMiddleOfTyping = false

    
    //deal with display right stuff after each button is pressed
    //if it is first press, what you press is what you get. if not the first press, the number you press need to follow by the previous number you press. that is why userIsInTheMiddleOfTyping exists.
    
    
    @IBAction func digitPress(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    var dotAlreadyPressed = false
    @IBAction func dotpress(_ sender: UIButton) {
         let textCurrentlyInDisplay = display.text!
        if dotAlreadyPressed == false {
            display.text = textCurrentlyInDisplay + sender.currentTitle!
            dotAlreadyPressed = true
        }else {
             print("dot already press")
        }
        
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        dotAlreadyPressed = false
        display.text = "0"
    }
    
   
 
   /*computed property. Too many time we need to convert display.text into during operation. so create the following varible to make program easier.
     get set statement: Getters and Setters in Swift:https://syntaxdb.com/ref/swift/getters-setters.Setters and Getters apply to compute properties; such properties do not have storage in the instance - the value from the getter is meant to be computed from other instance properties.
      When we are getting a value of the property it fires its get{} part.
      When we are setting a value to the property it fires its set{} part.
     PS. When setting a value to the property, SWIFT automatically creates a constant named "newValue" = a value we are setting. After a constant "newValue" becomes accessible in the property's set{} part.
     
     Example:
     
     var A:Int = 0
     var B:Int = 0
     
     var C:Int {
     get {return 1}
     set {print("Recived new value", newValue, " and stored into 'B' ")
     B = newValue
     }
     }
     
     //When we are getting a value of C it fires get{} part of C property
     A = C
     A            //Now A = 1
     
     //When we are setting a value to C it fires set{} part of C property
     C = 2
     B            //Now B = 2
     */
    


    var displayValue: Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    // understand <if let in> the dealing with optional, deal with the operation.
    //“you can use if and let together to work with values that might be missing. These values are represented as optionals. An optional value either contains a value or contains nil to indicate that a value is missing. If the optional value is nil, the conditional is false and the code in braces is skipped. Otherwise, the optional value is unwrapped and assigned to the constant after let, which makes the unwrapped value available inside the block of code.”
   // or force wrapping
    
    // how to implement the model <CalculatorBrain>, through create a variable
    
    private var brain = CalculatorBrain()
    
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        dotAlreadyPressed = false
   
       // we get rid of the following codes later, as it is not ideal way to code, we create a mode for performOperation function. For it, we create a new swift file under this project file called CalculatorBrain.swift which is the model for this project.
        /*   if let mathmaticalSymbol = sender.currentTitle  {
            switch mathmaticalSymbol {
            case "Pi":
                display.text = String(Double.pi)
            case "√":
                
                // refer to above <get set> statement.
                displayValue = sqrt(displayValue)
                
            default:
                break
                
            }
        }
        */
        // the following is new code after we create a struct called CalculatorBrain, and create a variable called brain which CalculatorBrain struct
        if userIsInTheMiddleOfTyping{
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result{
            displayValue = result
        }
        
        
    }
    
    //use autoshrink to deal with the larger number. this ! is explicitly wrapped optional.
    @IBOutlet weak var display: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

