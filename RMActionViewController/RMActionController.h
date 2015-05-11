//
//  RMActionController.h
//  RMActionController
//
//  Created by Roland Moers on 01.05.15.
//  Copyright (c) 2015 Roland Moers
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>

@class RMAction;

typedef NS_ENUM(NSInteger, RMActionControllerStyle) {
    RMActionControllerStyleWhite,
    RMActionControllerStyleBlack,
    RMActionControllerStyleDefault = RMActionControllerStyleWhite
};

/*
 *
 */
@interface RMActionController : UIViewController <UIAppearanceContainer>

/// @name Getting an Instance
#pragma mark - Getting an Instance

/**
 *
 */
+ (instancetype)actionControllerWithStyle:(RMActionControllerStyle)style;

/*
 *
 */
+ (instancetype)actionControllerWithStyle:(RMActionControllerStyle)style selectAction:(RMAction *)selectAction andCancelAction:(RMAction *)cancelAction;

/*
 *
 */
+ (instancetype)actionControllerWithStyle:(RMActionControllerStyle)style title:(NSString *)aTitle message:(NSString *)aMessage selectAction:(RMAction *)selectAction andCancelAction:(RMAction *)cancelAction;

/*
 *
 */
- (instancetype)initWithStyle:(RMActionControllerStyle)aStyle;

/// @name User Interface
#pragma mark - User Interface

/**
 *
 */
@property (nonatomic, copy) NSString *title;

/**
 *
 */
@property (nonatomic, copy) NSString *message;

/**
 *  When YES taps on the background view are ignored. Default value is NO.
 */
@property (nonatomic, assign) BOOL disableBackgroundTaps;

/// @name Actions
#pragma mark - Actions

/*
 *
 */
@property (nonatomic, readonly) NSArray *actions;

/**
 *
 */
- (void)addAction:(RMAction *)action;

/// @name Content View
#pragma mark - Content View
/*
 *
 */
@property (nonatomic) UIView *contentView;

/// @name Effects
#pragma mark - Effects

/**
 *  Used to enable or disable motion effects. Default value is NO.
 *
 *  @warning This property always returns YES, if motion is reduced via accessibilty options.
 */
@property (assign, nonatomic) BOOL disableMotionEffects;

/**
 *  Used to enable or disable bouncing effects when sliding in the date selection view. Default value is NO.
 *
 *  @warning This property always returns YES, if motion is reduced via accessibilty options.
 */
@property (assign, nonatomic) BOOL disableBouncingEffects;

/**
 *  Used to enable or disable blurring the date selection view. Default value is NO.
 *
 *  @warning This property always returns YES if either UIBlurEffect, UIVibrancyEffect or UIVisualEffectView is not available on your system at runtime or transparency is reduced via accessibility options.
 */
@property (assign, nonatomic) BOOL disableBlurEffects;

/*
 *
 */
@property (assign, nonatomic) BOOL disableBlurEffectsForContentView;

@end

#pragma mark - 

typedef NS_ENUM(NSInteger, RMActionStyle) {
    RMActionStyleDone,
    RMActionStyleCancel,
    RMActionStyleAdditional,
    RMActionStyleDefault = RMActionStyleDone
};

@interface RMAction : NSObject

/// @name Getting an Instance
#pragma mark - Getting an Instance

/*
 *
 */
+ (instancetype)actionWithTitle:(NSString *)title style:(RMActionStyle)style andHandler:(void (^)(RMActionController *controller))handler;

/*
 *
 */
+ (instancetype)actionWithImage:(UIImage *)image style:(RMActionStyle)style andHandler:(void (^)(RMActionController *controller))handler;

/// @name Properties
#pragma mark - Properties

/*
 *
 */
@property (nonatomic, readonly) NSString *title;

/*
 *
 */
@property (nonatomic, readonly) UIImage *image;

/*
 *
 */
@property (nonatomic, readonly) RMActionStyle style;

/*
 *
 */
@property (nonatomic, assign) BOOL dismissesActionController;

@end

#pragma mark -

@interface RMGroupedAction : RMAction

/// @name Getting an Instance
#pragma mark - Getting an Instance

/*
 *
 */
+ (instancetype)actionWithStyle:(RMActionStyle)style andActions:(NSArray *)actions;

@end
