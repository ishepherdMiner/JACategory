//
//  UIDevice+JACoder.h
//  Daily_modules
//
//  Created by Jason on 14/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMGyroData;

@interface UIDevice (JACoder)


#if DEBUG

/**
 陀螺仪状态

 [UIDevice gyroWithStartBlock:^(CMGyroData *gyroData, NSError *error) {
    NSLog(@"Gyro Rotation x = %.04f", gyroData.rotationRate.x);
    NSLog(@"Gyro Rotation y = %.04f", gyroData.rotationRate.y);
    NSLog(@"Gyro Rotation z = %.04f", gyroData.rotationRate.z);
 }];
 
 @param handler 开始监测后的回调
 */
+ (void)ja_gyroWithStartBlock:(void (^)(CMGyroData *gyroData,NSError *error))handler;

#endif

/**
 * 易理解的设备型号
 * 若要拼成url,可以通过[NSString ja_encodeToPercentEscapeString:@"xxx"]过滤空格
 @return 设备型号
 */
+ (NSString *)ja_model;

/**
 *  获取内网地址
 *
 *  @return ip地址
 */
+ (NSDictionary *)ja_ip;

@end
