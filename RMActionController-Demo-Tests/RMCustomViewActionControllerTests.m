//
//  RMCustomViewActionControllerTests.m
//  RMActionController-Demo
//
//  Created by Roland Moers on 20.06.15.
//  Copyright © 2015 Roland Moers. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RMCustomViewActionController.h"

@interface RMCustomViewActionControllerTests : XCTestCase

@end

@implementation RMCustomViewActionControllerTests

- (void)testPresentingCustomViewActionController {
    RMCustomViewActionController *controller = [RMCustomViewActionController actionControllerWithStyle:RMActionControllerStyleDefault];
    
    XCTAssertNotNil(controller.contentView);
    
    BOOL catchedException = NO;
    @try {
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:controller animated:NO completion:nil];
    }
    @catch (NSException *exception) {
        catchedException = YES;
    }
    @finally {
        XCTAssertFalse(catchedException);
    }
}

@end
