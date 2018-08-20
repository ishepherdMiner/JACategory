//
//  NSNumber+Coder.m
//  DRArtisan
//
//  Created by Jason on 7/25/16.
//  Copyright © 2016 DR. All rights reserved.
//

#import "NSNumber+JACoder.h"

@implementation NSNumber (JACoder)

+ (instancetype)ja_randomeProbability {
    return @(arc4random() % 11 / 10.0);
}

+ (instancetype)ja_randomeProbabilityWithPrecision:(CGFloat)precision {
    int val = (int)pow(10, precision);
    return @(arc4random() % val / (CGFloat)val);
}

+ (instancetype)ja_randomNumber:(NSUInteger)from to:(NSUInteger)to {
    return @(from + (arc4random() % (to - from + 1)));
}

/// 当我在测试想让图片每次都不缓存时,可以使用这个,在url末尾添加?@(xxx).stringValue
+ (instancetype)ja_randomTimestamp:(NSUInteger)from to:(NSUInteger)to {
    NSTimeInterval(^timestamp)(void) = ^() {
        NSDate* date = [NSDate date];
        return (NSTimeInterval)[date timeIntervalSince1970];
    };
    // int value  = arc4random() % (大数 - 小数 + 1) + 小数
    return [NSNumber ja_randomNumber:(timestamp() - from) to:(timestamp() + to)];
}

/// 当我想要截取数值又不想采用截取字符串的方式时,找到的方法
+ (instancetype)ja_notRounding:(CGFloat)number afterPoint:(int)position{
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:false raiseOnOverflow:false raiseOnUnderflow:false raiseOnDivideByZero:false];
    
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:number];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return roundedOunces;
    
}

+ (NSString *)ja_numberToChineseNumber:(NSInteger)_i{
    NSString *str=[NSNumber ja_numberToChineseNumber:_i Index:0];
    return str;//[str stringByReplacingOccurrencesOfString:@"一十" withString:@"十"];
}

+ (NSString *)ja_numberToChineseNumber:(NSInteger)integer Index:(NSInteger)index{
    if (integer<=0) {
        return @"";
    }
    else if (integer/10==0){
        return [NSNumber getChineseNumberByInteger:integer];
    }
    else if (integer%10==0) {
        return [NSString stringWithFormat:@"%@%@",[NSNumber ja_numberToChineseNumber:integer/10 Index:index+1],[NSNumber getUnitByIndex:index]];
    }
    else{
        return [NSString stringWithFormat:@"%@%@%@",[NSNumber ja_numberToChineseNumber:integer/10 Index:index+1],[NSNumber getUnitByIndex:index],[NSNumber getChineseNumberByInteger:integer%10]];
    }
}

+ (NSString *)getUnitByIndex:(NSInteger)index{
    if (index%7==0&&index>0) {
        return @"亿";
    }
    switch (index%4) {
        case 0:return @"十";break;
        case 1:return @"百";break;
        case 2:return @"千";break;
        case 3:return @"万";break;
    }
    return @"";
}

+ (NSString *)getChineseNumberByInteger:(NSInteger)index{
    switch (index) {
        case 1:return @"一";break;
        case 2:return @"二";break;
        case 3:return @"三";break;
        case 4:return @"四";break;
        case 5:return @"五";break;
        case 6:return @"六";break;
        case 7:return @"七";break;
        case 8:return @"八";break;
        case 9:return @"九";break;
    }
    return @"";
}

@end
