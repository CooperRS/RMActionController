RMActionController [![Build Status](https://travis-ci.org/CooperRS/RMActionController.svg?branch=master)](https://travis-ci.org/CooperRS/RMActionController/) [![Pod Version](https://img.shields.io/cocoapods/v/RMActionController.svg)](https://cocoapods.org/pods/RMActionController)
====================

This is an iOS control for presenting any UIView in an UIActionSheet/UIAlertController like manner.

## Screenshots
### Portrait
![Portrait](http://cooperrs.github.io/RMActionController/Images/Blur-Screen-Portrait.png)
![Colors](http://cooperrs.github.io/RMActionController/Images/Blur-Screen-Portrait-Black.png)|

### Landscape
![Landscape](http://cooperrs.github.com/RMActionController/Images/Blur-Screen-Landscape.png)

## Installation (CocoaPods)
```ruby
platform :ios, '8.0'
pod "RMActionController", "~> 1.1.0"
```

## Usage

For a detailed description on how to use RMActionController take a look at the [Wiki Pages](https://github.com/CooperRS/RMActionController/wiki). The following four steps are a very short intro:

* Create your own subclass of RMActionController. Let's create one for presenting a map and let's call it RMMapActionController:

```objc
@interface RMMapActionController : RMActionController<MKMapView *>
@end
```

* In this subclass overwrite the initializer to add your own content view (for example to add a map as content view):

```objc
@implementation RMMapActionController

- (instancetype)initWithStyle:(RMActionControllerStyle)aStyle title:(NSString *)aTitle message:(NSString *)aMessage selectAction:(RMAction *)selectAction andCancelAction:(RMAction *)cancelAction {
    self = [super initWithStyle:aStyle title:aTitle message:aMessage selectAction:selectAction andCancelAction:cancelAction];
    if(self) {
        self.contentView = [[MKMapView alloc] initWithFrame:CGRectZero];
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;

        NSDictionary *bindings = @{@"mapView": self.contentView};
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[mapView(>=300)]" options:0 metrics:nil views:bindings]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[mapView(200)]" options:0 metrics:nil views:bindings]];
    }
    return self;
}

@end
```

* Present your custom RMActionController:

```objc
- (IBAction)openActionController:(id)sender {
    RMAction *selectAction = [RMAction<MKMapView *> actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController<MKMapView *> *controller) {
        NSLog(@"Action controller selected location: %f, %f", controller.contentView.centerCoordinate.latitude, controller.contentView.centerCoordinate.longitude);
    }];

    RMAction *cancelAction = [RMAction<MKMapView *> actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController<MKMapView *> *controller) {
        NSLog(@"Action controller was canceled");
    }];

    RMMapActionController *actionController = [RMMapActionController actionControllerWithStyle:RMActionControllerStyleWhite title:@"Test" message:@"This is a map action controller.\nPlease select a location and tap 'Select' or 'Cancel'." selectAction:selectAction andCancelAction:cancelAction];

    //Now just present the action controller using the standard iOS presentation method
    [self presentViewController:actionController animated:YES completion:nil];
}
```

* In case you really want to present a map you may want to disable blur effects for the map (as otherwise it will show as black):

```objc
@implementation RMMapActionController

- (BOOL)disableBlurEffectsForContentView {
    return YES;
}

@end
```

## Migration

See [Migration](https://github.com/CooperRS/RMActionController/wiki/Migration) on how to migrate to the latest version of RMActionController.

## Documentation
There is an additional documentation available provided by the CocoaPods team. Take a look at [cocoadocs.org](http://cocoadocs.org/docsets/RMActionController/).

## Requirements

| Compile Time  | Runtime       |
| :------------ | :------------ |
| Xcode 7       | iOS 8         |
| iOS 9 SDK     |               |
| ARC           |               |

Note: ARC can be turned on and off on a per file basis.

## Apps using this control
Using this control in your app or know anyone who does?

Feel free to add the app to this list: [Apps using RMActionController](https://github.com/CooperRS/RMActionController/wiki/Apps-using-RMActionController)

##Credits

* Hannes Tribus (Bugfixes)
* normKei (Destructive button type)

I want to thank everyone who has contributed code and/or time to this project!

## License (MIT License)
Copyright (c) 2015 Roland Moers

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
