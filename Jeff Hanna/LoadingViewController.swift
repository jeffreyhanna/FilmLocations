//
//  LoadingViewController.swift
//  Jeff Hanna
//
//  Created by Jeff Hanna on 11/16/17.
//  Copyright © 2017 Skycatch. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    // MARK: - ui elements
    
    @IBOutlet weak var spinnerContainerView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - constraints
    
    // MARK: - properties
    
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
        
        // spinner container view
        
        spinnerContainerView.clipsToBounds = true
        spinnerContainerView.layer.cornerRadius = k.view.cornerRadius.normal
        
    }
    
    // MARK: - methods
    
    func show() {
        
        self.spinner.startAnimating()
        
        UIView.animate(withDuration: k.animation.duration.normal) { [weak self] in
            self?.view.alpha = 1
        }
        
    }
    
    func hide() {

        UIView.animate(withDuration: k.animation.duration.normal,
                       animations: { [weak self] in
                        
                        self?.view.alpha = 0
                        
        }) { [weak self] success in
            
            guard success else {
                return
            }
            
            self?.spinner.stopAnimating()
            
        }
        
    }
    
    // MARK: - actions
    
    // MARK: - notification handlers
    

}
