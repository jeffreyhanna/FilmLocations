//
//  FilmLocation.swift
//  Jeff Hanna
//
//  Created by Jeff Hanna on 11/16/17.
//  Copyright © 2017 Skycatch. All rights reserved.
//

import Foundation
import RealmSwift

class FilmLocation: Object {
    
    // MARK: - properties
    
    dynamic var id: String = ""
    dynamic var locationString: String = ""
    dynamic var film: Film?
    dynamic var index: Int = 0
 
    // MARK: - class information
    
    override class func primaryKey() -> String {
        return #keyPath(FilmLocation.id)
    }
    
    // MARK: - serialization
    
    // NOTE: this method assumes to be called within write block
    
    @discardableResult
    class func create(fromDictionary dictionary: NetworkManager.JsonDictionary, index: Int) -> FilmLocation? {
    
        guard let realm = try? Realm() else {
            
            // TODO: track error
            
            return nil
            
        }
        
        // check for required fields
        
        guard let locationString = dictionary["locations"] as? String,
            let title = dictionary["title"] as? String,
            let releaseYearString = dictionary["release_year"] as? String else {
         
                // TODO: track unexpected response
                
                return nil
        }
        
        // check for existing
        
        let id: String = "\(locationString):\(title):\(releaseYearString)"
        
        var filmLocation: FilmLocation
        var didCreate: Bool = false
        
        if let existingFilmLocation = realm.object(ofType: FilmLocation.self, forPrimaryKey: id) {

            filmLocation = existingFilmLocation
            
        } else {
            
            filmLocation = FilmLocation()
            filmLocation.id = id
            didCreate = true
            
        }
        
        filmLocation.index = index
        filmLocation.locationString = locationString
        
        // check for existing film
        
        var film: Film
        
        let filmId: String = "\(title)\(releaseYearString)"
        
        if let existingFilm = realm.object(ofType: Film.self, forPrimaryKey: filmId) {
            
            film = existingFilm
            
        } else {
            
            film = Film()
            film.id = filmId
            didCreate = true
            
        }
        
        film.title = title
        film.releaseYearString = releaseYearString
        
        filmLocation.film = film
        
        if didCreate {
            realm.add(filmLocation)
        }
        
        return filmLocation
        
    }
    
}
