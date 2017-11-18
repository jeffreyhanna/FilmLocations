//
//  ContainerViewController.swift
//  Jeff Hanna
//
//  Created by Jeff Hanna on 11/16/17.
//  Copyright © 2017 Skycatch. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    // MARK: - ui elements
    
    // MARK: - constraints
    
    // MARK: - properties
    
    let homeNavigationControler = UINavigationController(rootViewController: HomeViewController())
    
    // MARK: - init
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // home view controller
        
        configureChildViewController(childViewController: homeNavigationControler)
        
    }
    
    // MARK: - methods
    
    // MARK: - actions
    
    // MARK: - notification handlers

}
