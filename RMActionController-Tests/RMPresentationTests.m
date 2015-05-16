//
//  RMPresentationTests.m
//  RMDateSelectionViewController-Demo
//
//  Created by Roland Moers on 03.01.15.
//  Copyright (c) 2015 Roland Moers. All rights reserved.
//

#import <KIF/KIF.h>
#import <MapKit/MapKit.h>

#define EXPECTED_HEIGHT 384.5

@interface NSDate (Rounding)

- (NSDate *)dateByRoundingToMinutes:(NSInteger)minutes;

@end

@interface RMPresentationTests : KIFTestCase

@end

@implementation RMPresentationTests

#pragma mark - Lifecycle
- (void)beforeEach {
    if([[[UIApplication sharedApplication] keyWindow] accessibilityElementWithLabel:@"Cancel"] != nil) {
        [tester tapViewWithAccessibilityLabel:@"Cancel"];
    }
    
    [system simulateDeviceRotationToOrientation:UIDeviceOrientationPortrait];
    [tester waitForTimeInterval:0.5];
    
    [tester setOn:NO forSwitchWithAccessibilityLabel:@"BlackVersion"];
    
    [tester setOn:YES forSwitchWithAccessibilityLabel:@"BlurEffects"];
    [tester setOn:YES forSwitchWithAccessibilityLabel:@"MotionEffects"];
    [tester setOn:YES forSwitchWithAccessibilityLabel:@"BouncingEffects"];
}

#pragma mark - Tests
- (void)testSelectingLocation {
    [tester tapViewWithAccessibilityLabel:@"ShowActionController"];
    
    UIView *mapViewAsUIView = [tester waitForViewWithAccessibilityLabel:@"MapView"];
    XCTAssertTrue([mapViewAsUIView isKindOfClass:[MKMapView class]]);
    
    [tester tapViewWithAccessibilityLabel:@"Select"];
}

- (void)testCancelingLocationSelection {
    [tester tapViewWithAccessibilityLabel:@"ShowActionController"];
    
    UIView *mapViewAsUIView = [tester waitForViewWithAccessibilityLabel:@"MapView"];
    XCTAssertTrue([mapViewAsUIView isKindOfClass:[MKMapView class]]);
    
    [tester tapViewWithAccessibilityLabel:@"Cancel"];
}

- (void)testPresentingWhiteVersionWithEnabledEffects {
    [tester tapViewWithAccessibilityLabel:@"ShowActionController"];
    
    UIView *datePickerAsUIView = [tester waitForViewWithAccessibilityLabel:@"MapView"];
    UIView *selectButtonAsUIView = [tester waitForViewWithAccessibilityLabel:@"Select"];
    UIView *cancelButtonAsUIView = [tester waitForViewWithAccessibilityLabel:@"Cancel"];
    
    XCTAssertTrue([datePickerAsUIView isKindOfClass:[MKMapView class]]);
    XCTAssertTrue([selectButtonAsUIView isKindOfClass:[UIButton class]]);
    XCTAssertTrue([cancelButtonAsUIView isKindOfClass:[UIButton class]]);
    
    UIView *topContainer = [tester waitForViewWithAccessibilityLabel:@"TopContainer"];
    UIView *bottomContainer = [tester waitForViewWithAccessibilityLabel:@"BottomContainer"];
    
    XCTAssertTrue([topContainer isKindOfClass:[UIVisualEffectView class]]);
    XCTAssertTrue([bottomContainer isKindOfClass:[UIVisualEffectView class]]);
    
    UIView *actionControllerView = [tester waitForViewWithAccessibilityLabel:@"ActionControllerView"];
    XCTAssertTrue([actionControllerView.motionEffects count] == 1);
    
    CGRect frame = actionControllerView.frame;
    [self validateFrame:frame];
    
    [tester tapViewWithAccessibilityLabel:@"Select"];
}

- (void)testPresentingWhiteVersionWithDisabledEffects {
    [tester setOn:NO forSwitchWithAccessibilityLabel:@"BlurEffects"];
    [tester setOn:NO forSwitchWithAccessibilityLabel:@"MotionEffects"];
    [tester setOn:NO forSwitchWithAccessibilityLabel:@"BouncingEffects"];
    
    [tester tapViewWithAccessibilityLabel:@"ShowActionController"];
    
    UIView *datePickerAsUIView = [tester waitForViewWithAccessibilityLabel:@"MapView"];
    UIView *selectButtonAsUIView = [tester waitForViewWithAccessibilityLabel:@"Select"];
    UIView *cancelButtonAsUIView = [tester waitForViewWithAccessibilityLabel:@"Cancel"];
    
    XCTAssertTrue([datePickerAsUIView isKindOfClass:[MKMapView class]]);
    XCTAssertTrue([selectButtonAsUIView isKindOfClass:[UIButton class]]);
    XCTAssertTrue([cancelButtonAsUIView isKindOfClass:[UIButton class]]);
    
    UIView *topContainer = [tester waitForViewWithAccessibilityLabel:@"TopContainer"];
    UIView *bottomContainer = [tester waitForViewWithAccessibilityLabel:@"BottomContainer"];
    
    XCTAssertTrue([topContainer isKindOfClass:[UIView class]]);
    XCTAssertTrue([bottomContainer isKindOfClass:[UIView class]]);
    
    UIView *dateSelectionView = [tester waitForViewWithAccessibilityLabel:@"ActionControllerView"];
    XCTAssertTrue([dateSelectionView.motionEffects count] == 0);
    
    [tester tapViewWithAccessibilityLabel:@"Select"];
}

- (void)testPresentingInLandscape {
    [system simulateDeviceRotationToOrientation:UIDeviceOrientationLandscapeLeft];
    [tester waitForTimeInterval:0.5];
    
    [tester tapViewWithAccessibilityLabel:@"ShowActionController"];
    
    UIView *dateSelectionView = [tester waitForViewWithAccessibilityLabel:@"ActionControllerView"];
    CGRect frame = dateSelectionView.frame;
    [self validateFrame:frame];
    
    [tester tapViewWithAccessibilityLabel:@"Select"];
    
    [system simulateDeviceRotationToOrientation:UIDeviceOrientationPortrait];
    [tester waitForTimeInterval:0.5];
}

- (void)testPresentingInPortraitAndRotatingToLandscape {
    [tester tapViewWithAccessibilityLabel:@"ShowActionController"];
    
    UIView *dateSelectionView = [tester waitForViewWithAccessibilityLabel:@"ActionControllerView"];
    CGRect frame = dateSelectionView.frame;
    [self validateFrame:frame];
    
    [system simulateDeviceRotationToOrientation:UIDeviceOrientationLandscapeLeft];
    [tester waitForTimeInterval:0.5];
    
    frame = dateSelectionView.frame;
    [self validateFrame:frame];
    
    [tester tapViewWithAccessibilityLabel:@"Select"];
    
    [system simulateDeviceRotationToOrientation:UIDeviceOrientationPortrait];
    [tester waitForTimeInterval:0.5];
}

- (void)testPresentingInLandscapeAndRotatingToPortrait {
    [system simulateDeviceRotationToOrientation:UIDeviceOrientationLandscapeLeft];
    [tester waitForTimeInterval:0.5];
    
    [tester tapViewWithAccessibilityLabel:@"ShowActionController"];
    
    UIView *actionControllerView = [tester waitForViewWithAccessibilityLabel:@"ActionControllerView"];
    CGRect frame = actionControllerView.frame;
    [self validateFrame:frame];
    
    [system simulateDeviceRotationToOrientation:UIDeviceOrientationPortrait];
    [tester waitForTimeInterval:0.5];
    
    frame = actionControllerView.frame;
    [self validateFrame:frame];
    
    [tester tapViewWithAccessibilityLabel:@"Select"];
    
    [system simulateDeviceRotationToOrientation:UIDeviceOrientationPortrait];
    [tester waitForTimeInterval:0.5];
}

#pragma mark - Helper
- (void)validateFrame:(CGRect)frame {
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        CGRect screenFrame = [[UIScreen mainScreen] bounds];
        
        XCTAssertEqual(frame.origin.x, 0);
        XCTAssertEqual(frame.origin.y, screenFrame.size.height - EXPECTED_HEIGHT);
        XCTAssertEqual(frame.size.width, screenFrame.size.width);
        XCTAssertEqual(frame.size.height, EXPECTED_HEIGHT);
    } else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        XCTAssertEqual(frame.origin.x, 0);
        XCTAssertEqual(frame.origin.y, 0);
        XCTAssertEqual(frame.size.width, 341);
        XCTAssertEqual(frame.size.height, EXPECTED_HEIGHT + 10);
    }
}

@end
