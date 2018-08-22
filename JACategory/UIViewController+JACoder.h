//
//  UIViewController+JACoder.h
//  MStarReader
//
//  Created by Jason on 05/08/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JACoder)

+ (UIViewController*)ja_currentViewController NS_AVAILABLE_IOS(8.0);

@end

NS_ASSUME_NONNULL_END
