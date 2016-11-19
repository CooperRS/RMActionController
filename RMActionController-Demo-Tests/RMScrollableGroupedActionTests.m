//
//  RMScrollableGroupedActionTests.m
//  RMActionController-Demo
//
//  Created by Roland Moers on 19.11.16.
//  Copyright © 2016 Roland Moers. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RMAction+Private.h"

@interface RMScrollableGroupedActionTests : XCTestCase

@end

@implementation RMScrollableGroupedActionTests

- (void)testCreatingGroupedAction {
    RMAction *firstAction = [RMAction actionWithTitle:@"First" style:RMActionStyleDefault andHandler:nil];
    RMAction *secondAction = [RMAction actionWithTitle:@"Second" style:RMActionStyleDefault andHandler:nil];
    
    RMScrollableGroupedAction *groupedAction = [RMScrollableGroupedAction actionWithStyle:RMActionStyleAdditional actionWidth:70 andActions:@[firstAction, secondAction]];
    UIScrollView *actionView = (UIScrollView *)groupedAction.view;
    [actionView setNeedsLayout];
    [actionView layoutIfNeeded];
    
    XCTAssertNotNil(actionView);
    XCTAssertTrue([actionView isKindOfClass:[UIScrollView class]]);
    XCTAssertEqual([actionView.subviews count], 2);
    XCTAssertEqual(actionView.contentSize.width, 140);
}

- (void)testCreatingGroupedActionWithDefaultWidth {
    RMAction *firstAction = [RMAction actionWithTitle:@"First" style:RMActionStyleDefault andHandler:nil];
    RMAction *secondAction = [RMAction actionWithTitle:@"Second" style:RMActionStyleDefault andHandler:nil];
    
    RMScrollableGroupedAction *groupedAction = [RMScrollableGroupedAction actionWithStyle:RMActionStyleAdditional andActions:@[firstAction, secondAction]];
    UIScrollView *actionView = (UIScrollView *)groupedAction.view;
    [actionView setNeedsLayout];
    [actionView layoutIfNeeded];
    
    XCTAssertNotNil(actionView);
    XCTAssertTrue([actionView isKindOfClass:[UIScrollView class]]);
    XCTAssertEqual([actionView.subviews count], 2);
    XCTAssertEqual(actionView.contentSize.width, 100);
}

@end
