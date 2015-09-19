//
//  MapActionController.swift
//  RMActionController-Demo
//
//  Created by Roland Moers on 19.08.15.
//  Copyright (c) 2015 Roland Moers. All rights reserved.
//

import RMActionController
import MapKit

class MapActionController: RMActionController {
    
    required override init?(style aStyle: RMActionControllerStyle, title aTitle: String?, message aMessage: String?, selectAction: RMAction?, andCancelAction cancelAction: RMAction?) {
        super.init(style: aStyle, title: aTitle, message: aMessage, selectAction: selectAction, andCancelAction: cancelAction);
        
        self.contentView = MKMapView(frame: CGRectZero)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let bindings = ["contentView": self.contentView];
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[contentView(>=300)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[contentView(200)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override var disableBlurEffectsForContentView:Bool {
        get {
            return true;
        }
        set {
        }
    }
    
}
