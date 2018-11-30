//
//  UIScreen+JACoder.h
//  RssMoney
//
//  Created by Jason on 12/04/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define JA_SCREEN_WIDTH [UIScreen ja_width]
#define JA_SCREEN_HEIGHT [UIScreen ja_height]

#define JA_SCREEN_W JA_SCREEN_WIDTH
#define JA_SCREEN_H JA_SCREEN_HEIGHT

@interface UIScreen (JACoder)

+ (CGFloat)ja_width;
+ (CGFloat)ja_height;
+ (CGRect)ja_mainBounds;
+ (CGFloat)ja_brightness;

@end
NS_ASSUME_NONNULL_END
