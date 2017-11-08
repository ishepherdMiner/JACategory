//
//  UINavigationController+JACoder.h
//  Daily_modules
//
//  Created by Jason on 20/04/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (JACoder)

/// origin methods
- (void)ja_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController *)ja_popViewControllerAnimated:(BOOL)animated;

@end
