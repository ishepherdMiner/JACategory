//
//  UITextField+JACoder.h
//  JACategory
//
//  Created by HZ-Jason on 03/07/2018.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UITextField (JACoder)

/// 添加下划线视图
- (void)ja_addUnderlineWithColor:(UIColor *)color;
- (void)ja_addUnderlineWithColor:(UIColor *)color
                           axisX:(CGFloat)axisX
                            size:(CGSize)size;
@end
NS_ASSUME_NONNULL_END
