//
//  UITextField+JACoder.h
//  JACategory
//
//  Created by HZ-Jason on 03/07/2018.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (JACoder)

/**
 添加下划线视图

 @param color 颜色
 @return UITextField对象
 */
- (instancetype)ja_underlineWithColor:(UIColor *)color;

/**
 添加下划线视图

 @param color 颜色
 @param axisX 起始横坐标 传 NSNotFound 以UITextField的坐标为起始横坐标
 @param size 尺寸
 @return UITextField对象
 */
- (instancetype)ja_underlineWithColor:(UIColor *)color
                                axisX:(CGFloat)axisX
                                 size:(CGSize)size;

@end

@interface UITextField (Interceptor)

/// 设置拦截器
- (void)setInterceptor:(id)interceptor;
- (id)interceptor;

/// 让拦截器重新设置子控件的位置
/// 主要是为了解决clearButton和rightView的冲突问题
- (CGRect)ja_borderRectForBounds:(CGRect)bounds;
- (CGRect)ja_textRectForBounds:(CGRect)bounds;
- (CGRect)ja_placeholderRectForBounds:(CGRect)bounds;
- (CGRect)ja_editingRectForBounds:(CGRect)bounds;
- (CGRect)ja_clearButtonRectForBounds:(CGRect)bounds;
- (CGRect)ja_leftViewRectForBounds:(CGRect)bounds;
- (CGRect)ja_rightViewRectForBounds:(CGRect)bounds;

@end

NS_ASSUME_NONNULL_END
