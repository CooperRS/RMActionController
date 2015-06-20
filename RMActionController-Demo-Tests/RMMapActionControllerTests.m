//
//  RMMapActionControllerTests.m
//  RMActionController-Demo
//
//  Created by Roland Moers on 20.06.15.
//  Copyright © 2015 Roland Moers. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MapKit/MapKit.h>

#import "RMMapActionController.h"

@interface RMMapActionControllerTests : XCTestCase

@end

@implementation RMMapActionControllerTests

- (void)testPresentingMapActionController {
    RMMapActionController *controller = [RMMapActionController actionControllerWithStyle:RMActionControllerStyleDefault];
    
    XCTAssertTrue(controller.disableBlurEffectsForContentView);
    XCTAssertNotNil(controller.contentView);
    XCTAssertTrue([controller.contentView isKindOfClass:[MKMapView class]]);
    
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
