//
//  RMActionController+Private.h
//  RMActionController-Demo
//
//  Created by Roland Moers on 20.06.15.
//  Copyright © 2015 Roland Moers. All rights reserved.
//

#import "RMActionController.h"

@interface RMActionController ()

@property (nonatomic, strong) NSMutableArray *additionalActions;
@property (nonatomic, strong) NSMutableArray *doneActions;
@property (nonatomic, strong) NSMutableArray *cancelActions;

@property (nonatomic, strong) UIView *backgroundView;

- (UIBlurEffectStyle)containerBlurEffectStyleForCurrentStyle;
- (UIBlurEffectStyle)backgroundBlurEffectStyleForCurrentStyle;

- (void)backgroundViewTapped:(UIGestureRecognizer *)sender;

@end

@interface RMAction (Private)

@property (nonatomic, weak) RMActionController *controller;

@property (nonatomic, strong) UIView *view;
- (UIView *)loadView;
- (void)viewTapped:(id)sender;

- (BOOL)containsCancelAction;
- (void)executeHandlerOfCancelActionWithController:(RMActionController *)controller;

@end
