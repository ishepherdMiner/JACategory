//
//  UITableViewCell+JACoder.m
//  JACategory
//
//  Created by HZ-Jason on 18/07/2018.
//  Copyright © 2018 Jason. All rights reserved.
//

#import "UITableViewCell+JACoder.h"

@implementation UITableViewCell (JACoder)

- (UIView *)ja_underlineWithColor:(UIColor *)color {
    return [self ja_underlineWithColor:color
                                 frame:CGRectZero];
}

- (UIView *)ja_underlineWithColor:(UIColor *)color
                                frame:(CGRect)frame{
    
    UIView *underlineView = [[UIView alloc] init];
    
    CGFloat x = CGRectEqualToRect(CGRectZero, frame) ? self.frame.origin.x : frame.origin.x;
    CGFloat w = self.frame.size.width;
    CGFloat h = 1;
    if (!CGSizeEqualToSize(CGSizeZero, frame.size)) {
        w = frame.size.width;
        h = frame.size.height;
    }
    
    CGFloat y = CGRectEqualToRect(CGRectZero, frame) ? (self.frame.size.height - h) : frame.origin.y;
    
    underlineView.frame = CGRectMake(x, y, w, h);
    underlineView.backgroundColor = color;
    [self addSubview:underlineView];
    
    return underlineView;
}

@end
