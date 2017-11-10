//
//  UIApplication+Coder.h
//  JACategory
//
//  Created by Jason on 10/11/2017.
//

#import <UIKit/UIKit.h>

@interface UIApplication (JACoder)

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

@end
