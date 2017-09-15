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
    static id instance;
    instance = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:name ofType:@"bundle"]];
    return instance;
}

- (UIImage *)ja_imageWithName:(NSString *)imageName {
    
    NSString *imageNameWithSuffix = nil;
    
    if ([UIScreen mainScreen].scale <= 2.0) {
        imageNameWithSuffix = [NSString stringWithFormat:@"%@@2x",imageName];
    }else {
        imageNameWithSuffix = [NSString stringWithFormat:@"%@@3x",imageName];
    }
    UIImage *image = [UIImage imageWithContentsOfFile:[self pathForResource:imageNameWithSuffix ofType:@"png"]];
    return image;
}


#pragma mark private
+ (instancetype)frameworkBundle {
    
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"JAObjc" ofType:@"bundle"]];
    });
    
    return instance;
}

@end
