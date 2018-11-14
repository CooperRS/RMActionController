//
//  CustomViewActionController.swift
//  RMActionController-Demo
//
//  Created by Roland Moers on 19.08.15.
//  Copyright (c) 2015 Roland Moers. All rights reserved.
//

import RMActionController

class CustomViewActionController: RMActionController<UIView> {
    
    required override init(style aStyle: RMActionControllerStyle, title aTitle: String?, message aMessage: String?, select selectAction: RMAction<UIView>?, andCancel cancelAction: RMAction<UIView>?) {
        super.init(style: aStyle, title: aTitle, message: aMessage, select: selectAction, andCancel: cancelAction);
        
        self.contentView = UIView(frame: .zero)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let plusLabel = UILabel(frame: .zero)
        plusLabel.translatesAutoresizingMaskIntoConstraints = false
        plusLabel.text = "+"
        plusLabel.font = UIFont.boldSystemFont(ofSize: 40)
        self.contentView.addSubview(plusLabel)
        
        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Add your custom view"
        textLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.contentView.addSubview(textLabel)
        
        self.contentView.addConstraint(NSLayoutConstraint(item: plusLabel, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: plusLabel, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: -20))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 20))
        
        let bindings = ["contentView": self.contentView];
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[contentView(>=300)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[contentView(140)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }

}
