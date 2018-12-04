//
//  UIView+JACoder.h
//  Daily_modules
//
//  Created by Jason on 09/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define fRect(x,y,w,h)  CGRectMake(x,y,w,h)
#define fEdgeInset(x,y,w,h) UIEdgeInsetsMake(x,y,w,h)
#define fSize(w,h)      CGSizeMake(w,h)
#define fPoint(x,y)     CGPointMake(x,y)
#define fRange(loc,len) NSMakeRange(loc,len)
#define fMaxY(rect)     CGRectGetMaxY(rect)
#define fMaxX(rect)     CGRectGetMaxX(rect)
#define fMinY(rect)     CGRectGetMinY(rect)
#define fMinX(rect)     CGRectGetMinX(rect)
#define fMidY(rect)     CGRectGetMidY(rect)
#define fMidX(rect)     CGRectGetMidX(rect)
#define fWidth(rect)    CGRectGetWidth(rect)
#define fHeight(rect)   CGRectGetHeight(rect)

#define fMaxY_E(view) CGRectGetMaxY(view.frame)
#define fMaxX_E(view) CGRectGetMaxX(view.frame)
#define fMinY_E(view) CGRectGetMinY(view.frame)
#define fMinX_E(view) CGRectGetMinX(view.frame)
#define fMidY_E(view) CGRectGetMidY(view.frame)
#define fMidX_E(view) CGRectGetMidX(view.frame)
#define fWidth_E(view)    CGRectGetWidth(view.frame)
#define fHeight_E(view)   CGRectGetHeight(view.frame)

/// 已知左右边距要求居中 求宽度
#define fCenterFixedPaddingGetWidth(sumWidth,padding) (sumWidth - padding * 2)

/// 固定宽度要求居中 求左右边距
#define fCenterFixWidthGetPadding(sumWidth,width) ((sumWidth - width) * 0.5)

@interface UIView (JABuilder)

+ (instancetype)ja_builder:(void (NS_NOESCAPE ^)(UIView * _Nonnull make))block;
- (instancetype)ja_builder:(void (NS_NOESCAPE ^)(UIView * _Nonnull make))block;

@end

@interface UIView (Shadow)

- (void)makeInsetShadow;
- (void)makeInsetShadowWithRadius:(float)radius Alpha:(float)alpha;
- (void)makeInsetShadowWithRadius:(float)radius Color:(UIColor *)color Directions:(NSArray *)directions;

@end

@interface UIView (JACoder)

/// frame setter & getter
- (CGFloat)ja_width;
- (CGFloat)ja_height;
- (CGFloat)ja_x;
- (CGFloat)ja_y;

- (void)setJa_y:(CGFloat)y;
- (void)setJa_x:(CGFloat)x;
- (void)setJa_width:(CGFloat)width;
- (void)setJa_height:(CGFloat)height;

- (CGFloat)ja_centerX;
- (CGFloat)ja_centerY;
- (void)setJa_centerX:(CGFloat)centerX;
- (void)setJa_centerY:(CGFloat)centerY;

/**
 * 水平居中(以父视图为准)
 */
- (void)ja_alignHor;

/** 
 * 垂直居中(以父视图为准)
 */
- (void)ja_alignVer;

/**
 *  Return YES from the block to recurse into the subview.
 *  Set stop to YES to return the subview.
 *
 *  回调中返回 YES 继续查找,返回 NO,去检查 stop 的值,如果stop 为 YES,
    则返回找到的那个视图
 */
- (UIView *)ja_findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse;

/**
 通过响应者链条获取view所在的控制器

 @return view所在的控制器
 */
- (UIViewController *)ja_parentController;
- (void)ja_drawCircleWithColor:(UIColor *)color
                         width:(CGFloat)width;

- (instancetype)ja_placeholder;

@end

NS_ASSUME_NONNULL_END
