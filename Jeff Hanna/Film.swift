//
//  Film.swift
//  Jeff Hanna
//
//  Created by Jeff Hanna on 11/16/17.
//  Copyright © 2017 Skycatch. All rights reserved.
//

import Foundation
import RealmSwift

class Film: Object {
    
    // MARK: - properties
    
    dynamic var id: String = ""
    dynamic var title: String = ""
    dynamic var releaseYearString: String = ""
    
    // MARK: - class information
    
    override class func primaryKey() -> String {
        return #keyPath(Film.id)
    }
    
}
