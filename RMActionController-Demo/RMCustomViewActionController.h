//
//  RMCustomViewActionController.h
//  RMActionController-Demo
//
//  Created by Roland Moers on 17.05.15.
//  Copyright (c) 2015 Roland Moers. All rights reserved.
//

#import "RMActionController.h"

/*
 *  RMCustomViewActionController is a simple example showing how to subclass RMActionController and show custom content in the action controller.
 *
 *  For another example see RMMapActionController in this project. Additionally, I published two more RMActionController subclasses called RMDateSelectionViewController and RMPickerViewController. You can find them on GitHub.
 */
@interface RMCustomViewActionController : RMActionController<UIView *>

@end
