//
//  RMCustomViewActionController.m
//  RMActionController-Demo
//
//  Created by Roland Moers on 17.05.15.
//  Copyright (c) 2015 Roland Moers. All rights reserved.
//

#import "RMCustomViewActionController.h"

@implementation RMCustomViewActionController

#pragma mark - Class
+ (instancetype)actionControllerWithStyle:(RMActionControllerStyle)style title:(NSString *)aTitle message:(NSString *)aMessage selectAction:(RMAction *)selectAction andCancelAction:(RMAction *)cancelAction {
    RMCustomViewActionController *controller = [super actionControllerWithStyle:style title:aTitle message:aMessage selectAction:selectAction andCancelAction:cancelAction];
    
    controller.contentView = [[UIView alloc] initWithFrame:CGRectZero];
    controller.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UILabel *plusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    plusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    plusLabel.text = @"+";
    plusLabel.font = [UIFont boldSystemFontOfSize:40];
    [controller.contentView addSubview:plusLabel];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    textLabel.text = @"Add your custom view";
    textLabel.font = [UIFont boldSystemFontOfSize:20];
    [controller.contentView addSubview:textLabel];
    
    [controller.contentView addConstraint:[NSLayoutConstraint constraintWithItem:plusLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:controller.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [controller.contentView addConstraint:[NSLayoutConstraint constraintWithItem:plusLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:controller.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:-20]];
    
    [controller.contentView addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:controller.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [controller.contentView addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:controller.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:20]];
    
    NSDictionary *bindings = @{@"contentView": controller.contentView};
    [controller.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[contentView(>=300)]" options:0 metrics:nil views:bindings]];
    [controller.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[contentView(140)]" options:0 metrics:nil views:bindings]];
    
    return controller;
}

@end
