//
//  UILabel+JACoder.h
//  JACategory
//
//  Created by HZ-Jason on 18/07/2018.
//  Copyright © 2018 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JABuilder;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Weverything"

@interface UILabel (JACoder) <JABuilder>

#pragma clang diagnostic pop

/// 
+ (instancetype)ja_builderLabel:(void (^)(UILabel *label))block;

@end


@protocol UILabelInterceptorDelegate <NSObject>

@optional
/**
 UILabel的内间距

 @return 内间距
 */
- (UIEdgeInsets)ja_edgeInsets;

@end

@interface UILabel (Interceptor)

/// 设置拦截器
- (void)setInterceptor:(id<UILabelInterceptorDelegate>)interceptor;
- (id)interceptor;

@end

NS_ASSUME_NONNULL_END
