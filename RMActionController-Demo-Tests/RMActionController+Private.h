//
//  RMActionController+Private.h
//  RMActionController-Demo
//
//  Created by Roland Moers on 20.06.15.
//  Copyright © 2015 Roland Moers. All rights reserved.
//

#import "RMActionController.h"

@interface RMAction (Private)

@property (nonatomic, weak) RMActionController *controller;

@property (nonatomic, strong) UIView *view;
- (UIView *)loadView;
- (void)viewTapped:(id)sender;

- (BOOL)containsCancelAction;
- (void)executeHandlerOfCancelActionWithController:(RMActionController *)controller;

@end
