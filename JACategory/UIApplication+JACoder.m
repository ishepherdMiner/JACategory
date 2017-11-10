//
//  UIApplication+Coder.m
//  JACategory
//
//  Created by Jason on 10/11/2017.
//

#import "UIApplication+JACoder.h"

@implementation UIApplication (Coder)

+ (NSString *)ja_pid {
    return [NSString stringWithFormat:@"%d",[[NSProcessInfo processInfo] processIdentifier]];
}

+ (NSString *)ja_startupTime {
    // 获取系统自开机算起的累计时间
    NSProcessInfo *info = [NSProcessInfo processInfo] ;
    NSDate *dat = [NSDate date];
    NSTimeInterval curtime = [dat timeIntervalSince1970];
    NSString *uptime = [[NSString alloc] initWithFormat:@"%ld", (long)curtime - (long)info.systemUptime];
    return uptime;
}
@end
