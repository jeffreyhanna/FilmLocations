//
//  NetworkManager.swift
//  Jeff Hanna
//
//  Created by Jeff Hanna on 11/16/17.
//  Copyright © 2017 Skycatch. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class NetworkManager {
    
    typealias FilmLocationsCompletionBlock = (_ result: FilmLocationsResult) -> ()
    
    enum FilmLocationsResult {
        case error(error: Error?)
        case success(filmLocations: [FilmLocation])
    }
    
    typealias JsonDictionary = [String: Any?]
    typealias JsonArray = [JsonDictionary]
    
    class func fetchFilmLocations(offset: Int = 0,
                                  limit: Int = 20,
                                  completionBlock: FilmLocationsCompletionBlock? = nil) {
        
        let urlString = "https://data.sfgov.org/resource/wwmu-gmzc.json"
        
        let parameters: Parameters = [
            "$offset": offset,
            "$limit": limit
        ]
        
        request(urlString, parameters: parameters, encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON(queue: .global(), options: []) { response in
                
                guard response.result.isSuccess,
                    let responseArray = response.result.value as? JsonArray else {
                        
                        // TODO: track error remotely
                        
                        DispatchQueue.main.async {
                            completionBlock?(.error(error: response.result.error))
                        }
                        
                        return
                        
                }
                
                // deserialize response
                
                var filmLocationIds: [String] = []
                
                do {
                    
                    let realm = try Realm()
                    try realm.write {
                        for (index, dictionary) in responseArray.enumerated() {
                            
                            if let filmLocation = FilmLocation.create(fromDictionary: dictionary,
                                                                      index: 1 + offset + index) {
                                
                                filmLocationIds.append(filmLocation.id)
                            
                            }
                            
                        }
                    }
                    
                }
                
                catch {
                    
                    // track error
                    
                    DispatchQueue.main.async {
                        completionBlock?(.error(error: error))
                    }
                    
                    return
                    
                }
                
                DispatchQueue.main.async {
                    
                    guard let realm = try? Realm() else {
                        completionBlock?(.error(error: nil))
                        return
                    }

                    realm.refresh()
                    
                    let filmLocations = Array(realm.objects(FilmLocation.self)
                        .filter("\(#keyPath(FilmLocation.id)) IN %@", filmLocationIds))
                    
                    completionBlock?(.success(filmLocations: filmLocations))
                    
                }
                
        }
        
    }
    
}
