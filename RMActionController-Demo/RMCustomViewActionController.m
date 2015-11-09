//
//  RMCustomViewActionController.m
//  RMActionController-Demo
//
//  Created by Roland Moers on 17.05.15.
//  Copyright (c) 2015 Roland Moers. All rights reserved.
//

#import "RMCustomViewActionController.h"

@implementation RMCustomViewActionController

#pragma mark - Init and Dealloc
- (instancetype)initWithStyle:(RMActionControllerStyle)aStyle title:(NSString *)aTitle message:(NSString *)aMessage selectAction:(RMAction *)selectAction andCancelAction:(RMAction *)cancelAction {
    self = [super initWithStyle:aStyle title:aTitle message:aMessage selectAction:selectAction andCancelAction:cancelAction];
    if(self) {
        self.contentView = [[UIView alloc] initWithFrame:CGRectZero];
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        
        UILabel *plusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        plusLabel.translatesAutoresizingMaskIntoConstraints = NO;
        plusLabel.text = @"+";
        plusLabel.font = [UIFont boldSystemFontOfSize:40];
        [self.contentView addSubview:plusLabel];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        textLabel.text = @"Add your custom view";
        textLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.contentView addSubview:textLabel];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:plusLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:plusLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:-20]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:20]];
        
        NSDictionary *bindings = @{@"contentView": self.contentView};
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[contentView(>=300)]" options:0 metrics:nil views:bindings]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[contentView(140)]" options:0 metrics:nil views:bindings]];
    }
    return self;
}

@end
