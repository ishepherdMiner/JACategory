//
//  UIViewController+JACoder.m
//  MStarReader
//
//  Created by Jason on 05/08/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "UIViewController+JACoder.h"
#import <JACategory/UIResponder+JACoder.h>
#import <JACategory/UIView+JACoder.h>

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

@implementation UIViewController (JAKeyboard)

- (UIScrollView *)ja_keyboardScrollView {
    UIScrollView *scrollView = objc_getAssociatedObject(self, @selector(ja_keyboardScrollView));
    if (scrollView == nil) {
        scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        objc_setAssociatedObject(self, @selector(ja_keyboardScrollView), scrollView, OBJC_ASSOCIATION_RETAIN);
    }
    return scrollView;
}

- (void)ja_setKeyboardScrollView:(UIScrollView *)scrollView {
    objc_setAssociatedObject(self, @selector(ja_keyboardScrollView), scrollView, OBJC_ASSOCIATION_RETAIN);
}

- (void)ja_keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    UIView *firstResponder = [UIResponder ja_currentFirstResponder];
    CGFloat kNavHeight = 64;
    CGFloat JA_SCREEN_HEIGHT = [UIScreen mainScreen].bounds.size.height;
    if (firstResponder.ja_y - height < kNavHeight) {
        [[self ja_keyboardScrollView] setContentOffset:fPoint(0, firstResponder.ja_y - kNavHeight - 10)
                                              animated:YES];
    }else if (firstResponder.ja_y >= JA_SCREEN_HEIGHT){
        [[self ja_keyboardScrollView] setContentOffset:fPoint(0, height + fMaxY(firstResponder.frame) - JA_SCREEN_HEIGHT + 10)
                                              animated:YES];
    }else {
        [[self ja_keyboardScrollView] setContentOffset:fPoint(0, height)
                                              animated:YES];
    }
}

- (void)ja_keyboardWillHide:(NSNotification *)aNotification {
    CGFloat kNavHeight = 64;
    if (self.navigationController) {
        [[self ja_keyboardScrollView] setContentOffset:fPoint(0, -kNavHeight)
                                              animated:YES];
    }else {
        [[self ja_keyboardScrollView] setContentOffset:fPoint(0, 0)
                                              animated:YES];
    }
}

- (BOOL)ja_isActive {
    return (self.isViewLoaded && self.view.window);
}

@end
