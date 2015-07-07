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

#pragma mark - Helper
- (RMCustomViewActionController *)createCustomViewActionControllerWithStyle:(RMActionControllerStyle)aStyle {
    RMCustomViewActionController *controller = [RMCustomViewActionController actionControllerWithStyle:aStyle title:@"Test" message:@"This is a test controller." selectAction:nil andCancelAction:nil];
    
    [controller addAction:[RMAction actionWithTitle:@"Select1" style:RMActionStyleDone andHandler:nil]];
    [controller addAction:[RMAction actionWithTitle:@"Select2" style:RMActionStyleDone andHandler:nil]];
    
    [controller addAction:[RMAction actionWithTitle:@"Cancel1" style:RMActionStyleCancel andHandler:nil]];
    [controller addAction:[RMAction actionWithTitle:@"Cancel2" style:RMActionStyleCancel andHandler:nil]];
    
    [controller addAction:[RMAction actionWithTitle:@"Additional1" style:RMActionStyleAdditional andHandler:nil]];
    [controller addAction:[RMAction actionWithTitle:@"Additional2" style:RMActionStyleAdditional andHandler:nil]];
    
    return controller;
}

- (void)presentAndDismissController:(RMActionController *)aController expectingStatusBarStyle:(UIStatusBarStyle)aStyle {
    XCTestExpectation *expectation = [self expectationWithDescription:@"PresentationCompleted"];
    
    BOOL catchedException = NO;
    @try {
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:aController animated:YES completion:^{
            //XCTAssertEqual([UIApplication sharedApplication].statusBarStyle, aStyle);
            
            [expectation fulfill];
        }];
    }
    @catch (NSException *exception) {
        catchedException = YES;
    }
    @finally {
        XCTAssertFalse(catchedException);
    }
    
    [self waitForExpectationsWithTimeout:2 handler:nil];
    
    expectation = [self expectationWithDescription:@"DismissalCompleted"];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:^{
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:2 handler:nil];
}

#pragma mark - Tests
- (void)testPresentingWhiteCustomViewActionController {
    RMCustomViewActionController *controller = [self createCustomViewActionControllerWithStyle:RMActionControllerStyleWhite];
    
    XCTAssertNotNil(controller.contentView);
    XCTAssertTrue([controller.contentView isKindOfClass:[UIView class]]);
    
    [self presentAndDismissController:controller expectingStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)testPresentingBlackCustomViewActionController {
    RMCustomViewActionController *controller = [RMCustomViewActionController actionControllerWithStyle:RMActionControllerStyleBlack];
    
    XCTAssertNotNil(controller.contentView);
    XCTAssertTrue([controller.contentView isKindOfClass:[UIView class]]);
    
    [self presentAndDismissController:controller expectingStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)testPresentingCustomViewActionControllerWithMessage {
    RMCustomViewActionController *controller = [RMCustomViewActionController actionControllerWithStyle:RMActionControllerStyleWhite title:nil message:@"This is a test controller" selectAction:nil andCancelAction:nil];
    
    [self presentAndDismissController:controller expectingStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)testPresentingCustomViewActionControllerWithTitle {
    RMCustomViewActionController *controller = [RMCustomViewActionController actionControllerWithStyle:RMActionControllerStyleWhite title:@"Test" message:nil selectAction:nil andCancelAction:nil];
    
    [self presentAndDismissController:controller expectingStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)testPresentingCustomViewActionControllerWithAdditionalAction {
    RMCustomViewActionController *controller = [RMCustomViewActionController actionControllerWithStyle:RMActionControllerStyleWhite title:nil message:nil selectAction:nil andCancelAction:nil];
    [controller addAction:[RMAction actionWithTitle:@"Additional" style:RMActionStyleAdditional andHandler:nil]];
    
    [self presentAndDismissController:controller expectingStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)testPresentingCustomViewActionControllerWithOneCancelAction {
    RMCustomViewActionController *controller = [RMCustomViewActionController actionControllerWithStyle:RMActionControllerStyleWhite];
    [controller addAction:[RMAction actionWithTitle:@"Cancel1" style:RMActionStyleCancel andHandler:nil]];
    
    [self presentAndDismissController:controller expectingStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)testPresentingWhiteCustomViewActionControllerWithEffectsDisabled {
    RMCustomViewActionController *controller = [self createCustomViewActionControllerWithStyle:RMActionControllerStyleWhite];
    
    controller.disableBlurEffects = YES;
    controller.disableBouncingEffects = YES;
    controller.disableMotionEffects = YES;
    
    [self presentAndDismissController:controller expectingStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)testPresentingBlackCustomViewActionControllerWithEffectsDisabled {
    RMCustomViewActionController *controller = [self createCustomViewActionControllerWithStyle:RMActionControllerStyleBlack];
    
    controller.disableBlurEffects = YES;
    controller.disableBouncingEffects = YES;
    controller.disableMotionEffects = YES;
    
    [self presentAndDismissController:controller expectingStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)testPresentingCustomViewActionControllerWithDestructiveActionAndEffectsDisabled {
    RMCustomViewActionController *controller = [RMCustomViewActionController actionControllerWithStyle:RMActionControllerStyleWhite title:nil message:nil selectAction:nil andCancelAction:nil];
    [controller addAction:[RMAction actionWithTitle:@"Delete" style:RMActionStyleDestructive andHandler:nil]];
    
    controller.disableBlurEffects = YES;
    controller.disableBouncingEffects = YES;
    controller.disableMotionEffects = YES;
    
    [self presentAndDismissController:controller expectingStatusBarStyle:UIStatusBarStyleLightContent];
}

@end
