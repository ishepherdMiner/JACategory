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

/**
 * 可读的设备型号
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

/**
 当前系统的首选语言

 @return 首选语言
 */
+ (NSString *)ja_lang;

/**
 idfa 广告标识符

 @return 广告标识符对象
 */
+ (NSString *)ja_idfa;

/**
 当前wifi是否可用

 @return wifi是否可用
 */
+ (BOOL)ja_wifiAvailable;

/**
 运行商

 @return 运营商
 */
+ (NSString *)ja_carrier;

/**
 进程id
 
 @return 进程id号
 */
+ (NSString *)ja_pid;

/**
 开机累积启动时间
 
 @return 启动时间字符串对象
 */
+ (NSString *)ja_startupTime;

/**
 cpu利用率

 @return cpu利用率
 */
+ (NSArray *)ja_cpuUsage;


/**
 cpu个数

 @return cpu个数
 */
+ (NSUInteger)ja_cpuCount;

/**
 获取手机内存总量,返回的是字节数

 @return 内存总字节
 */
+ (NSUInteger)ja_totalMemoryBytes;

/**
 获取手机可用内存,返回的是字节数

 @return 可用内容总字节
 */
+ (NSUInteger)ja_freeMemoryBytes;

/**
 获取手机sd卡空闲空间,返回的是字节数

 @return sd卡空闲字节数
 */
+ (long long)ja_freeDiskSpaceBytes;

/**
 获取手机sd卡总空间,返回的是字节数

 @return 手机sd卡总字节数
 */
+ (long long)ja_totalDiskSpaceBytes;

/**
 是否越狱
 
 @return 是否越狱
 */
+ (BOOL)ja_isNotSafe;
@end
