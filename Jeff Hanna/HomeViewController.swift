//
//  HomeViewController.swift
//  Jeff Hanna
//
//  Created by Jeff Hanna on 11/16/17.
//  Copyright © 2017 Skycatch. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {

    // MARK: - ui elements
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - constraints
    
    // MARK: - properties
    
    let loadingViewController = LoadingViewController()
    var filmLocations: [FilmLocation] = []
    var isFetchInProgress: Bool = false
    
    // MARK: - init
    
    convenience init() {
        
        let type = type(of: self)
        let className = String(describing: type)
        let bundle = Bundle(for: type)
        self.init(nibName: className, bundle: bundle)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation bar
        
        navigationItem.title = NSLocalizedString("Film Locations", comment: "")
        
        // loading view controller
        
        configureChildViewController(childViewController: loadingViewController)
     
        // table view
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.register(UINib(nibName: String(describing: FilmLocationTableViewCell.self),
                                 bundle: Bundle(for: FilmLocationTableViewCell.self)),
                           forCellReuseIdentifier: String(describing: FilmLocationTableViewCell.self))
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
        // load cache
        
        loadCache()
        
        // fetch
        
        fetch()
        
    }
    
    // MARK: - methods
    
    func loadCache() {
        
        guard let realm = try? Realm() else {
            
            // TODO: track error
            
            return
        }
        
        let filmLocations = realm.objects(FilmLocation.self)
            .sorted(byKeyPath: #keyPath(FilmLocation.index))
        
        self.filmLocations = Array(filmLocations)
        
    }
    
    func fetch() {
        
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        let offset = filmLocations.last?.index ?? 0
        
        NetworkManager.fetchFilmLocations(offset: offset) { result in
            
            self.isFetchInProgress = false
            
            switch result {
            case .error(_):
                
                // TODO: show error message
                // TODO: show local results
                
                return
                
            case .success(let filmLocations):
                
                if self.filmLocations.isEmpty {
                    
                    // first time
                
                    self.filmLocations.append(contentsOf: filmLocations)
                    self.tableView.reloadData()
                    
                    // layout synchronously
                    
                    self.tableView.setNeedsLayout()
                    self.tableView.layoutIfNeeded()
                    
                    self.loadingViewController.hide()
                    
                } else {
                    
                    // not first time
                    
                    guard !filmLocations.isEmpty else {
                        return
                    }
                    
                    let firstNewIndex = self.filmLocations.count
                    self.filmLocations.append(contentsOf: filmLocations)
                    let lastNewIndex = self.filmLocations.count - 1
                    
                    let indexPaths = (firstNewIndex...lastNewIndex).map { IndexPath.init(row: $0, section: 0) }
                    self.tableView.insertRows(at: indexPaths, with: .fade)
                    
                    self.loadingViewController.hide()
                    
                }
                
            }
            
        }
        
    }
    
    // MARK: - actions
    
    // MARK: - notification handlers
    
}
