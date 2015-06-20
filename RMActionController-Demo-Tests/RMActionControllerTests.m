//
//  RMActionController_Demo_Tests.m
//  RMActionController-Demo-Tests
//
//  Created by Roland Moers on 20.06.15.
//  Copyright © 2015 Roland Moers. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RMActionController.h"
#import "RMActionController+Private.h"

@interface RMActionControllerTests : XCTestCase

@end

@implementation RMActionControllerTests

- (void)testCreatingEmptyActionControllerWithoutTitleMessageAndActions {
    RMActionController *controller = [RMActionController actionControllerWithStyle:RMActionControllerStyleDefault];
    
    XCTAssertEqual(controller.style, RMActionControllerStyleDefault);
    XCTAssertEqual(controller.preferredStatusBarStyle, UIStatusBarStyleLightContent);
    XCTAssertNil(controller.title);
    XCTAssertNil(controller.message);
    
    XCTAssertFalse(controller.disableBackgroundTaps);
    XCTAssertFalse(controller.disableBlurEffects);
    XCTAssertFalse(controller.disableBlurEffectsForBackgroundView);
    XCTAssertFalse(controller.disableBlurEffectsForContentView);
    XCTAssertFalse(controller.disableBouncingEffects);
    XCTAssertFalse(controller.disableMotionEffects);
    
    XCTAssertNil(controller.contentView);
    
    XCTAssertNotNil(controller.actions);
    XCTAssertEqual([controller.actions count], (NSUInteger)0);
}

- (void)testCreatingEmptyActionControllerWithBlackStyle {
    RMActionController *controller = [RMActionController actionControllerWithStyle:RMActionControllerStyleBlack];
    
    XCTAssertEqual(controller.style, RMActionControllerStyleBlack);
    XCTAssertEqual(controller.preferredStatusBarStyle, UIStatusBarStyleDefault);
}

- (void)testCreatingEmptyActionControllerWithWhiteStyle {
    RMActionController *controller = [RMActionController actionControllerWithStyle:RMActionControllerStyleWhite];
    
    XCTAssertEqual(controller.style, RMActionControllerStyleWhite);
    XCTAssertEqual(controller.preferredStatusBarStyle, UIStatusBarStyleLightContent);
}

- (void)testCreatingEmptyActionControllerWithSelectAction {
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:nil];
    
    RMActionController *controller = [RMActionController actionControllerWithStyle:RMActionControllerStyleDefault selectAction:selectAction andCancelAction:nil];
    
    XCTAssertEqual(controller.style, RMActionControllerStyleDefault);
    
    XCTAssertNotNil(controller.actions);
    XCTAssertEqual([controller.actions count], (NSUInteger)1);
    
    RMAction *firstAction = controller.actions[0];
    XCTAssertTrue([firstAction isKindOfClass:[RMAction class]]);
    XCTAssertEqual(firstAction, selectAction);
}

- (void)testCreatingEmptyActionControllerWithCancelAction {
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:nil];
    
    RMActionController *controller = [RMActionController actionControllerWithStyle:RMActionControllerStyleDefault selectAction:nil andCancelAction:cancelAction];
    
    XCTAssertEqual(controller.style, RMActionControllerStyleDefault);
    
    XCTAssertNotNil(controller.actions);
    XCTAssertEqual([controller.actions count], (NSUInteger)1);
    
    RMAction *firstAction = controller.actions[0];
    XCTAssertTrue([firstAction isKindOfClass:[RMAction class]]);
    XCTAssertEqual(firstAction, cancelAction);
}

- (void)testCreatingEmptyActionControllerWithTitleMessageAndActions {
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:nil];
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:nil];
    
    RMActionController *controller = [RMActionController actionControllerWithStyle:RMActionControllerStyleDefault title:@"TestTitle" message:@"TestMessage" selectAction:selectAction andCancelAction:cancelAction];
    
    XCTAssertEqual(controller.style, RMActionControllerStyleDefault);
    XCTAssertEqualObjects(controller.title, @"TestTitle");
    XCTAssertEqualObjects(controller.message, @"TestMessage");
    
    XCTAssertFalse(controller.disableBackgroundTaps);
    XCTAssertFalse(controller.disableBlurEffects);
    XCTAssertFalse(controller.disableBlurEffectsForBackgroundView);
    XCTAssertFalse(controller.disableBlurEffectsForContentView);
    XCTAssertFalse(controller.disableBouncingEffects);
    XCTAssertFalse(controller.disableMotionEffects);
    
    XCTAssertNil(controller.contentView);
    
    XCTAssertNotNil(controller.actions);
    XCTAssertEqual([controller.actions count], (NSUInteger)1);
    
    RMAction *firstAction = controller.actions[0];
    XCTAssertTrue([firstAction isKindOfClass:[RMGroupedAction class]]);
    
    RMGroupedAction *groupedAction = (RMGroupedAction *)firstAction;
    
    XCTAssertEqual(groupedAction.controller, controller);
    XCTAssertNotNil(groupedAction.actions);
    XCTAssertEqual([groupedAction.actions count], (NSUInteger)2);
    
    RMAction *firstGroupedAction = groupedAction.actions[0];
    RMAction *secondGroupedAction = groupedAction.actions[1];
    
    XCTAssertEqual(firstGroupedAction, cancelAction);
    XCTAssertEqual(secondGroupedAction, selectAction);
    
    XCTAssertEqual(firstGroupedAction.controller, controller);
    XCTAssertEqual(secondGroupedAction.controller, controller);
}

- (void)testSettingTitleAndMessage {
    RMActionController *controller = [RMActionController actionControllerWithStyle:RMActionControllerStyleDefault];
    
    XCTAssertNil(controller.title);
    XCTAssertNil(controller.message);
    
    controller.title = @"TestTitle";
    controller.message = @"TestMessage";
    
    XCTAssertEqualObjects(controller.title, @"TestTitle");
    XCTAssertEqualObjects(controller.message, @"TestMessage");
}

- (void)testDisablingBackgroundTaps {
    RMActionController *controller = [RMActionController actionControllerWithStyle:RMActionControllerStyleDefault];
    
    XCTAssertFalse(controller.disableBackgroundTaps);
    
    controller.disableBackgroundTaps = YES;
    
    XCTAssertTrue(controller.disableBackgroundTaps);
}

- (void)testDisablingBlurEffects {
    RMActionController *controller = [RMActionController actionControllerWithStyle:RMActionControllerStyleDefault];
    
    XCTAssertFalse(controller.disableBlurEffects);
    XCTAssertFalse(controller.disableBlurEffectsForBackgroundView);
    XCTAssertFalse(controller.disableBlurEffectsForContentView);
    
    controller.disableBlurEffects = YES;
    
    XCTAssertTrue(controller.disableBlurEffects);
    XCTAssertTrue(controller.disableBlurEffectsForBackgroundView);
    XCTAssertTrue(controller.disableBlurEffectsForContentView);
    
    controller.disableBlurEffects = NO;
    controller.disableBlurEffectsForBackgroundView = YES;
    
    XCTAssertFalse(controller.disableBackgroundTaps);
    XCTAssertTrue(controller.disableBlurEffectsForBackgroundView);
    XCTAssertFalse(controller.disableBlurEffectsForContentView);
    
    controller.disableBlurEffectsForBackgroundView = NO;
    controller.disableBlurEffectsForContentView = YES;
    
    XCTAssertFalse(controller.disableBackgroundTaps);
    XCTAssertFalse(controller.disableBlurEffectsForBackgroundView);
    XCTAssertTrue(controller.disableBlurEffectsForContentView);
}

- (void)testDisablingMotionAndBouncingEffects {
    RMActionController *controller = [RMActionController actionControllerWithStyle:RMActionControllerStyleDefault];
    
    XCTAssertFalse(controller.disableMotionEffects);
    XCTAssertFalse(controller.disableBouncingEffects);
    
    controller.disableMotionEffects = YES;
    controller.disableBouncingEffects = YES;
    
    XCTAssertTrue(controller.disableMotionEffects);
    XCTAssertTrue(controller.disableBouncingEffects);
}

- (void)testPresentingEmptyActionControllerThrowsException {
    RMActionController *controller = [RMActionController actionControllerWithStyle:RMActionControllerStyleDefault];
    
    BOOL catchedException = NO;
    @try {
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:controller animated:YES completion:nil];
    }
    @catch (NSException *exception) {
        XCTAssertEqualObjects(exception.name, @"NSInternalInconsistencyException");
        XCTAssertEqualObjects(exception.reason, @"Error: The view of an RMActionController has been loaded before a contentView has been set. You have to set the contentView before presenting a RMActionController.");
        
        catchedException = YES;
    }
    @finally {
        XCTAssertTrue(catchedException);
    }
}

@end
