//
//  UINavigationController+JACoder.h
//  Daily_modules
//
//  Created by Jason on 20/04/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UINavigationController (JACoder)

/// origin methods
- (void)ja_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController *)ja_popViewControllerAnimated:(BOOL)animated;

/// 找到UINavigationBar下面的线
- (UIImageView *)ja_findHairlineImageViewUnder:(UIView *)view;
/**
 http://www.cocoachina.com/ios/20170331/18944.html
 导航栏背景透明度设置
 */
- (void)ja_setNeedsNavigationBackground:(CGFloat)alpha;
@end
NS_ASSUME_NONNULL_END
