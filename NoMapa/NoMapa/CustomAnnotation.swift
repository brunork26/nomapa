//
//  CustomAnnotation.swift
//  exercise
//
//  Created by bruno raupp kieling on 4/8/15.
//  Copyright (c) 2015 bruno raupp kieling. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
   
    var coordinate:CLLocationCoordinate2D
    var title:String
    var subtitle:String
    
    init(coordinate:CLLocationCoordinate2D,title:String,subtitle:String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
