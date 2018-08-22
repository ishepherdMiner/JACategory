//
//  UIViewController+JACoder.m
//  MStarReader
//
//  Created by Jason on 05/08/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "UIViewController+JACoder.h"

@implementation UIViewController (JACoder)

+ (UIViewController *)ja_currentViewController {
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
}

+ (UIViewController *)findBestViewController:(UIViewController*)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController *)vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else if (@available(iOS 8.0, *)) {
        if(([vc.presentedViewController isKindOfClass:[UIAlertController class]])) {
            return vc;
        }else {
            return vc;
        }
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}
@end
