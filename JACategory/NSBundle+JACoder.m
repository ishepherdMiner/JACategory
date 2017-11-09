//
//  NSBundle+JACoder.m
//  Summary
//
//  Created by Jason on 21/06/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "NSBundle+JACoder.h"

@implementation NSBundle (JACoder)

+ (instancetype)ja_bundleWithName:(NSString *)name {
    NSBundle *b = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:name ofType:@"bundle"]];
    return b;
}

- (UIImage *)ja_imageWithName:(NSString *)name {    
    NSString *imageNameWithSuffix = nil;
    
    if ([UIScreen mainScreen].scale <= 2.0) {
        imageNameWithSuffix = [NSString stringWithFormat:@"%@@2x",name];
    }else {
        imageNameWithSuffix = [NSString stringWithFormat:@"%@@3x",name];
    }
    UIImage *image = [UIImage imageWithContentsOfFile:[self pathForResource:imageNameWithSuffix ofType:@"png"]];
    return image;
}

@end
