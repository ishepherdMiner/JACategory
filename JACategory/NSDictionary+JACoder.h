//
//  NSDictionary+JACoder.h
//  Daily_modules
//
//  Created by Jason on 09/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (JACoder)

/**
 从bundle中加载.json转成字典对象
 默认mainBundle
 @param fileName 文件名
 @return 字典对象
 */
+ (NSDictionary*)ja_dictionaryWithFilename:(NSString *)fileName;
+ (NSDictionary*)ja_dictionaryWithFilename:(NSString *)fileName
                                    bundle:(nullable NSBundle*)bundle;
@end

@interface NSDictionary (JAConvenient)

/**
 是否是有效的字典对象
 是字典 && 长度非空
 
 @param instance 待判断的对象
 @return 判断结果
 */
+ (BOOL)ja_valid:(id)instance;

@end

NS_ASSUME_NONNULL_END
