//
//  ViewController.swift
//  tippy
//
//  Created by Mike Tehranian on 7/17/16.
//  Copyright © 2016 Mike Tehranian. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var tipHeaderLabel: UILabel!
    @IBOutlet weak var totalHeaderLabel: UILabel!
    
    let tipPercentages = [0.18, 0.2, 0.25]
    let colorThemes = [0:UIColor.blueColor(), 1:UIColor.redColor(), 2:UIColor.greenColor(), 3: UIColor.yellowColor()]
    
    let userLocale = NSLocale.currentLocale()
    let numberFormatter = NSNumberFormatter()
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Only need to initialize the locale and currency style once
        numberFormatter.locale = userLocale
        numberFormatter.numberStyle = .CurrencyStyle
        
        if useLastBillAmount() {
            if let oldBill = defaults.doubleForKey("old_bill_amount") as Double? {
                billField.text = String(oldBill)
            }
        }
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        // Hide the keyboard when user clicks in the background
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        let tipPercent = tipPercentages[tipControl.selectedSegmentIndex]
        setTipAndTotalFields(tipPercent)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        let selectedTipIndex = defaults.integerForKey("default_tip_selected_index")
        
        // Update the UI to make sure the default value is shown
        tipControl.selectedSegmentIndex = selectedTipIndex
        
        setTipAndTotalFields(tipPercentages[selectedTipIndex])
        
        // Focus  UI on the bill field
        billField.becomeFirstResponder()
        
        updateBackgroundTheme()
        updateColorTheme()
    }
    
    func updateBackgroundTheme() {
        let selectedBackgroundThemeIndex = defaults.integerForKey("background_theme_selected_index")
        
        if selectedBackgroundThemeIndex == 0 {
            // Light theme
            self.view?.backgroundColor = UIColor.whiteColor()
            billField.keyboardAppearance = .Light
            self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        } else if selectedBackgroundThemeIndex == 1 {
            // Dark theme
            self.view?.backgroundColor = UIColor.blackColor()
            billField.keyboardAppearance = .Dark
            self.navigationController?.navigationBar.backgroundColor = UIColor.blackColor()
        }
    }
    
    func updateColorTheme() {
        if let selectedColorTheme = colorThemes[defaults.integerForKey("color_theme_selected_index")] {
            setColorOnComponents(selectedColorTheme)
        }
    }
    
    func setColorOnComponents(color: UIColor) {
        UILabel.appearance().tintColor = color
        UILabel.appearance().textColor = color
        UISegmentedControl.appearance().tintColor = color
        tipLabel.tintColor = color
        tipLabel.textColor = color
        totalLabel.tintColor = color
        tipHeaderLabel.tintColor = color
        tipHeaderLabel.textColor = color
        totalHeaderLabel.textColor = color
        totalHeaderLabel.tintColor = color
        tipControl.tintColor = color
        billField.tintColor = color
        billField.textColor = color
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:color]
    }
    
    func setTipAndTotalFields(tipPercent: Double) {
        // If the Bill field has an invalid amount, shake the text field
        if containsInvalidAmount(billField.text) {
            shakeTextField(billField)
        }
        
        let bill = Double(billField.text!) ?? 0.0
        
        // Calculate the tip and total amounts
        let tip = bill * tipPercent
        let total = bill + tip
        
        // Show the amount with respect to the user's locale
        let tipFormatted = numberFormatter.stringFromNumber(tip)!
        let totalFormatted = numberFormatter.stringFromNumber(total)!
        tipLabel.text = String(tipFormatted)
        totalLabel.text = String(totalFormatted)
        
        // Animate the calculated labels for tip and total
        tipLabel.alpha = 0
        UIView.animateWithDuration(0.4, animations: {
            self.tipLabel.alpha = 1
        })
        totalLabel.alpha = 0
        UIView.animateWithDuration(0.4, animations: {
            self.totalLabel.alpha = 1
        })
        
        // Save the bill amount for the future
        if let oldBill = billField.text {
            if let oldBillDouble = Double(oldBill) {
                defaults.setDouble(oldBillDouble, forKey: "old_bill_amount")
            }
        }
        defaults.setObject(NSDate(), forKey: "old_bill_date")
    }
    
    func shakeTextField(textField: UITextField) {
        let anim = CAKeyframeAnimation(keyPath:"transform")
        anim.values = [
            NSValue(CATransform3D:CATransform3DMakeTranslation(-5, 0, 0)),
            NSValue(CATransform3D:CATransform3DMakeTranslation( 5, 0, 0))
        ]
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        anim.autoreverses = true
        anim.repeatCount = 2
        anim.duration = 0.04
        textField.layer.addAnimation(anim, forKey:nil)
    }
    
    func containsInvalidAmount(input: String?) -> Bool {
        if let testString = input {
            for chr in testString.characters {
                if ((chr >= "a" && chr <= "z") || (chr >= "A" && chr <= "Z")) {
                    return true
                }
            }
            // If there is more than one decimal point
            if (testString.componentsSeparatedByString(".").count > 2 ) {
                return true
            }
        }
        return false
    }
    
    func useLastBillAmount() -> Bool {
        if let oldBillDate = defaults.objectForKey("old_bill_date") as! NSDate? {
            // Is the existing bill from less than 10 mins ago?
            let currentDate = NSDate()
            if currentDate.timeIntervalSinceDate(oldBillDate) < 600.0 {
                return true
            }
        }
        return false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
}
