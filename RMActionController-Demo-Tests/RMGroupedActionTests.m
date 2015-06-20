//
//  RMGroupedActionTests.m
//  RMActionController-Demo
//
//  Created by Roland Moers on 20.06.15.
//  Copyright © 2015 Roland Moers. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RMActionController.h"

@interface RMGroupedActionTests : XCTestCase

@end

@implementation RMGroupedActionTests

- (void)testCreatingGroupedAction {
    RMAction *firstAction = [RMAction actionWithTitle:@"First" style:RMActionStyleDefault andHandler:nil];
    RMAction *secondAction = [RMAction actionWithTitle:@"Second" style:RMActionStyleDefault andHandler:nil];
    
    RMGroupedAction *groupedAction = [RMGroupedAction actionWithStyle:RMActionStyleDefault andActions:@[firstAction, secondAction]];
    
    XCTAssertNil(groupedAction.title);
    XCTAssertNil(groupedAction.image);
    XCTAssertEqual(groupedAction.style, RMActionStyleDefault);
}

- (void)testCreatingGroupedDoneAction {
    RMAction *firstAction = [RMAction actionWithTitle:@"First" style:RMActionStyleDefault andHandler:nil];
    RMAction *secondAction = [RMAction actionWithTitle:@"Second" style:RMActionStyleDefault andHandler:nil];
    
    RMGroupedAction *groupedAction = [RMGroupedAction actionWithStyle:RMActionStyleDone andActions:@[firstAction, secondAction]];
    
    XCTAssertEqual(groupedAction.style, RMActionStyleDone);
}

- (void)testCreatingGroupedCancelAction {
    RMAction *firstAction = [RMAction actionWithTitle:@"First" style:RMActionStyleDefault andHandler:nil];
    RMAction *secondAction = [RMAction actionWithTitle:@"Second" style:RMActionStyleDefault andHandler:nil];
    
    RMGroupedAction *groupedAction = [RMGroupedAction actionWithStyle:RMActionStyleCancel andActions:@[firstAction, secondAction]];
    
    XCTAssertEqual(groupedAction.style, RMActionStyleCancel);
}

- (void)testCreatingGroupedAdditionalAction {
    RMAction *firstAction = [RMAction actionWithTitle:@"First" style:RMActionStyleDefault andHandler:nil];
    RMAction *secondAction = [RMAction actionWithTitle:@"Second" style:RMActionStyleDefault andHandler:nil];
    
    RMGroupedAction *groupedAction = [RMGroupedAction actionWithStyle:RMActionStyleAdditional andActions:@[firstAction, secondAction]];
    
    XCTAssertEqual(groupedAction.style, RMActionStyleAdditional);
}

- (void)testCreatingGroupedActionWithEmptyArrayThrowsException {
    BOOL catchedException = NO;
    @try {
        [RMGroupedAction actionWithStyle:RMActionStyleAdditional andActions:@[]];
    }
    @catch (NSException *exception) {
        XCTAssertEqualObjects(exception.name, @"NSInternalInconsistencyException");
        XCTAssertEqualObjects(exception.reason, @"Tried to initialize RMGroupedAction with less than one action.");
        
        catchedException = YES;
    }
    @finally {
        XCTAssertTrue(catchedException);
    }
}

- (void)testCreatingGroupedActionWithArrayContainerOneObjectThrowsException {
    RMAction *firstAction = [RMAction actionWithTitle:@"First" style:RMActionStyleDefault andHandler:nil];
    
    BOOL catchedException = NO;
    @try {
        [RMGroupedAction actionWithStyle:RMActionStyleAdditional andActions:@[firstAction]];
    }
    @catch (NSException *exception) {
        XCTAssertEqualObjects(exception.name, @"NSInternalInconsistencyException");
        XCTAssertEqualObjects(exception.reason, @"Tried to initialize RMGroupedAction with one action. Use RMAction in this case.");
        
        catchedException = YES;
    }
    @finally {
        XCTAssertTrue(catchedException);
    }
}

- (void)testCreatingGroupedActionWithArrayContainingObjectsOfTypesOtherThanRMActionThrowsException {
    RMAction *firstAction = [RMAction actionWithTitle:@"First" style:RMActionStyleDefault andHandler:nil];
    RMAction *secondAction = [RMAction actionWithTitle:@"Second" style:RMActionStyleDefault andHandler:nil];
    
    BOOL catchedException = NO;
    @try {
        [RMGroupedAction actionWithStyle:RMActionStyleAdditional andActions:@[firstAction, secondAction, @"Malicious", @(42)]];
    }
    @catch (NSException *exception) {
        XCTAssertEqualObjects(exception.name, @"NSInternalInconsistencyException");
        XCTAssertEqualObjects(exception.reason, @"Tried to initialize RMGroupedAction with objects of types other than RMAction.");
        
        catchedException = YES;
    }
    @finally {
        XCTAssertTrue(catchedException);
    }
}

@end
