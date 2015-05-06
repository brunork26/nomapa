//
//  ViewController.swift
//  exercise
//
//  Created by bruno raupp kieling on 4/7/15.
//  Copyright (c) 2015 bruno raupp kieling. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var textFieldCompromisso: UITextField!
    @IBOutlet weak var textFieldDescricao: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldCompromisso.delegate = self
        textFieldDescricao.delegate = self

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        textFieldCompromisso.resignFirstResponder()
        textFieldDescricao.resignFirstResponder()
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func marcarMapa(sender: AnyObject) {
        if(textFieldCompromisso.text.isEmpty == false && textFieldDescricao.text.isEmpty == false){
           self.performSegueWithIdentifier("gotoMap", sender: sender)
        }
        if(textFieldCompromisso.text.isEmpty == true){
            let alert = UIAlertView()
            alert.title = "Aviso"
            alert.message = "Adicione um nome ao compromisso"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        if(textFieldDescricao.text.isEmpty == true){
            let alert = UIAlertView()
            alert.title = "Aviso"
            alert.message = "Adiocione uma descrição ao compromisso"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("mudou a cor")
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // Start color off with a default value
        var color = UIColor.grayColor()
        
        if let backColor = defaults.objectForKey("backColor") as? String {
            switch backColor {
            case "red": color = UIColor.redColor()
            case "green": color = UIColor.greenColor()
            case "blue": color = UIColor.blueColor()
            case "black": color = UIColor.blackColor()
            default: break
            }
        }
        //self.navigationController?.navigationBar.barTintColor = color
        view.backgroundColor = color
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "gotoMap") {
            if let v: mapViewController = segue.destinationViewController as? mapViewController {
                v.titleText = textFieldCompromisso.text
                v.titleDesc = textFieldDescricao.text
                v.dateCommit = datePicker.date
                v.alreadyActive = true
                v.activeZoom = false
            }
            
        }
        
        
    }
}

