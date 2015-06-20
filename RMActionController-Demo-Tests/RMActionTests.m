//
//  RMActionTests.m
//  RMActionController-Demo
//
//  Created by Roland Moers on 20.06.15.
//  Copyright © 2015 Roland Moers. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RMActionController.h"
#import "RMActionController+Private.h"

@interface RMActionTests : XCTestCase

@end

@implementation RMActionTests

- (void)testCreatingActionWithTitle {
    RMAction *action = [RMAction actionWithTitle:@"TestAction" style:RMActionStyleDefault andHandler:nil];
    
    XCTAssertEqual(action.style, RMActionStyleDefault);
    XCTAssertEqualObjects(action.title, @"TestAction");
    XCTAssertNil(action.image);
    XCTAssertTrue(action.dismissesActionController);
}

- (void)testCreatingActionWithImage {
    RMAction *action = [RMAction actionWithImage:[[UIImage alloc] init] style:RMActionStyleDefault andHandler:nil];
    
    XCTAssertEqual(action.style, RMActionStyleDefault);
    XCTAssertNil(action.title);
    XCTAssertNotNil(action.image);
    XCTAssertTrue(action.dismissesActionController);
}

- (void)testCreatingDoneAction {
    RMAction *action = [RMAction actionWithTitle:@"TestAction" style:RMActionStyleDone andHandler:nil];
    
    XCTAssertEqual(action.style, RMActionStyleDone);
    XCTAssertFalse([action containsCancelAction]);
}

- (void)testCreatingCancelAction {
    RMAction *action = [RMAction actionWithTitle:@"TestAction" style:RMActionStyleCancel andHandler:nil];
    
    XCTAssertEqual(action.style, RMActionStyleCancel);
    XCTAssertTrue([action containsCancelAction]);
}

- (void)testCreatingAdditionalAction {
    RMAction *action = [RMAction actionWithTitle:@"TestAction" style:RMActionStyleAdditional andHandler:nil];
    
    XCTAssertEqual(action.style, RMActionStyleAdditional);
    XCTAssertFalse([action containsCancelAction]);
}

- (void)testCreatingNonDismissingAction {
    RMAction *action = [RMAction actionWithTitle:@"TestAction" style:RMActionStyleDefault andHandler:nil];
    
    XCTAssertTrue(action.dismissesActionController);
    
    action.dismissesActionController = NO;
    
    XCTAssertFalse(action.dismissesActionController);
}

- (void)testHandlerExecutionWithNonNilHandler {
    __block BOOL executed = NO;
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        executed = YES;
    }];
    
    [cancelAction viewTapped:nil];
    
    XCTAssertTrue(executed);
}

- (void)testHandlerExecutionWithNilHandler {
    RMAction *action = [RMAction actionWithTitle:@"Action" style:RMActionStyleCancel andHandler:nil];
    
    XCTAssertNoThrow([action viewTapped:nil]);
}

- (void)testExecutingCancelAction {
    __block BOOL executed = NO;
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        executed = YES;
    }];
    
    XCTAssertTrue([cancelAction containsCancelAction]);
    
    [cancelAction executeHandlerOfCancelActionWithController:nil];
    
    XCTAssertTrue(executed);
}

- (void)testLoadingActionView {
    RMAction *action = [RMAction actionWithTitle:@"Action" style:RMActionStyleDone andHandler:nil];
    UIView *actionView = action.view;
    
    XCTAssertNotNil(actionView);
    XCTAssertTrue([actionView isKindOfClass:[UIButton class]]);
}

@end
