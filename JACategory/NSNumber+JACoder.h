//
//  NSNumber+Coder.h
//  DRArtisan
//
//  Created by Jason on 7/25/16.
//  Copyright © 2016 DR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSNumber (JACoder)


/**
 create a random number between zero to one

 @return a random number between zero to one
 */
+ (instancetype)ja_randomeProbability;
+ (instancetype)ja_randomeProbabilityWithPrecision:(CGFloat)precision;

/**
 *  create a random number between from with to number => [from,to]
 *
 *  @param from min number
 *  @param to   max number
 *
 *  @return a random number between from with to number
 */
+ (instancetype)ja_randomNumber:(NSUInteger)from to:(NSUInteger)to;

/**
 *  create a random timestamp between from with to number (unit:second)
 *
 *  @param from before now timestamp `from` seconds
 *  @param to   after now timestamp `to` seconds
 *
 *  @return a random timestamp from with to number
 */
+ (instancetype)ja_randomTimestamp:(NSUInteger)from to:(NSUInteger)to;

/**
 *  create an assign decimal number
 *
 *  @param number    which number
 *  @param position decimal number
 *
 *  @return the assign decimal number
 */
+ (instancetype)ja_notRounding:(CGFloat)number afterPoint:(int)position;

/**
 *    @brief 数字转换成中文数字
 *
 *    @param _i 要转换的数字
 *
 *    @return 数字转换成的中文
 */
+ (NSString *)ja_numberToChineseNumber:(NSInteger)_i;

@end
NS_ASSUME_NONNULL_END
