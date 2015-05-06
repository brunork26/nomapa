//
//  listController.swift
//  exercise
//
//  Created by bruno raupp kieling on 4/9/15.
//  Copyright (c) 2015 bruno raupp kieling. All rights reserved.
//

import UIKit
import CoreData

class ListController: UIViewController {
 //   var dataSource : Array<AnyObject> = []
    var dataSource = NSMutableArray()
    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
    }
    override func viewWillAppear(animated: Bool) {
        self.dataSource.removeAllObjects()
        self.fetchData()
    }
    func fetchData(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext: NSManagedObjectContext! = appDelegate.managedObjectContext
        var err: NSErrorPointer = nil
        var fetchRequest = NSFetchRequest(entityName: "Commitment")
        var commits : NSArray! = managedObjectContext.executeFetchRequest(fetchRequest, error: err)
        if (commits.count == 0){}
        else{
            for index in 0...commits.count-1{
                let c = commits[index] as! Commitment
                self.dataSource.addObject(c)
            }
        }
        tableView.reloadData()
    }
    
    // MARK: - TableView Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.tag = indexPath.row
        var text = cell.viewWithTag(10) as! UILabel
        var text2 = cell.viewWithTag(100) as! UILabel
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy 'as' h:mm a"
        
        text.text = self.dataSource[indexPath.row].title
        text2.text = dateFormatter.stringFromDate(self.dataSource[indexPath.row].date!!)

        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    // deleta compromisso
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            // remove the deleted item from the model
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext!
            context.deleteObject(self.dataSource[indexPath.row] as! NSManagedObject)
            self.dataSource.removeObjectAtIndex(indexPath.row)
            context.save(nil)
            
            //tableView.reloadData()
            // remove the deleted item from the `UITableView`
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
            
        }
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
       // self.performSegueWithIdentifier("gotoMap", sender:self)
        println("teste")
    }
    
    //go to mapView
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell : UITableViewCell = (sender as? UITableViewCell)!
        let commit : Commitment = (self.dataSource.objectAtIndex(cell.tag) as? Commitment)!
        if(segue.identifier == "gotoMap"){
            if let toMap : mapViewController = segue.destinationViewController as? mapViewController{
                if let test = self.tableView.indexPathForSelectedRow()?.row{
                    toMap.coment = commit
                    toMap.activeZoom = true
                }
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
