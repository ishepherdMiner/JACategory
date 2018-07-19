#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "JACategory.h"
#import "NSArray+JACoder.h"
#import "NSBundle+JACoder.h"
#import "NSData+JACoder.h"
#import "NSDate+JACoder.h"
#import "NSDictionary+JACoder.h"
#import "NSFileManager+JACoder.h"
#import "NSNumber+JACoder.h"
#import "NSObject+JACoder.h"
#import "NSString+JACoder.h"
#import "NSURL+JACoder.h"
#import "UIButton+JACoder.h"
#import "UIDevice+JACoder.h"
#import "UIImage+JACoder.h"
#import "UILabel+JACoder.h"
#import "UINavigationController+JACoder.h"
#import "UIScreen+JACoder.h"
#import "UITableViewCell+JACoder.h"
#import "UITextField+JACoder.h"
#import "UIView+JACoder.h"
#import "UIViewController+JACoder.h"

FOUNDATION_EXPORT double JACategoryVersionNumber;
FOUNDATION_EXPORT const unsigned char JACategoryVersionString[];

