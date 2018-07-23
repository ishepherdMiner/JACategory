//
//  UITextField+JACoder.m
//  JACategory
//
//  Created by HZ-Jason on 03/07/2018.
//

#import "UITextField+JACoder.h"
#import <JACategory/NSObject+JACoder.h>
#import <objc/message.h>

@implementation UITextField (JACoder)

- (UIView *)ja_underlineWithColor:(UIColor *)color {
    return [self ja_underlineWithColor:color
                          axisX:NSNotFound
                           size:CGSizeZero];
}

- (UIView *)ja_underlineWithColor:(UIColor *)color
                                axisX:(NSUInteger)axisX
                                 size:(CGSize)size {
    
    UIView *underlineView = [[UIView alloc] init];
    
    CGFloat x = axisX == NSNotFound ? self.frame.origin.x : axisX;
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
    return underlineView;
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
