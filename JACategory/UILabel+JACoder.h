//
//  UILabel+JACoder.h
//  JACategory
//
//  Created by HZ-Jason on 18/07/2018.
//  Copyright © 2018 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (JACoder)

@end

@interface UILabel (Interceptor)

/// 设置拦截器
- (void)setInterceptor:(id)interceptor;
- (id)interceptor;

@end

NS_ASSUME_NONNULL_END
