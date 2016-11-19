//
//  RMImageActionTests.m
//  RMActionController-Demo
//
//  Created by Roland Moers on 19.11.16.
//  Copyright © 2016 Roland Moers. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RMActionController+Private.h"

@interface RMImageActionTests : XCTestCase

@end

@implementation RMImageActionTests

- (void)testLoadingActionView {
    RMImageAction *action = [RMImageAction actionWithTitle:@"Action" image:[[UIImage alloc] init] style:RMActionStyleDone andHandler:nil];
    UIView *actionView = action.view;
    
    XCTAssertNotNil(actionView);
    XCTAssertTrue([actionView isKindOfClass:[UIView class]]);
    XCTAssertEqual([actionView.subviews count], 3);
}

@end
