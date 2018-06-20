//
//  UIScreen+JACoder.m
//  RssMoney
//
//  Created by Jason on 12/04/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "UIScreen+JACoder.h"

@implementation UIScreen (JACoder)

+ (CGFloat)ja_width {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)ja_height {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGRect)ja_mainBounds {
    return [UIScreen mainScreen].bounds;
}

+ (CGFloat)ja_brightness {
    return [UIScreen mainScreen].brightness;
}
@end
