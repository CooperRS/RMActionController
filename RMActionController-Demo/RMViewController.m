//
//  RMViewController.m
//  RMActionController-Demo
//
//  Created by Roland Moers on 26.10.13.
//  Copyright (c) 2013-2015 Roland Moers
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

#import "RMViewController.h"

#import "RMCustomViewActionController.h"
#import "RMMapActionController.h"

@interface RMViewController ()

@property (nonatomic, weak) IBOutlet UISwitch *blackSwitch;
@property (nonatomic, weak) IBOutlet UISwitch *blurSwitch;
@property (nonatomic, weak) IBOutlet UISwitch *motionSwitch;
@property (nonatomic, weak) IBOutlet UISwitch *bouncingSwitch;

@end

@implementation RMViewController

#pragma mark - Actions
- (IBAction)openCustomViewActionController:(id)sender {
    RMActionControllerStyle style = RMActionControllerStyleWhite;
    if(self.blackSwitch.on) {
        style = RMActionControllerStyleBlack;
    }
    
    RMAction *selectAction = [RMAction<RMCustomViewActionController *> actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMCustomViewActionController *controller) {
        NSLog(@"Action controller finished successfully");
    }];
    
    RMAction *cancelAction = [RMAction<RMCustomViewActionController *> actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMCustomViewActionController *controller) {
        NSLog(@"Action controller was canceled");
    }];
    
    RMCustomViewActionController *actionController = [RMCustomViewActionController actionControllerWithStyle:style];
    actionController.title = @"Test";
    actionController.message = @"This is a test action controller.\nPlease tap 'Select' or 'Cancel'.";
    
    [actionController addAction:selectAction];
    [actionController addAction:cancelAction];
    
    //You can enable or disable blur, bouncing and motion effects
    actionController.disableBouncingEffects = !self.bouncingSwitch.on;
    actionController.disableMotionEffects = !self.motionSwitch.on;
    actionController.disableBlurEffects = !self.blurSwitch.on;
    
    //On the iPad we want to show the map action controller within a popover. Fortunately, we can use iOS 8 API for this! :)
    //(Of course only if we are running on iOS 8 or later)
    if([actionController respondsToSelector:@selector(popoverPresentationController)] && [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        //First we set the modal presentation style to the popover style
        actionController.modalPresentationStyle = UIModalPresentationPopover;
        
        //Then we tell the popover presentation controller, where the popover should appear
        actionController.popoverPresentationController.sourceView = self.tableView;
        actionController.popoverPresentationController.sourceRect = [self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    
    //Now just present the date selection controller using the standard iOS presentation method
    [self presentViewController:actionController animated:YES completion:nil];
}

- (IBAction)openMapActionController:(id)sender {
    RMActionControllerStyle style = RMActionControllerStyleWhite;
    if(self.blackSwitch.on) {
        style = RMActionControllerStyleBlack;
    }
    
    RMAction *selectAction = [RMAction<RMMapActionController *> actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMMapActionController *controller) {
        NSLog(@"Action controller selected location: %f, %f", controller.contentView.centerCoordinate.latitude, controller.contentView.centerCoordinate.longitude);
    }];
    
    RMAction *cancelAction = [RMAction<RMMapActionController *> actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMMapActionController *controller) {
        NSLog(@"Action controller was canceled");
    }];
    
    RMMapActionController *actionController = [RMMapActionController actionControllerWithStyle:style];
    actionController.title = @"Test";
    actionController.message = @"This is a map action controller.\nPlease select a location and tap 'Select' or 'Cancel'.";
    
    [actionController addAction:selectAction];
    [actionController addAction:cancelAction];
    
    //You can enable or disable blur, bouncing and motion effects
    actionController.disableBouncingEffects = !self.bouncingSwitch.on;
    actionController.disableMotionEffects = !self.motionSwitch.on;
    actionController.disableBlurEffects = !self.blurSwitch.on;
    
    //On the iPad we want to show the map action controller within a popover. Fortunately, we can use iOS 8 API for this! :)
    //(Of course only if we are running on iOS 8 or later)
    if([actionController respondsToSelector:@selector(popoverPresentationController)] && [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        //First we set the modal presentation style to the popover style
        actionController.modalPresentationStyle = UIModalPresentationPopover;
        
        //Then we tell the popover presentation controller, where the popover should appear
        actionController.popoverPresentationController.sourceView = self.tableView;
        actionController.popoverPresentationController.sourceRect = [self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    
    //Now just present the date selection controller using the standard iOS presentation method
    [self presentViewController:actionController animated:YES completion:nil];
}

#pragma mark - UITableView Delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 && indexPath.row == 0) {
        [self openCustomViewActionController:self];
        //[self openMapActionController:self];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
