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

@property (nonatomic, readwrite) MKMapView *mapView;

@end

@implementation RMMapActionController

#pragma mark - Class
+ (instancetype)actionControllerWithStyle:(RMActionControllerStyle)style title:(NSString *)aTitle message:(NSString *)aMessage selectAction:(RMAction *)selectAction andCancelAction:(RMAction *)cancelAction {
    RMMapActionController *controller = [super actionControllerWithStyle:style title:aTitle message:aMessage selectAction:selectAction andCancelAction:cancelAction];
    
    controller.mapView = [[MKMapView alloc] initWithFrame:CGRectZero];
    controller.mapView.translatesAutoresizingMaskIntoConstraints = NO;
    
#ifdef DEBUG
    controller.mapView.accessibilityLabel = @"MapView";
#endif
    
    NSDictionary *bindings = @{@"mapView": controller.mapView};
    [controller.mapView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[mapView(>=300)]" options:0 metrics:nil views:bindings]];
    [controller.mapView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[mapView(200)]" options:0 metrics:nil views:bindings]];
    
    return controller;
}

#pragma mark - Properties
- (UIView *)contentView {
    return self.mapView;
}

- (BOOL)disableBlurEffectsForContentView {
    return YES;
}

@end
