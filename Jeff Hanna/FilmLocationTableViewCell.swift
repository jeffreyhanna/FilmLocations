//
//  FilmLocationTableViewCell.swift
//  Jeff Hanna
//
//  Created by Jeff Hanna on 11/16/17.
//  Copyright © 2017 Skycatch. All rights reserved.
//

import UIKit

class FilmLocationTableViewCell: UITableViewCell {

    // MARK: - ui elements
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var filmLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    // MARK: - constraints
    
    // MARK: - properties
    
    var filmLocation: FilmLocation?
    
    // MARK: - init
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - view lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - methods
    
    func configure(withFilmLocation filmLocation: FilmLocation) {
     
        self.filmLocation = filmLocation
        
        // location label
        
        locationLabel.text = filmLocation.locationString
        
        guard let film = filmLocation.film else {
            
            // track this error to a remote system
            
            // clear ui
            
            filmLabel.text = nil
            yearLabel.text = nil
            
            return
        }
        
        // film label
        
        filmLabel.text = film.title
        
        // year label
        
        yearLabel.text = film.releaseYearString
        
    }
    
    // MARK: - actions
    
    // MARK: - notification handlers
    

    
    
}
