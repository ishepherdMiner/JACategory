//
//  NSBundle+JACoder.h
//  Summary
//
//  Created by Jason on 21/06/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSBundle (JACoder)

+ (instancetype)frameworkBundle;

/**
 从mainBundle加载指定的bundle

 @param name bundle名
 @return 指定bundle,如果没有则返回nil
 */
+ (instancetype)bundleWithName:(NSString *)name;
- (UIImage *)ja_imageWithName:(NSString *)imageName;

@end
