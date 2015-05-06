//
//  firstPage.swift
//  exercise
//
//  Created by bruno raupp kieling on 4/9/15.
//  Copyright (c) 2015 bruno raupp kieling. All rights reserved.
//

import UIKit

class FirstPage: UIViewController {

    @IBOutlet weak var detailImg: UIImageView!
    @IBOutlet weak var actvIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        //self.actvIndicator.startAnimating()
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
            let url = NSURL(string: "http://dc737.4shared.com/download/Bd6FDq10ce/map.png?lgfp=1000")!
            let image = UIImage(data: NSData(contentsOfURL: url)!)
            
            dispatch_async(dispatch_get_main_queue()) {
               // self.actvIndicator.stopAnimating()
                
                self.detailImg.image = image
                
                }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}