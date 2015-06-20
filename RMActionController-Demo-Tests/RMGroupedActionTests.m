//
//  RMGroupedActionTests.m
//  RMActionController-Demo
//
//  Created by Roland Moers on 20.06.15.
//  Copyright © 2015 Roland Moers. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RMActionController.h"
#import "RMActionController+Private.h"

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
    XCTAssertFalse([groupedAction containsCancelAction]);
}

- (void)testCreatingGroupedDoneAction {
    RMAction *firstAction = [RMAction actionWithTitle:@"First" style:RMActionStyleDefault andHandler:nil];
    RMAction *secondAction = [RMAction actionWithTitle:@"Second" style:RMActionStyleDefault andHandler:nil];
    
    RMGroupedAction *groupedAction = [RMGroupedAction actionWithStyle:RMActionStyleDone andActions:@[firstAction, secondAction]];
    
    XCTAssertEqual(groupedAction.style, RMActionStyleDone);
    XCTAssertFalse([groupedAction containsCancelAction]);
}

- (void)testCreatingGroupedCancelAction {
    RMAction *firstAction = [RMAction actionWithTitle:@"First" style:RMActionStyleDefault andHandler:nil];
    RMAction *secondAction = [RMAction actionWithTitle:@"Second" style:RMActionStyleDefault andHandler:nil];
    
    RMGroupedAction *groupedAction = [RMGroupedAction actionWithStyle:RMActionStyleCancel andActions:@[firstAction, secondAction]];
    
    XCTAssertEqual(groupedAction.style, RMActionStyleCancel);
    XCTAssertFalse([groupedAction containsCancelAction]);
}

- (void)testCreatingGroupedAdditionalAction {
    RMAction *firstAction = [RMAction actionWithTitle:@"First" style:RMActionStyleDefault andHandler:nil];
    RMAction *secondAction = [RMAction actionWithTitle:@"Second" style:RMActionStyleDefault andHandler:nil];
    
    RMGroupedAction *groupedAction = [RMGroupedAction actionWithStyle:RMActionStyleAdditional andActions:@[firstAction, secondAction]];
    
    XCTAssertEqual(groupedAction.style, RMActionStyleAdditional);
    XCTAssertFalse([groupedAction containsCancelAction]);
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

- (void)testExecutionOfCancelActionInGroupedAction {
    __block BOOL firstExecuted = NO;
    __block BOOL secondExecuted = NO;
    __block BOOL thirdExecuted = NO;
    
    RMAction *firstAction = [RMAction actionWithTitle:@"First" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        firstExecuted = YES;
    }];
    
    RMAction *secondAction = [RMAction actionWithTitle:@"Second" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        secondExecuted = YES;
    }];
    
    RMAction *thirdAction = [RMAction actionWithTitle:@"Third" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        thirdExecuted = YES;
    }];
    
    RMGroupedAction *groupedAction = [RMGroupedAction actionWithStyle:RMActionStyleDone andActions:@[firstAction, secondAction, thirdAction]];
    
    XCTAssertTrue([groupedAction containsCancelAction]);
    
    [groupedAction executeHandlerOfCancelActionWithController:nil];
    
    XCTAssertFalse(firstExecuted);
    XCTAssertTrue(secondExecuted);
    XCTAssertFalse(thirdExecuted);
}

- (void)testLoadingGroupedActionView {
    RMAction *firstAction = [RMAction actionWithTitle:@"First" style:RMActionStyleDone andHandler:nil];
    RMAction *secondAction = [RMAction actionWithTitle:@"Second" style:RMActionStyleCancel andHandler:nil];
    
    RMGroupedAction *action = [RMGroupedAction actionWithStyle:RMActionStyleDefault andActions:@[firstAction, secondAction]];
    UIView *actionView = action.view;
    
    XCTAssertNotNil(actionView);
    XCTAssertTrue([actionView isKindOfClass:[UIView class]]);
}

- (void)testCreatingGroupedActionWithActionInitializerThrowsException {
    BOOL catchedException = NO;
    @try {
        [RMGroupedAction actionWithTitle:@"Test" style:RMActionStyleDefault andHandler:nil];
    }
    @catch (NSException *exception) {
        XCTAssertEqualObjects(exception.name, @"RMIllegalCallException");
        XCTAssertEqualObjects(exception.reason, @"Tried to initialize a grouped action with +[RMGroupedAction actionWithTitle:style:andHandler:]. Please use +[RMGroupedAction actionWithStyle:andActions:] instead.");
        
        catchedException = YES;
    }
    @finally {
        XCTAssertTrue(catchedException);
    }
    
    catchedException = NO;
    @try {
        [RMGroupedAction actionWithImage:[[UIImage alloc] init] style:RMActionStyleDefault andHandler:nil];
    }
    @catch (NSException *exception) {
        XCTAssertEqualObjects(exception.name, @"RMIllegalCallException");
        XCTAssertEqualObjects(exception.reason, @"Tried to initialize a grouped action with +[RMGroupedAction actionWithImage:style:andHandler:]. Please use +[RMGroupedAction actionWithStyle:andActions:] instead.");
        
        catchedException = YES;
    }
    @finally {
        XCTAssertTrue(catchedException);
    }
}

@end
