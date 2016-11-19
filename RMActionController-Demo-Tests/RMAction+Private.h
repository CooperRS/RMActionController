//
//  RMAction+Private.h
//  RMActionController-Demo
//
//  Created by Roland Moers on 19.11.16.
//  Copyright © 2016 Roland Moers. All rights reserved.
//

#import <RMActionController/RMActionController.h>

@interface RMAction (Private)

@property (nonatomic, copy) void (^handler)(RMActionController *controller);

- (BOOL)containsCancelAction;
- (void)executeHandlerOfCancelActionWithController:(RMActionController *)controller;

@end
