//
//  UITableViewCell+JACoder.m
//  JACategory
//
//  Created by HZ-Jason on 18/07/2018.
//  Copyright © 2018 Jason. All rights reserved.
//

#import "UITableViewCell+JACoder.h"
#import <objc/message.h>

@implementation UITableViewCell (JACoder)

- (UIView *)ja_addUnderlineWithColor:(UIColor *)color {
    return [self ja_addUnderlineWithColor:color
                                    frame:CGRectZero];
}

- (UIView *)ja_addUnderlineWithColor:(UIColor *)color
                               frame:(CGRect)frame {
    
    UIView *underlineView = objc_getAssociatedObject(self, @selector(ja_addUnderlineWithColor:frame:));
    if (underlineView == nil) {
        underlineView = [[UIView alloc] init];
        
        CGFloat x = CGRectEqualToRect(CGRectZero, frame) ? self.bounds.origin.x : frame.origin.x;
        CGFloat w = self.frame.size.width;
        CGFloat h = 1;
        if (!CGSizeEqualToSize(CGSizeZero, frame.size)) {
            w = frame.size.width;
            h = frame.size.height;
        }
        
        CGFloat y = CGRectEqualToRect(CGRectZero, frame) ? (self.bounds.size.height - h) : frame.origin.y;
        
        underlineView.frame = CGRectMake(x, y, w, h);
        underlineView.backgroundColor = color;
        [self.contentView addSubview:underlineView];
        objc_setAssociatedObject(self, @selector(ja_addUnderlineWithColor:frame:), underlineView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return underlineView;
}

- (void)ja_removeUnderline {
    UIView *underlineView = objc_getAssociatedObject(self, @selector(ja_addUnderlineWithColor:frame:));
    if (underlineView) {
        [underlineView removeFromSuperview];
        objc_setAssociatedObject(self, @selector(ja_addUnderlineWithColor:frame:), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end
