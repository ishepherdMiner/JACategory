//
//  UILabel+JACoder.m
//  JACategory
//
//  Created by HZ-Jason on 18/07/2018.
//  Copyright © 2018 Jason. All rights reserved.
//

#import "UILabel+JACoder.h"
#import <objc/message.h>
#import <JACategory/NSObject+JACoder.h>
#import <JACategory/NSString+JACoder.h>
#import "UIView+JACoder.h"

@implementation UILabel (JACoder)

@end

@implementation UILabel (Interceptor)

+ (void)load {
    [UILabel ja_hookWithOriginSelector:@selector(textRectForBounds:limitedToNumberOfLines:) swizzledSelector:@selector(ja_textRectForBounds:limitedToNumberOfLines:)];
    [UILabel ja_hookWithOriginSelector:@selector(drawTextInRect:) swizzledSelector:@selector(ja_drawTextInRect:)];
        
}

- (void)setInterceptor:(id<UILabelInterceptorDelegate>)interceptor {
    objc_setAssociatedObject(self,@selector(interceptor), interceptor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id)interceptor {
    return objc_getAssociatedObject(self,@selector(interceptor));
}

/// 修改默认垂直居中时
- (CGRect)ja_textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect rect = bounds;
    if ([[self interceptor] respondsToSelector:@selector(ja_edgeInsets)]) {
        UIEdgeInsets insets = [[self interceptor] ja_edgeInsets];
        rect = [self ja_textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets) limitedToNumberOfLines:numberOfLines];
        
        rect.origin.x -= insets.left;
        rect.origin.y -= insets.top;
        rect.size.width += (insets.left + insets.right);
        rect.size.height += (insets.top + insets.bottom);
        
    }else {
        rect = [self ja_textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    }
    
    return rect;
}


- (void)ja_drawTextInRect:(CGRect)rect {
    if ([[self interceptor] respondsToSelector:@selector(ja_edgeInsets)]) {
        UIEdgeInsets insets = [[self interceptor] ja_edgeInsets];
        [self ja_drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
    }else {
        [self ja_drawTextInRect:rect];
    }
}

@end
