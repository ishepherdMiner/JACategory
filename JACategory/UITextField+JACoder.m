//
//  UITextField+JACoder.m
//  JACategory
//
//  Created by HZ-Jason on 03/07/2018.
//

#import "UITextField+JACoder.h"

@implementation UITextField (JACoder)

- (void)ja_addUnderlineWithColor:(UIColor *)color {
    [self ja_addUnderlineWithColor:color
                             axisX:-1
                              size:CGSizeZero];
}

- (void)ja_addUnderlineWithColor:(UIColor *)color
                           axisX:(CGFloat)axisX
                            size:(CGSize)size {
    
    UIView *underlineView = [[UIView alloc] init];
    
    CGFloat x = axisX == -1 ? self.frame.origin.x : axisX;
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
}

@end
