//
//  UITableViewCell+JACoder.h
//  JACategory
//
//  Created by HZ-Jason on 18/07/2018.
//  Copyright © 2018 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (JACoder)


/**
 添加下划线视图
 
 @param color 颜色
 @return 添加的下划线视图对象
 */
- (UIView *)ja_underlineWithColor:(UIColor *)color;

/**
 添加下划线视图
 
 @param color 颜色
 @param frame 位置与坐标
 @return 添加的下划线视图对象
 */
- (UIView *)ja_underlineWithColor:(UIColor *)color
                                frame:(CGRect)frame;

@end
