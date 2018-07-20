//
//  NSArray+JACoder.h
//  Daily_modules
//
//  Created by Jason on 09/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (JACoder)

/**
 *  根据文件路径 输出所有文件名
 *
 *  @param dirString 文件路径
 *
 *  @return 所有文件
 */
+ (NSArray *)ja_allFilesAtPath:(NSString*)dirString;

/**
 *  将数组拆分成固定长度的子数组
 *
 *  @param subSize 指定长度
 *
 *  @return 分割后的子数组
 */
- (NSArray *)ja_splitWithSubsize:(int)subSize;

@end

NS_ASSUME_NONNULL_END
