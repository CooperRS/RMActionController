//
//  RMActionControllerPresentationTests.m
//  RMActionController-Demo-UITests
//
//  Created by Roland Moers on 20.06.15.
//  Copyright © 2015 Roland Moers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@interface RMActionControllerPresentationTests : XCTestCase

@property (nonatomic, assign) BOOL started;

@end

@implementation RMActionControllerPresentationTests

#pragma mark - Lifecycle
- (void)setUp {
    [super setUp];
    
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown {
    [[[XCUIApplication alloc] init] terminate];
    sleep(2);
    
    [super tearDown];
}

#pragma mark - Helper
- (void)verifyCustomActionControllerIsVisibleInApp:(XCUIApplication *)app {
    XCUIElement *actionController = [app descendantsMatchingType:XCUIElementTypeAny][@"ActionControllerView"];
    XCUIElement *backgroundView = [app descendantsMatchingType:XCUIElementTypeAny][@"BackgroundView"];
    XCUIElement *plusLabel = app.staticTexts[@"PlusLabel"];
    XCUIElement *textLabel = app.staticTexts[@"TextLabel"];
    XCUIElement *selectButton = app.buttons[@"Select"];
    XCUIElement *cancelButton = app.buttons[@"Cancel"];
    
    XCTAssertNotNil(actionController);
    XCTAssertNotNil(backgroundView);
    XCTAssertNotNil(plusLabel);
    XCTAssertNotNil(textLabel);
    XCTAssertNotNil(selectButton);
    XCTAssertNotNil(cancelButton);
}

#pragma mark - Tests
- (void)testPresentingActionController {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tables.staticTexts[@"Show sample action view controller…"] tap];
    
    [self verifyCustomActionControllerIsVisibleInApp:app];
    
    [app.buttons[@"Cancel"] tap];
}

- (void)testPresentingBlackActionController {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tables.switches[@"BlackVersion"] tap];
    [app.tables.staticTexts[@"Show sample action view controller…"] tap];
    
    [self verifyCustomActionControllerIsVisibleInApp:app];
    
    [app.buttons[@"Cancel"] tap];
}

- (void)testPresentingWithAllEffectsDisabled {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tables.switches[@"BlurEffects"] tap];
    [app.tables.switches[@"MotionEffects"] tap];
    [app.tables.switches[@"BouncingEffects"] tap];
    [app.tables.staticTexts[@"Show sample action view controller…"] tap];
    
    [self verifyCustomActionControllerIsVisibleInApp:app];
    
    [app.buttons[@"Cancel"] tap];
}

- (void)testPresentingFromPushViewController {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    
    [app.tables.staticTexts[@"Show sample action view controller…"] swipeUp];
    [app.tables.staticTexts[@"Push VC"] tap];
    [app.tables.staticTexts[@"Show sample action view controller…"] tap];
    
    [self verifyCustomActionControllerIsVisibleInApp:app];
    
    [app.buttons[@"Cancel"] tap];
    [app.navigationBars[@"Objective-C Demo"].buttons[@"Objective-C Demo"] tap];
}

@end
