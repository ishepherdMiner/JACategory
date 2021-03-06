//
//  UITextField+JACoder.m
//  JACategory
//
//  Created by HZ-Jason on 03/07/2018.
//

#import <JACategory/UITextField+JACoder.h>
#import <JACategory/NSObject+JACoder.h>
#import <JACategory/UIScreen+JACoder.h>
#import <objc/message.h>

@implementation UITextField (JACoder)

- (UIView *)ja_addUnderlineWithColor:(UIColor *)color {
    return [self ja_addUnderlineWithColor:color
                                    axisX:NSNotFound
                                     size:CGSizeZero];
}

- (UIView *)ja_addUnderlineWithColor:(UIColor *)color
                               axisX:(NSUInteger)axisX
                                size:(CGSize)size {
    UIView *underlineView = objc_getAssociatedObject(self, @selector(ja_addUnderlineWithColor:axisX:size:));
    if (underlineView == nil) {
        underlineView = [[UIView alloc] init];
        
        CGFloat x = axisX == NSNotFound ? self.bounds.origin.x : axisX;
        CGFloat h = 0.5;
        CGFloat y = self.bounds.size.height - h;
        CGFloat w = self.bounds.size.width;
        if (!CGSizeEqualToSize(CGSizeZero, size)) {
            w = size.width;
            h = size.height;
        }
        
        underlineView.frame = CGRectMake(x, y, w, h);
        underlineView.backgroundColor = color;
        [self addSubview:underlineView];
        self.clipsToBounds = NO;
        objc_setAssociatedObject(self, @selector(ja_addUnderlineWithColor:axisX:size:), underlineView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return underlineView;
}

- (void)ja_removeUnderline {
    UIView *underlineView = objc_getAssociatedObject(self, @selector(ja_addUnderlineWithColor:axisX:size:));
    if (underlineView) {
        [underlineView removeFromSuperview];
        objc_setAssociatedObject(self, @selector(ja_addUnderlineWithColor:axisX:size:), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end

@implementation UITextField (Interceptor)

+ (void)load {
    
    SEL originClearBtnSel = @selector(clearButtonRectForBounds:);
    SEL swizzlClearBtnSel = @selector(ja_clearButtonRectForBounds:);
    
    SEL originLeftViewSel = @selector(leftViewRectForBounds:);
    SEL swizzlLeftViewSel = @selector(ja_leftViewRectForBounds:);
    
    SEL originRightViewSel = @selector(rightViewRectForBounds:);
    SEL swizzlRightViewSel = @selector(ja_rightViewRectForBounds:);
    
    SEL originBorderRectSel = @selector(borderRectForBounds:);
    SEL swizzlBorderRectSel = @selector(ja_borderRectForBounds:);
    
    SEL originTextRectSel = @selector(textRectForBounds:);
    SEL swizzlTextRectSel = @selector(ja_textRectForBounds:);
    
    SEL originPlaceHolderSel = @selector(placeholderRectForBounds:);
    SEL swizzlPlaceHolderSel = @selector(ja_placeholderRectForBounds:);
    
    SEL originEditingRectSel = @selector(editingRectForBounds:);
    SEL swizzlEditingRectSel = @selector(ja_editingRectForBounds:);
    
    NSArray *originSels = @[NSStringFromSelector(originClearBtnSel),
                            NSStringFromSelector(originLeftViewSel),
                            NSStringFromSelector(originRightViewSel),
                            NSStringFromSelector(originBorderRectSel),
                            NSStringFromSelector(originTextRectSel),
                            NSStringFromSelector(originPlaceHolderSel),
                            NSStringFromSelector(originEditingRectSel)];
    
    NSArray *swizzlSels = @[NSStringFromSelector(swizzlClearBtnSel),
                            NSStringFromSelector(swizzlLeftViewSel),
                            NSStringFromSelector(swizzlRightViewSel),
                            NSStringFromSelector(swizzlBorderRectSel),
                            NSStringFromSelector(swizzlTextRectSel),
                            NSStringFromSelector(swizzlPlaceHolderSel),
                            NSStringFromSelector(swizzlEditingRectSel),];
    
    for (int i = 0; i < originSels.count; ++i) {
        [UITextField ja_hookWithOriginSelector:NSSelectorFromString(originSels[i]) swizzledSelector:NSSelectorFromString(swizzlSels[i])];
    }
}

- (void)setInterceptor:(id<UITextFiledInterceptorDelegate>)interceptor {
    objc_setAssociatedObject(self.class, @selector(interceptor), interceptor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id)interceptor {
    return objc_getAssociatedObject(self.class,  @selector(interceptor));
}

- (CGRect)ja_clearButtonRectForBounds:(CGRect)bounds {
    if ([[self interceptor] respondsToSelector:@selector(clearButtonRectForBounds:)]) {
        return [[self interceptor] clearButtonRectForBounds:bounds];
    }else {
        return [self ja_clearButtonRectForBounds:bounds];
    }
}

- (CGRect)ja_leftViewRectForBounds:(CGRect)bounds {
    if ([[self interceptor] respondsToSelector:@selector(leftViewRectForBounds:)]) {
        return [[self interceptor] leftViewRectForBounds:bounds];
    }else {
        return [self ja_leftViewRectForBounds:bounds];
    }
}
- (CGRect)ja_rightViewRectForBounds:(CGRect)bounds {
    if ([[self interceptor] respondsToSelector:@selector(rightViewRectForBounds:)]) {
        return [[self interceptor] rightViewRectForBounds:bounds];
    }else {
        return [self ja_rightViewRectForBounds:bounds];
    }
}

- (CGRect)ja_borderRectForBounds:(CGRect)bounds {
    if ([[self interceptor] respondsToSelector:@selector(borderRectForBounds:)]) {
        return [[self interceptor] borderRectForBounds:bounds];
    }else {
        return [self ja_borderRectForBounds:bounds];
    }
}

- (CGRect)ja_textRectForBounds:(CGRect)bounds {
    if ([[self interceptor] respondsToSelector:@selector(textRectForBounds:)]) {
        return [[self interceptor] textRectForBounds:bounds];
    }else {
        return [self ja_textRectForBounds:bounds];
    }
}

- (CGRect)ja_placeholderRectForBounds:(CGRect)bounds {
    if ([[self interceptor] respondsToSelector:@selector(placeholderRectForBounds:)]) {
        return [[self interceptor] placeholderRectForBounds:bounds];
    }else {
        return [self ja_placeholderRectForBounds:bounds];
    }
}

- (CGRect)ja_editingRectForBounds:(CGRect)bounds {
    if ([[self interceptor] respondsToSelector:@selector(editingRectForBounds:)]) {
        return [[self interceptor] editingRectForBounds:bounds];
    }else {
        return [self ja_editingRectForBounds:bounds];
    }
}

@end

@implementation UITextField (JAShake)

- (void)shake {
    [self shake:5 withDelta:5 completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta {
    [self shake:times withDelta:delta completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta completion:(nullable void (^)(void))handler {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:ShakeDirectionHorizontal completion:handler];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self shake:times withDelta:delta speed:interval completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(nullable void (^)(void))handler {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:ShakeDirectionHorizontal completion:handler];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection {
    [self shake:times withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection completion:(nullable void (^)(void))handler {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:handler];
}

- (void)_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection completion:(nullable void (^)(void))handler {
    [UIView animateWithDuration:interval animations:^{
        self.transform = (shakeDirection == ShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (handler) {
                    handler();
                }
            }];
            return;
        }
        [self _shake:times
           direction:direction * -1
        currentTimes:current + 1
           withDelta:delta
               speed:interval
      shakeDirection:shakeDirection
          completion:handler];
    }];
}

@end
