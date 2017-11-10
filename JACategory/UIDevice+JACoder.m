//
//  UIDevice+JACoder.m
//  Daily_modules
//
//  Created by Jason on 14/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "UIDevice+JACoder.h"
#import <objc/message.h>
#import <CoreMotion/CoreMotion.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>


#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

const char *gyroKey = "gyroKey";

@implementation UIDevice (JACoder)

+ (instancetype)sharedDevice {
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#if DEBUG
+ (void)ja_gyroWithStartBlock:(void (^)(CMGyroData *gyroData,NSError *error))handler {
    
    CMMotionManager *manager = nil;
    if (objc_getAssociatedObject([self sharedDevice], gyroKey)) {
        manager = objc_getAssociatedObject([self sharedDevice], gyroKey);
    }else {
        // 初始化全局管理对象
        manager = [[CMMotionManager alloc] init];
        objc_setAssociatedObject([self sharedDevice], gyroKey, manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSMutableArray *rs = [NSMutableArray array];
    if (manager.deviceMotionAvailable) {
        [rs addObjectsFromArray:@[@(manager.gyroData.rotationRate.x),@(manager.gyroData.rotationRate.y),@(manager.gyroData.rotationRate.z)]];
    }
    
    // 判断陀螺仪可不可以，判断陀螺仪是不是开启
    if ([manager isGyroAvailable]){
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        manager.gyroUpdateInterval = 0.5;
        
        // Push方式获取和处理数据
        [manager startGyroUpdatesToQueue:queue
                             withHandler:^(CMGyroData *gyroData, NSError *error)
         {
             handler(gyroData,error);
         }];
    }
}

#endif

+ (NSString *)ja_model {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSDictionary *mDics = @{
    // iPhone
                            @"iPhone1,1" : @"iPhone",
                            @"iPhone1,2" : @"iPhone 3G",
                            @"iPhone2,1" : @"iPhone 3GS",
                            @"iPhone3,1" : @"iPhone 4",
                            @"iPhone3,2" : @"iPhone 4",
                            @"iPhone3,3" : @"iPhone 4",
                            @"iPhone4,1" : @"iPhone 4S",
                            @"iPhone5,1" : @"iPhone 5",
                            @"iPhone5,2" : @"iPhone 5",
                            @"iPhone5,3" : @"iPhone 5c",
                            @"iPhone5,4" : @"iPhone 5c",
                            @"iPhone6,1" : @"iPhone 5s",
                            @"iPhone6,2" : @"iPhone 5s",
                            @"iPhone7,2" : @"iPhone 6",
                            @"iPhone7,1" : @"iPhone 6 Plus",
                            @"iPhone8,1" : @"iPhone 6s",
                            @"iPhone8,2" : @"iPhone 6s Plus",
                            @"iPhone8,4" : @"iPhone SE",
                            @"iPhone9,1" : @"iPhone 7",
                            @"iPhone9,3" : @"iPhone 7",
                            @"iPhone9,2" : @"iPhone 7 Plus",
                            @"iPhone9,4" : @"iPhone 7 Plus",
                            @"iPhone10,1": @"iPhone 8",
                            @"iPhone10,4": @"iPhone 8",
                            @"iPhone10,2": @"iPhone 8 Plus",
                            @"iPhone10,5": @"iPhone 8 Plus",
                            @"iPhone10,3": @"iPhone X",
                            @"iPhone10,6": @"iPhone X",
    // iPad
                            @"iPad1,1" : @"iPad",
                            @"iPad2,1" : @"iPad 2",
                            @"iPad2,2" : @"iPad 2",
                            @"iPad2,3" : @"iPad 2",
                            @"iPad2,4" : @"iPad 2",
                            @"iPad3,1" : @"iPad (3rd generation)",
                            @"iPad3,2" : @"iPad (3rd generation)",
                            @"iPad3,3" : @"iPad (3rd generation)",
                            @"iPad3,4" : @"iPad (4th generation)",
                            @"iPad3,5" : @"iPad (4th generation)",
                            @"iPad3,6" : @"iPad (4th generation)",
                            @"iPad4,1" : @"iPad Air",
                            @"iPad4,2" : @"iPad Air",
                            @"iPad4,3" : @"iPad Air",
                            @"iPad5,3" : @"iPad Air 2",
                            @"iPad5,4" : @"iPad Air 2",
                            @"iPad6,7" : @"iPad Pro (12.9-inch)",
                            @"iPad6,8" : @"iPad Pro (12.9-inch)",
                            @"iPad6,3" : @"iPad Pro (9.7-inch)",
                            @"iPad6,4" : @"iPad Pro (9.7-inch)",
                            @"iPad6,11": @"iPad (5th generation)",
                            @"iPad6,12": @"iPad (5th generation)",
                            @"iPad7,1" : @"iPad Pro (12.9-inch, 2nd generation)",
                            @"iPad7,2" : @"iPad Pro (12.9-inch, 2nd generation)",
                            @"iPad7,3" : @"iPad Pro (10.5-inch)",
                            @"iPad7,4" : @"iPad Pro (10.5-inch)",
    // iPad Mini
                            @"iPad2,5" : @"iPad mini",
                            @"iPad2,6" : @"iPad mini",
                            @"iPad2,7" : @"iPad mini",
                            @"iPad4,4" : @"iPad mini 2",
                            @"iPad4,5" : @"iPad mini 2",
                            @"iPad4,6" : @"iPad mini 2",
                            @"iPad4,7" : @"iPad mini 3",
                            @"iPad4,8" : @"iPad mini 3",
                            @"iPad4,9" : @"iPad mini 3",
                            @"iPad5,1" : @"iPad mini 4",
                            @"iPad5,2" : @"iPad mini 4",
    // Watch
                            @"Watch1,1": @"Apple Watch (1st generation)",
                            @"Watch1,2": @"Apple Watch (1st generation)",
                            @"Watch2,6": @"Apple Watch Series 1",
                            @"Watch2,7": @"Apple Watch Series 1",
                            @"Watch2,3": @"Apple Watch Series 2",
                            @"Watch2,4": @"Apple Watch Series 2",
                            @"Watch3,1": @"Apple Watch Series 3",
                            @"Watch3,2": @"Apple Watch Series 3",
                            @"Watch3,3": @"Apple Watch Series 3",
                            @"Watch3,4": @"Apple Watch Series 3",
    };
    return [mDics objectForKey:platform];
}

+ (NSString *)ja_lang {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defaults objectForKey:@"AppleLanguages"];
    NSString* currentLanguage = [languages objectAtIndex:0];
    return currentLanguage;
}

+ (NSString *)ja_idfa {
    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    if (adId == nil||[adId isEqualToString:@""]||[adId isEqualToString:@"(null)"]) {
        adId = @"";
    }
    
    return adId;
}

+ (BOOL)ja_wifiAvailable {
    struct ifaddrs *addresses;
    struct ifaddrs *cursor;
    BOOL wiFiAvailable = NO;
    if (getifaddrs(&addresses) != 0) return NO;
    
    cursor = addresses;
    while (cursor != NULL) {
        if (cursor -> ifa_addr -> sa_family == AF_INET
            && !(cursor -> ifa_flags & IFF_LOOPBACK)) // Ignore the loopback address
        {
            // Check for WiFi adapter
            if (strcmp(cursor -> ifa_name, "en0") == 0) {
                wiFiAvailable = YES;
                break;
            }
        }
        cursor = cursor -> ifa_next;
    }
    
    freeifaddrs(addresses);
    return wiFiAvailable;
}

+ (NSString *)ja_carrier {
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netInfo subscriberCellularProvider];    
    NSString *carrierCode;
    
    if (carrier == nil) {
        carrierCode = @"WL";
    }else {
        carrierCode = [carrier carrierName];
        if([@"中国移动" isEqualToString:carrierCode]) {
            return @"CM";
        } else if([@"中国联通" isEqualToString:carrierCode]) {
            return @"CU";
        } else if([@"中国电信" isEqualToString:carrierCode]) {
            return @"CT";
        } else
            return @"false";
    }
    
    return @"false";
}

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

+ (NSString *)ja_ip:(BOOL)preferIPv4{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self ja_ip];
    // NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = true;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (NSDictionary *)ja_ip{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}
@end
