//
//  SettingsViewController.swift
//  tippy
//
//  Created by Mike Tehranian on 7/20/16.
//  Copyright © 2016 Mike Tehranian. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var backgroundThemeControl: UISegmentedControl!
    @IBOutlet weak var defaultTipHeaderLabel: UILabel!
    @IBOutlet weak var backgroundThemeHeaderLabel: UILabel!
    @IBOutlet weak var colorThemeHeaderLabel: UILabel!
    @IBOutlet weak var colorThemeControl: UISegmentedControl!
    
    let colorThemes = [0:UIColor.blueColor(), 1:UIColor.redColor(), 2:UIColor.greenColor(), 3: UIColor.yellowColor()]
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setSegmentedControls()
        updateBackgroundTheme()
        updateColorTheme()
    }
    
    func setSegmentedControls() {
        let selectedTipIndex = defaults.integerForKey("default_tip_selected_index")
        defaultTipControl.selectedSegmentIndex = selectedTipIndex
        
        let selectedBackgroundThemeIndex = defaults.integerForKey("background_theme_selected_index")
        backgroundThemeControl.selectedSegmentIndex = selectedBackgroundThemeIndex
        
        let selectedColorThemeIndex = defaults.integerForKey("color_theme_selected_index")
        colorThemeControl.selectedSegmentIndex = selectedColorThemeIndex
    }
    
    @IBAction func defaultTipChanged(sender: AnyObject) {
        defaults.setInteger(defaultTipControl.selectedSegmentIndex, forKey: "default_tip_selected_index")
        defaults.synchronize()
    }
    
    @IBAction func backgroundThemeChanged(sender: AnyObject) {
        defaults.setInteger(backgroundThemeControl.selectedSegmentIndex, forKey: "background_theme_selected_index")
        defaults.synchronize()
        
        updateBackgroundTheme()
    }
    
    func updateBackgroundTheme() {
        let selectedBackgroundThemeIndex = defaults.integerForKey("background_theme_selected_index")
        
        if selectedBackgroundThemeIndex == 0 {
            // Light theme
            self.view?.backgroundColor = UIColor.whiteColor()
            self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        } else if selectedBackgroundThemeIndex == 1 {
            // Dark theme
            self.view?.backgroundColor = UIColor.blackColor()
            self.navigationController?.navigationBar.backgroundColor = UIColor.blackColor()
        }
    }
    
    @IBAction func colorThemeChanged(sender: AnyObject) {
        defaults.setInteger(colorThemeControl.selectedSegmentIndex, forKey: "color_theme_selected_index")
        defaults.synchronize()
        updateColorTheme()
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
        defaultTipHeaderLabel.tintColor = color
        defaultTipHeaderLabel.textColor = color
        backgroundThemeHeaderLabel.tintColor = color
        backgroundThemeHeaderLabel.textColor = color
        colorThemeHeaderLabel.tintColor = color
        colorThemeHeaderLabel.textColor = color
        defaultTipControl.tintColor = color
        backgroundThemeControl.tintColor = color
        colorThemeControl.tintColor = color
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:color]
    }
}
