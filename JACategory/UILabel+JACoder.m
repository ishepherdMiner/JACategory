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

@implementation UILabel (JACoder)

@end

@implementation UILabel (Interceptor)

+ (void)load {
    [UILabel ja_hookWithOriginSelector:@selector(textRectForBounds:limitedToNumberOfLines:) swizzledSelector:@selector(ja_textRectForBounds:limitedToNumberOfLines:)];
}

static const char *interceptorLabelKey = "interceptorKey";
- (void)setInterceptor:(id)interceptor {
    objc_setAssociatedObject(self.class, interceptorLabelKey, interceptor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id)interceptor {
    return objc_getAssociatedObject(self.class, interceptorLabelKey);
}

/// 修改默认垂直居中时
- (CGRect)ja_textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    if ([[self interceptor] respondsToSelector:@selector(textRectForBounds:limitedToNumberOfLines:)]) {
        return [[self interceptor] textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    }else {
        return [self ja_textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    }
}

@end
