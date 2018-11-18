//
//  RMImageAction.m
//  RMImageAction-Demo
//
//  Created by Roland Moers on 19.11.16.
//  Copyright © 2016 Roland Moers. All rights reserved.
//

#import "RMImageAction.h"

#import "RMActionController.h"

@interface RMImageAction () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel *label;

@end

@implementation RMImageAction

#pragma mark - View
- (UIView *)loadView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.userInteractionEnabled = NO;
    imageView.image = self.image;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.userInteractionEnabled = NO;
    titleLabel.text = self.title;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button addTarget:self action:@selector(actionTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    [view addSubview:button];
    [view addSubview:imageView];
    [view addSubview:titleLabel];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    NSDictionary *bindings = NSDictionaryOfVariableBindings(view, button, imageView, titleLabel);
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10)-[imageView]-(10)-[titleLabel]-(10)-|" options:0 metrics:nil views:bindings]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(>=10)-[imageView]-(>=10)-|" options:0 metrics:nil views:bindings]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(>=10)-[titleLabel]-(>=10)-|" options:0 metrics:nil views:bindings]];

    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(0)-[button]-(0)-|" options:0 metrics:nil views:bindings]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[button]-(0)-|" options:0 metrics:nil views:bindings]];
    
    self.label = titleLabel;
    return view;
}

- (void)updateFont {
    UIFontDescriptor *descriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleFootnote];
    self.label.font = [UIFont fontWithDescriptor:descriptor size:descriptor.pointSize];
}

@end
