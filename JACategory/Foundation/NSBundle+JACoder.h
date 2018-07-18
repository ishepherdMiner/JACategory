//
//  NSBundle+JACoder.h
//  Summary
//
//  Created by Jason on 21/06/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSBundle (JACoder)

/**
 从mainBundle加载指定的bundle

 @param name bundle名(framework有效,如果以.a静态库的方式,资源文件也没有被打包进去,所以没有作用)
 @return 指定bundle,如果没有则返回nil
 */
+ (instancetype)ja_bundleWithName:(NSString *)name;

/**
 从bundle中加载图片对象

 @param name 图片名
 @return UIImage图片对象
 */
- (UIImage *)ja_imageWithName:(NSString *)name;

@end

@interface NSBundle (JAGetter)

/**
 包名

 @return 包名
 */
+ (NSString *)ja_bundleId;

/**
 应用名

 @return 应用名
 */
+ (NSString *)ja_appName;

/**
 应用版本

 @return 应用版本对象
 */
+ (NSString *)ja_appVersion;

@end
NS_ASSUME_NONNULL_END
