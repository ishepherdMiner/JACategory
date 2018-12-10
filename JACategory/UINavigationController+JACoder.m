//
//  UINavigationController+JACoder.m
//  Daily_modules
//
//  Created by Jason on 20/04/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "UINavigationController+JACoder.h"
#import <JACategory/NSObject+JACoder.h>

@implementation UINavigationController (JACoder)

+ (void)load {
    [UINavigationController ja_hookWithOriginSelector:@selector(pushViewController:animated:) swizzledSelector:@selector(ja_pushViewController:animated:)];
    
    [UINavigationController ja_hookWithOriginSelector:@selector(popViewControllerAnimated:) swizzledSelector:@selector(ja_popViewControllerAnimated:)];
}

- (void)ja_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.topViewController.hidesBottomBarWhenPushed = true;
    
    [self ja_pushViewController:viewController animated:animated];
}

- (UIViewController *)ja_popViewControllerAnimated:(BOOL)animated {
    NSUInteger index = [self.viewControllers indexOfObject:self.topViewController];
    
    // TabBar 中的 viewControllers 也会触发, index == 0 导致崩溃
    if (index <= 0) {return [self ja_popViewControllerAnimated:animated];}
    
    if (index == 1) {
        self.viewControllers[index - 1].hidesBottomBarWhenPushed = false;
    }else {
        self.viewControllers[index - 1].hidesBottomBarWhenPushed = true;
    }
    
    return [self ja_popViewControllerAnimated:animated];
}

- (UIImageView *)ja_findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self ja_findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)ja_setNeedsNavigationBackground:(CGFloat)alpha {
    // 导航栏背景透明度设置
    // _UIBarBackground
    if ([self.navigationBar subviews].count >= 1) {
        UIView *barBackgroundView = [[self.navigationBar subviews] objectAtIndex:0];
        if ([barBackgroundView subviews].count >= 1) {
            UIImageView *backgroundImageView = [[barBackgroundView subviews] objectAtIndex:0];// UIImageView
            if (self.navigationBar.isTranslucent) {
                if (backgroundImageView != nil && backgroundImageView.image != nil) {
                    barBackgroundView.alpha = alpha;
                } else {
                    if ([barBackgroundView subviews].count >= 2) {
                        UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];// UIVisualEffectView
                        if (backgroundEffectView != nil) {
                            backgroundEffectView.alpha = alpha;
                        }
                    }
                }
            } else {
                barBackgroundView.alpha = alpha;
            }
        }
    }
}
@end
