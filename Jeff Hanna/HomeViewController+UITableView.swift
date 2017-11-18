//
//  HomeViewController+UITableView.swift
//  Jeff Hanna
//
//  Created by Jeff Hanna on 11/16/17.
//  Copyright © 2017 Skycatch. All rights reserved.
//

import UIKit

extension HomeViewController: UITableViewDataSource {
    
    // MARK: - sections
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - rows
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return filmLocations.count
    }
    
    // MARK: - cells
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        if indexPath.row >= filmLocations.count - 3 {
            fetch()
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dequeueBlankCell: () -> (UITableViewCell) = {

            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self),
                                                     for: indexPath)
            cell.backgroundColor = .white
            return cell
            
        }
        
        guard indexPath.row < filmLocations.count,
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FilmLocationTableViewCell.self),
                                                     for: indexPath) as? FilmLocationTableViewCell else {
                return dequeueBlankCell()
        }
        
        let filmLocation = filmLocations[indexPath.row]
        
        cell.configure(withFilmLocation: filmLocation)
        
        return cell
        
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    
}
