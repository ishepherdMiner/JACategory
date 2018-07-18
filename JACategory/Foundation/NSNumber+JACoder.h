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
 *  @param price    which number
 *  @param position decimal number
 *
 *  @return the assign decimal number
 */
+ (instancetype)ja_notRounding:(CGFloat)price afterPoint:(int)position;

@end
NS_ASSUME_NONNULL_END