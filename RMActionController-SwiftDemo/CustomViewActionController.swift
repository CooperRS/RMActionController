//
//  CustomViewActionController.swift
//  RMActionController-Demo
//
//  Created by Roland Moers on 19.08.15.
//  Copyright (c) 2015 Roland Moers. All rights reserved.
//

import RMActionController

class CustomViewActionController: RMActionController {
    
    required override init?(style aStyle: RMActionControllerStyle, title aTitle: String?, message aMessage: String?, selectAction: RMAction?, andCancelAction cancelAction: RMAction?) {
        super.init(style: aStyle, title: aTitle, message: aMessage, selectAction: selectAction, andCancelAction: cancelAction);
        
        self.contentView = UIView(frame: CGRectZero)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    
        let plusLabel = UILabel(frame: CGRectZero)
        plusLabel.translatesAutoresizingMaskIntoConstraints = false
        plusLabel.text = "+"
        plusLabel.font = UIFont.boldSystemFontOfSize(40)
        self.contentView.addSubview(plusLabel)
        
        let textLabel = UILabel(frame: CGRectZero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Add your custom view"
        textLabel.font = UIFont.boldSystemFontOfSize(20)
        self.contentView.addSubview(textLabel)
        
        self.contentView.addConstraint(NSLayoutConstraint(item: plusLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: plusLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: -20))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: textLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: textLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 20))
        
        let bindings = ["contentView": self.contentView];
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[contentView(>=300)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[contentView(140)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }

}
