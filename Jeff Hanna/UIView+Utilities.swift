//
//  UIView+Utilities.swift
//  Jeff Hanna
//
//  Created by Jeff Hanna on 11/16/17.
//  Copyright © 2017 Skycatch. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - autolayout
    
    typealias EdgeInsetsConstraintsTuple = (
        topConstraint: NSLayoutConstraint,
        leadingConstraint: NSLayoutConstraint,
        bottomConstraint: NSLayoutConstraint,
        trailingConstraint: NSLayoutConstraint
    )
    
    @discardableResult
    func addEdgeInsetsConstraintsForSubview(_ subview: UIView,
                                            edgeInsets: UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)) -> EdgeInsetsConstraintsTuple {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: subview,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: edgeInsets.top)
        
        let leadingConstraint = NSLayoutConstraint(item: subview,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .leading,
                                                   multiplier: 1,
                                                   constant: edgeInsets.left)
        
        let bottomConstraint = NSLayoutConstraint(item: subview,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: -edgeInsets.bottom)
        
        let trailingConstraint = NSLayoutConstraint(item: subview,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: self,
                                                    attribute: .trailing,
                                                    multiplier: 1,
                                                    constant: -edgeInsets.right)
        
        addConstraints([
            topConstraint,
            leadingConstraint,
            bottomConstraint,
            trailingConstraint
            ])
        
        return (
            topConstraint: topConstraint,
            leadingConstraint: leadingConstraint,
            bottomConstraint: bottomConstraint,
            trailingConstraint: trailingConstraint
        )
        
    }

}
