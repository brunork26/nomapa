//
//  ColorView.swift
//  exercise
//
//  Created by bruno raupp kieling on 4/9/15.
//  Copyright (c) 2015 bruno raupp kieling. All rights reserved.
//

import UIKit

class ColorView: UIViewController {

    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func red(sender: AnyObject) {
        //view.backgroundColor = (UIColor.redColor())
        NSUserDefaults.standardUserDefaults().setObject("red", forKey: "backColor")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func blue(sender: AnyObject) {
        //view.backgroundColor = (UIColor.redColor())
        NSUserDefaults.standardUserDefaults().setObject("blue", forKey: "backColor")
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    @IBAction func green(sender: AnyObject) {
        //view.backgroundColor = (UIColor.redColor())
        NSUserDefaults.standardUserDefaults().setObject("green", forKey: "backColor")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func redNav(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject("red", forKey: "navColor")
        NSUserDefaults.standardUserDefaults().synchronize()
        changeColor()
    }

    @IBAction func blueNav(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject("blue", forKey: "navColor")
        NSUserDefaults.standardUserDefaults().synchronize()
        changeColor()
    }
    @IBAction func greenNav(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject("green", forKey: "navColor")
        NSUserDefaults.standardUserDefaults().synchronize()
        changeColor()
    }
    
    func changeColor(){
        println("mudou a cor")
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // Start color off with a default value
        var color = UIColor.grayColor()
        
        if let backColor = defaults.objectForKey("navColor") as? String {
            switch backColor {
            case "red": color = UIColor.redColor()
            case "green": color = UIColor.greenColor()
            case "blue": color = UIColor.blueColor()
            case "black": color = UIColor.blackColor()
            default: break
            }
        }
        self.navigationController?.navigationBar.barTintColor = color
    }
    
    
    
}
