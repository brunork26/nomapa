//
//  mapViewController.swift
//  exercise
//
//  Created by bruno raupp kieling on 4/7/15.
//  Copyright (c) 2015 bruno raupp kieling. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class mapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate{

    @IBOutlet weak var mapView: MKMapView!
    var dataSource = NSMutableArray()
    var locationManager : CLLocationManager!
    var titleText : NSString = ""
    var titleDesc : NSString = ""
    var dateCommit : NSDate!
    var results : MKLocalSearchResponse!
    var alreadyActive : Bool!
    
    // from listController
    var coment : Commitment!
    var activeZoom : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // print pins
        self.loadPins()
        
        // longpress location
        var gesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressed:")
        gesture.minimumPressDuration = 1.0
        self.mapView.addGestureRecognizer(gesture)
        // users location
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        self.activeZoom = true
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // zoom in users location or users selected place
        if(self.activeZoom == false){
            let regionToZoom = MKCoordinateRegionMake(locationManager.location.coordinate, MKCoordinateSpanMake(0.01, 0.01))
            self.mapView.setRegion(regionToZoom, animated: true)
        }else{
            let coord = CLLocationCoordinate2D(latitude: coment.x as! CLLocationDegrees, longitude: coment.y as! CLLocationDegrees)
            let regionToZoom = MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.01, 0.01))
            self.mapView.setRegion(regionToZoom, animated: true)
        }
    }
    
    func longPressed(longPress: UIGestureRecognizer) {
        var touchPoint = longPress.locationInView(self.mapView)
        var coord:CLLocationCoordinate2D = self.mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        if(self.alreadyActive == true){
            if (longPress.state == UIGestureRecognizerState.Ended) {
                // end longpress
                println(touchPoint.x)
            
                var anotation = MKPointAnnotation()
                    anotation.coordinate = coord
                    anotation.title = self.titleText as String
                    anotation.subtitle = self.titleDesc as String
                    self.mapView.addAnnotation(anotation)
                self.saveInDataSource(anotation)
                self.alreadyActive = false
            }else if (longPress.state == UIGestureRecognizerState.Began) {
                // start longpress
                println("Began")
            
            }
        }
        
    }
    
    func loadPins(){
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
        
        if(self.dataSource.count == 0){}
        else{
            for index in 0...self.dataSource.count-1{
                let commitObj = self.dataSource[index] as! Commitment
                let coord = CLLocationCoordinate2D(latitude: commitObj.x as! CLLocationDegrees, longitude: commitObj.y as! CLLocationDegrees)
                var anotation = MKPointAnnotation()
                    anotation.coordinate = coord
                    anotation.title = commitObj.title
                    anotation.subtitle = commitObj.desc
                self.mapView.addAnnotation(anotation)
            }
        }
        
        
    }
    
    func saveInDataSource(pin:MKPointAnnotation){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext: NSManagedObjectContext! = appDelegate.managedObjectContext
        
        var err : NSErrorPointer = nil
        
        var commit : Commitment = NSEntityDescription.insertNewObjectForEntityForName("Commitment", inManagedObjectContext: managedObjectContext) as! Commitment
        commit.x = pin.coordinate.latitude
        commit.y = pin.coordinate.longitude
        commit.title = pin.title
        commit.desc = pin.subtitle
        commit.date = self.dateCommit
        println("ishere")
        managedObjectContext.save(err)
        
    }
    
    // search var
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!

   // search func with bar
    @IBAction func showSearchBar(sender: AnyObject) {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        //1
        searchBar.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
        if self.mapView.annotations.count != 0{
            annotation = self.mapView.annotations[0] as! MKAnnotation
            self.mapView.removeAnnotation(annotation)
        }
        //2
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                var alert = UIAlertView(title: nil, message: "Place not found", delegate: self, cancelButtonTitle: "Try again")
                alert.show()
                return
            }
            //3
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = searchBar.text
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse.boundingRegion.center.latitude, longitude:     localSearchResponse.boundingRegion.center.longitude)
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            self.mapView.addAnnotation(self.pinAnnotationView.annotation)
        }
    }
    
    
}
