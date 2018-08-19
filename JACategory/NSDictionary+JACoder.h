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
+ (instancetype)ja_dictionaryWithFilename:(NSString *)fileName;
+ (instancetype)ja_dictionaryWithFilename:(NSString *)fileName
                                    bundle:(nullable NSBundle*)bundle;



@end

NS_ASSUME_NONNULL_END
