//
//  UITextField+JACoder.h
//  JACategory
//
//  Created by HZ-Jason on 03/07/2018.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (JABuilder)

+ (instancetype)ja_builder:(void (NS_NOESCAPE ^)(UITextField * _Nonnull make))block;
- (instancetype)ja_builder:(void (NS_NOESCAPE ^)(UITextField * _Nonnull make))block;

@end

@interface UITextField (JACoder)

/**
 添加下划线视图

 @param color 颜色
 @return 添加下划线视图对象
 */
- (UIView *)ja_addUnderlineWithColor:(UIColor *)color;

/**
 添加下划线视图

 @param color 颜色
 @param axisX 起始横坐标 传 NSNotFound 以UITextField的坐标为起始横坐标
 @param size 尺寸
 @return 添加下划线的视图对象
 */
- (UIView *)ja_addUnderlineWithColor:(UIColor *)color
                               axisX:(NSUInteger)axisX
                                size:(CGSize)size;


/**
 移除下划线视图
 */
- (void)ja_removeUnderline;

@end

@protocol UITextFiledInterceptorDelegate <NSObject>

@optional
/// 让拦截器重新设置子控件的位置
/// 解决clearButton和rightView的冲突问题
- (CGRect)ja_borderRectForBounds:(CGRect)bounds;
- (CGRect)ja_textRectForBounds:(CGRect)bounds;
- (CGRect)ja_placeholderRectForBounds:(CGRect)bounds;
- (CGRect)ja_editingRectForBounds:(CGRect)bounds;
- (CGRect)ja_clearButtonRectForBounds:(CGRect)bounds;
- (CGRect)ja_leftViewRectForBounds:(CGRect)bounds;
- (CGRect)ja_rightViewRectForBounds:(CGRect)bounds;

@end

@interface UITextField (Interceptor)

/// 设置拦截器
- (void)setInterceptor:(id<UITextFiledInterceptorDelegate>)interceptor;
- (id)interceptor;

@end

NS_ASSUME_NONNULL_END
