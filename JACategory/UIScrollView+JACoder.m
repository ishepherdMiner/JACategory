//
//  UIScrollView+JACoder.m
//  MStarReader
//
//  Created by Jason on 31/07/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "UIScrollView+JACoder.h"
#import "NSObject+JACoder.h"

@implementation UIScrollView (JACoder)


+ (void)load {
    // [self ja_hookMethod:[self class] OriginSelector:@selector(hitTest:withEvent:) SwizzledSelector:@selector(ja_hitTest:withEvent:)];
}

// http://www.jianshu.com/p/2bb30c3d2408
//- (UIView *)ja_hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event {
//    /*
//     直接拖动UISlider，此时touch时间在150ms以内，UIScrollView会认为是拖动自己，从而拦截了event，导致UISlider接受不到滑动的event。但是只要按住UISlider一会再拖动，此时此时touch时间超过150ms，因此滑动的event会发送到UISlider上。
//     */
//    UIView *view = [super hitTest:point withEvent:event];
//    
//    if([view isKindOfClass:[UISlider class]]) {
//        // 如果响应view是UISlider,则scrollview禁止滑动
//        self.scrollEnabled = NO;
//    }else{
//        // 如果不是,则恢复滑动
//        self.scrollEnabled = YES;
//    }
//    return view;
//}

@end
