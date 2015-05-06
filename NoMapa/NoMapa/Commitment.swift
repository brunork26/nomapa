//
//  Commitment.swift
//  NoMapa
//
//  Created by bruno raupp kieling on 4/10/15.
//  Copyright (c) 2015 bruno raupp kieling. All rights reserved.
//

import Foundation
import CoreData

class Commitment: NSManagedObject {
    @NSManaged var date: NSDate
    @NSManaged var x: NSNumber
    @NSManaged var y: NSNumber
    @NSManaged var desc: String
    @NSManaged var title: String
}
