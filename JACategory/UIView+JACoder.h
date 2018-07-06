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
#define fSize(w,h)      CGSizeMake(w,h)
#define fPoint(x,y)     CGPointMake(x,y)
#define fRange(loc,len) NSRangeMake(loc,len)
#define fMaxY(rect)     CGRectGetMaxY(rect)
#define fMaxX(rect)     CGRectGetMaxX(rect)
#define fMinY(rect)     CGRectGetMinY(rect)
#define fMinX(rect)     CGRectGetMinX(rect)
#define fMidY(rect)     CGRectGetMidY(rect)
#define fMidX(rect)     CGRectGetMidX(rect)
#define fWidth(rect)    CGRectGetWidth(rect)
#define fHeight(rect)   CGRectGetHeight(rect)

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
 *
 */
- (void)ja_alignHor;

/** 
 * 垂直居中(以父视图为准)
 */
- (void)ja_alignVer;

/**
 *  Return YES from the block to recurse into the subview.
 *  Set stop to YES to return the subview.
 *  回调中返回 YES 继续查找,返回 NO,去检查 stop 的值,如果stop 为 YES,
    则返回找到的那个视图
 */
- (UIView*)ja_findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse;

@end
NS_ASSUME_NONNULL_END
