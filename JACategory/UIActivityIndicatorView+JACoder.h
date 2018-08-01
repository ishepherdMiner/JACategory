//
//  UIActivityIndicatorView+JACoder.h
//  AFNetworking
//
//  Created by HZ-Jason on 01/08/2018.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIActivityIndicatorView (JABuilder)

+ (instancetype)ja_builderWithStyle:(UIActivityIndicatorViewStyle)style
                              block:(void (NS_NOESCAPE ^)(UIActivityIndicatorView * _Nonnull make))block;

- (instancetype)ja_builder:(void (NS_NOESCAPE ^)(UIActivityIndicatorView * _Nonnull make))block;

@end

@interface UIActivityIndicatorView (JACoder)

@end

NS_ASSUME_NONNULL_END
