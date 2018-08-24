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

/// 来自https://github.com/andreamazz/UITextField-Shake
/** @enum ShakeDirection
 *
 * Enum that specifies the direction of the shake
 */
typedef NS_ENUM(NSInteger, ShakeDirection) {
    /** Shake left and right */
    ShakeDirectionHorizontal,
    /** Shake up and down */
    ShakeDirectionVertical
};

/**
 * @name UITextField+Shake
 * A UITextField category that add the ability to shake the component
 */
@interface UITextField (Shake)

/** Shake the UITextField
 *
 * Shake the text field with default values
 */
- (void)shake;

/** Shake the UITextField
 *
 * Shake the text field a given number of times
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 */
- (void)shake:(int)times withDelta:(CGFloat)delta;

/** Shake the UITextField
 *
 * Shake the text field a given number of times
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param handler A block object to be executed when the shake sequence ends
 */
- (void)shake:(int)times withDelta:(CGFloat)delta completion:(nullable void (^)(void))handler;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 */
- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 * @param handler A block object to be executed when the shake sequence ends
 */
- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(nullable void (^)(void))handler;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 * @param shakeDirection of the shake
 */
- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 * @param shakeDirection of the shake
 * @param handler A block object to be executed when the shake sequence ends
 */
- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection completion:(nullable void (^)(void))handler;

@end

NS_ASSUME_NONNULL_END
