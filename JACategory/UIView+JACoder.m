//
//  UIView+JACoder.m
//  Daily_modules
//
//  Created by Jason on 09/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "UIView+JACoder.h"

@implementation UIView (JACoder)

+ (instancetype)ja_builder:(void (^)(UIView * _Nonnull make))block {
    UIView *instance = [[self alloc] init];
    block(instance);
    return instance;
}

- (instancetype)ja_builder:(void (^)(UIView * _Nonnull make))block {
    block(self);
    return self;
}

- (UIView*)ja_findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse{
    for( UIView* subview in self.subviews ) {
        BOOL stop = true;
        if(recurse(subview,&stop)) {
            return [subview ja_findViewRecursively:recurse];
        } else if( stop ) {
            return subview;
        }
    }    
    return nil;
}

- (CGFloat)ja_width {
    return self.frame.size.width;
}

- (CGFloat)ja_height {
    return self.frame.size.height;
}

- (CGFloat)ja_x {
    return self.frame.origin.x;
}

- (CGFloat)ja_y {
    return self.frame.origin.y;
}

- (void)setJa_y:(CGFloat)y {
    CGRect r = self.frame;
    r.origin.y = y;
    self.frame = r;
}

- (void)setJa_x:(CGFloat)x {
    CGRect r = self.frame;
    r.origin.x = x;
    self.frame = r;
}

- (void)setJa_width:(CGFloat)width {
    CGRect r = self.frame;
    r.size.width = width;
    self.frame = r;
}

- (void)setJa_height:(CGFloat)height {
    CGRect r = self.frame;
    r.size.height = height;
    self.frame = r;
}

- (CGFloat)ja_centerX {
    return self.center.x;
}

- (CGFloat)ja_centerY {
    return self.center.y;
}

- (void)setJa_centerX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setJa_centerY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

/** 
 * 水平居中 
 */
- (void)ja_alignHor{
    self.ja_x = (self.superview.ja_width - self.ja_width) * 0.5;
}

/** 
 * 垂直居中 
 */
- (void)ja_alignVer{
    self.ja_y = (self.superview.ja_height - self.ja_height) * 0.5;
}

/**
 通过响应者链条获取view所在的控制器
 
 @return view所在的控制器
 */
- (UIViewController *)ja_parentController{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

@end
