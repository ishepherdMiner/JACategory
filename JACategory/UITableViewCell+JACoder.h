//
//  UITableViewCell+JACoder.h
//  JACategory
//
//  Created by HZ-Jason on 18/07/2018.
//  Copyright © 2018 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (JACoder)

/**
 添加下划线视图
 
 @param color 颜色
 @return 添加的下划线视图对象
 */
- (UIView *)ja_addUnderlineWithColor:(UIColor *)color;

/**
 添加下划线视图
 
 @param color 颜色
 @param frame 位置与坐标
 @return 添加的下划线视图对象
 */
- (UIView *)ja_addUnderlineWithColor:(UIColor *)color
                               frame:(CGRect)frame;

/**
 移除下划线视图
 */
- (void)ja_removeUnderline;

@end

NS_ASSUME_NONNULL_END
