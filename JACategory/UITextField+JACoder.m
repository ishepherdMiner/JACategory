//
//  UITextField+JACoder.m
//  JACategory
//
//  Created by HZ-Jason on 03/07/2018.
//

#import "UITextField+JACoder.h"

@implementation UITextField (JACoder)

- (instancetype)ja_underlineWithColor:(UIColor *)color {
    return [self ja_underlineWithColor:color
                          axisX:NSNotFound
                           size:CGSizeZero];
}

- (instancetype)ja_underlineWithColor:(UIColor *)color
                                axisX:(CGFloat)axisX
                                 size:(CGSize)size {
    
    UIView *underlineView = [[UIView alloc] init];
    
    CGFloat x = axisX == NSNotFound ? self.frame.origin.x : axisX;
    CGFloat y = self.frame.size.height + 3;
    CGFloat w = self.frame.size.width;
    CGFloat h = 1;
    if (!CGSizeEqualToSize(CGSizeZero, size)) {
        w = size.width;
        h = size.height;
    }
    
    underlineView.frame = CGRectMake(x, y, w, h);
    underlineView.backgroundColor = color;
    [self addSubview:underlineView];
    self.clipsToBounds = NO;
    return self;
}

@end

@implementation UITextField (Interceptor)

//+ (void)load {
//    
//}
//
//- (CGRect)ja_clearButtonRectForBounds:(CGRect)bounds {
//    if ([[self interceptor] respondsToSelector:@selector(clearButtonRectForBounds:)]) {
//        return [[self interceptor] clearButtonRectForBounds:bounds];
//    }else {
//        return [self ja_clearButtonRectForBounds:bounds];
//    }
//}

@end
