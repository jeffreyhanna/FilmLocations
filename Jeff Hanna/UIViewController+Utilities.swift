//
//  UIViewController+Utilities.swift
//  Jeff Hanna
//
//  Created by Jeff Hanna on 11/16/17.
//  Copyright © 2017 Skycatch. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - keyboard
    
    @discardableResult
    func configureChildViewController(superview: UIView? = nil,
                                      childViewController: UIViewController,
                                      edgeInsets: UIEdgeInsets = UIEdgeInsets.zero) -> UIView.EdgeInsetsConstraintsTuple {
        
        var view: UIView
        if superview == nil {
            view = self.view
        } else {
            view = superview!
        }
        
        addChildViewController(childViewController)
        view.addSubview(childViewController.view)
        let edgeConstraintsTuple = view.addEdgeInsetsConstraintsForSubview(childViewController.view,
                                                                           edgeInsets: edgeInsets)
        childViewController.willMove(toParentViewController: self)
        childViewController.didMove(toParentViewController: self)
        
        return edgeConstraintsTuple
        
    }
    
}
