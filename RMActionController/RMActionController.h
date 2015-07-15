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

/**
 *  RMActionControllerStyle is used to determine the display style of RMActionController. There are three styles available: White, black and the default style, which is white.
 */
typedef NS_ENUM(NSInteger, RMActionControllerStyle) {
    /** Displays a RMActionController with a light background. */
    RMActionControllerStyleWhite,
    /** Displays a RMActionController with a dark background. */
    RMActionControllerStyleBlack,
    /** Displays a RMActionController with the default background (which is currently light). */
    RMActionControllerStyleDefault = RMActionControllerStyleWhite
};

/**
 *  A RMActionController displays some arbitrary view in a UIActionSheet/UIAlertController like manner to the user. It is used by RMDateSelectionViewController and RMPickerViewController.
 *
 *  Usually, RMActionController is subclassed to display custom content views. See RMDateSelectionViewController and RMPickerViewController on how this works.
 */
@interface RMActionController : UIViewController <UIAppearanceContainer>

/// @name Getting an Instance
#pragma mark - Getting an Instance

/**
 *  Returns a new instance of RMActionController.
 *
 *  @param style The action controller style for the new instance.
 *
 *  @return A new instance of RMActionController.
 */
+ (instancetype)actionControllerWithStyle:(RMActionControllerStyle)style;

/**
 *  Returns a new instance of RMActionController.
 *
 *  @param style        The action controller style for the new instance.
 *  @param selectAction An instance of RMAction whos handler is called when the select button is tapped.
 *  @param cancelAction An instance of RMAction whos handler is called when the cancel button is tapped.
 *
 *  @return A new instance of RMActionController.
 */
+ (instancetype)actionControllerWithStyle:(RMActionControllerStyle)style selectAction:(RMAction *)selectAction andCancelAction:(RMAction *)cancelAction;

/**
 *  Returns a new instance of RMActionController.
 *
 *  @param style        The action controller style for the new instance.
 *  @param aTitle       A title for the RMActionController
 *  @param aMessage     A message explaining why the RMActionController is shown.
 *  @param selectAction An instance of RMAction whos handler is called when the select button is tapped.
 *  @param cancelAction An instance of RMAction whos handler is called when the cancel button is tapped.
 *
 *  @return A new instance of RMActionController.
 */
+ (instancetype)actionControllerWithStyle:(RMActionControllerStyle)style title:(NSString *)aTitle message:(NSString *)aMessage selectAction:(RMAction *)selectAction andCancelAction:(RMAction *)cancelAction;

/**
 *  Initializes a new instance of RMActionController.
 *
 *  Overwrite this method when subclassing RMActionController. Initialize the custom content view and set the content view of the RMActionController to your content view in this method.
 *
 *  @param aStyle The action controller style for the new instance.
 *
 *  @return An initialized of RMActionController.
 */
- (instancetype)initWithStyle:(RMActionControllerStyle)aStyle;

/// @name User Interface
#pragma mark - User Interface

/**
 *  The display style of the RMActionController.
 */
@property (nonatomic, assign, readonly) RMActionControllerStyle style;

/**
 *  A title for the RMActionController.
 */
@property (nonatomic, copy) NSString *title;

/**
 *  A message explaining why the RMActionController is shown.
 */
@property (nonatomic, copy) NSString *message;

/**
 *  When YES taps on the background view are ignored. Default value is NO.
 */
@property (nonatomic, assign) BOOL disableBackgroundTaps;

/// @name Actions
#pragma mark - Actions

/**
 *  An array of actions that has been added to the RMActionController
 */
@property (nonatomic, readonly) NSArray *actions;

/**
 *  Use this method to add further actions to the RMActionController.
 *
 *  @param action The instance of RMAction to add.
 */
- (void)addAction:(RMAction *)action;

/// @name Content View
#pragma mark - Content View

/**
 *  The content view of the RMActionController.
 *
 *  Overwrite this method in a subclass of RMActionController and return your custom content view.
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
 *  Used to enable or disable bouncing effects when sliding in the RMActionController. Default value is NO.
 *
 *  @warning This property always returns YES, if motion is reduced via accessibilty options.
 */
@property (assign, nonatomic) BOOL disableBouncingEffects;

/**
 *  Used to enable or disable blurring the RMActionController. Default value is NO.
 *
 *  @warning This property always returns YES if either UIBlurEffect, UIVibrancyEffect or UIVisualEffectView is not available on your system at runtime or transparency is reduced via accessibility options.
 */
@property (assign, nonatomic) BOOL disableBlurEffects;

/**
 *  Used to enable or disable blurring the RMActionController content view.
 *
 *  Overwrite this method in subclasses of RMActionController if your custom content view cannot be shown within an UIVisualEffectView.
 *
 *  @warning This property always returns YES, if disableBlurEffects returns YES.
 */
@property (assign, nonatomic) BOOL disableBlurEffectsForContentView;

/**
 *  Used to enable or disable blurring the background of RMActionController.
 *
 *  @warning This property always returns YES, if disableBlurEffects returns YES.
 */
@property (assign, nonatomic) BOOL disableBlurEffectsForBackgroundView;

@end

#pragma mark -

/**
 *  RMActionStyle is used to determine the display style of RMAction and where it is positioned. There are 4 styles available: Done, cancel, additional and the default style, which is the done style.
 */
typedef NS_ENUM(NSInteger, RMActionStyle) {
    /** The button is displayed with a regular font and positioned right below the content view. */
    RMActionStyleDone,
    /** The button is displayed with a bold font and positioned below all done buttons (or the content view if there are no done buttons). */
    RMActionStyleCancel,
    /** The button is displayed with a standard destructive and positioned right below the content view. Currently only supported when blur effects are disabled.*/
    RMActionStyleDestructive,
    /** The button is displayed with a regular font and positioned above the content view. */
    RMActionStyleAdditional,
    /** The button is displayed and positioned like a done button. */
    RMActionStyleDefault = RMActionStyleDone
};

/**
 *  A RMAction instance represents an action that can be tapped by the use when a RMActionController is presented. It has a title or image for identifying the action and a handler which is calledwhen the action has been tapped by the user.
 */
@interface RMAction : NSObject

/// @name Getting an Instance
#pragma mark - Getting an Instance

/**
 *  Returns a new instance of RMAction.
 *
 *  @param title   The title of the action.
 *  @param style   The style of the action.
 *  @param handler A block that is called when the action has been tapped.
 *
 *  @return The new instance of RMAction.
 */
+ (instancetype)actionWithTitle:(NSString *)title style:(RMActionStyle)style andHandler:(void (^)(RMActionController *controller))handler;

/**
 *  Returns a new instance of RMAction.
 *
 *  @param image   The image of the action.
 *  @param style   The style of the action.
 *  @param handler A block that is called when the action has been tapped.
 *
 *  @return The new instance of RMAction.
 */
+ (instancetype)actionWithImage:(UIImage *)image style:(RMActionStyle)style andHandler:(void (^)(RMActionController *controller))handler;

/// @name Properties
#pragma mark - Properties

/**
 *  The title of the action.
 */
@property (nonatomic, readonly) NSString *title;

/**
 *  The image of the action.
 */
@property (nonatomic, readonly) UIImage *image;

/**
 *  The style of the action.
 */
@property (nonatomic, readonly) RMActionStyle style;

/**
 *  Control whether or not the RMActionController to whom the RMAction has been added is dismissed when the RMAction has been tapped.
 */
@property (nonatomic, assign) BOOL dismissesActionController;

@end

#pragma mark -

/**
 *  A RMGroupedAction instance represents a number of actions that can be grouped.
 *
 *  Normally, a RMActionController uses one row for every action that has been added. RMGroupedActions offers the possibility to show multiple RMActions in one row.
 */
@interface RMGroupedAction : RMAction

/// @name Getting an Instance
#pragma mark - Getting an Instance

/**
 *  Returns a new instance of RMGroupedAction.
 *
 *  @param style   The style of the action.
 *  @param actions The actions that are contained in the grouped action.
 *
 *  @return The new instance of RMGroupedAction
 */
+ (instancetype)actionWithStyle:(RMActionStyle)style andActions:(NSArray *)actions;

/**
 *  An array of actions the RMGroupedAction consists of.
 */
@property (nonatomic, strong, readonly) NSArray *actions;

@end
