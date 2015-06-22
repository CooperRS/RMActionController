//
//  RMMapActionController.m
//  RMActionController-Demo
//
//  Created by Roland Moers on 01.05.15.
//  Copyright (c) 2015 Roland Moers. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "RMMapActionController.h"

@interface RMMapActionController ()

@end

@implementation RMMapActionController

#pragma mark - Class
+ (nullable instancetype)actionControllerWithStyle:(RMActionControllerStyle)style title:(nullable NSString *)aTitle message:(nullable NSString *)aMessage selectAction:(nullable RMAction *)selectAction andCancelAction:(nullable RMAction *)cancelAction {
    RMMapActionController *controller = [super actionControllerWithStyle:style title:aTitle message:aMessage selectAction:selectAction andCancelAction:cancelAction];
    
    controller.contentView = [[MKMapView alloc] initWithFrame:CGRectZero];
    controller.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
#ifdef DEBUG
    controller.contentView.accessibilityLabel = @"MapView";
#endif
    
    NSDictionary *bindings = @{@"mapView": controller.contentView};
    [controller.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[mapView(>=300)]" options:0 metrics:nil views:bindings]];
    [controller.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[mapView(200)]" options:0 metrics:nil views:bindings]];
    
    return controller;
}

#pragma mark - Properties
- (BOOL)disableBlurEffectsForContentView {
    return YES;
}

@end
