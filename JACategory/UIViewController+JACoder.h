//
//  UIViewController+JACoder.h
//  MStarReader
//
//  Created by Jason on 05/08/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JACoder)

+ (UIViewController*)ja_currentViewController NS_AVAILABLE_IOS(8.0);

@end

@interface UIViewController (JAKeyboard)

- (void)ja_setKeyboardScrollView:(UIScrollView *)scrollView;
- (UIScrollView *)ja_keyboardScrollView;

/**
 接收到键盘展示通知

 @param aNotification 展示键盘通知
 */
- (void)ja_keyboardWillShow:(NSNotification *)aNotification;

/**
 接收到键盘隐藏通知

 @param aNotification 隐藏键盘通知
 */
- (void)ja_keyboardWillHide:(NSNotification*)aNotification;

@end

NS_ASSUME_NONNULL_END
