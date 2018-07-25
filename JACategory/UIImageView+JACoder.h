//
//  UIImageView+JACoder.h
//  AFNetworking
//
//  Created by HZ-Jason on 25/07/2018.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (JABuilder)

+ (instancetype)ja_builderWithImage:(UIImage *)image
                              block:(void (NS_NOESCAPE ^)(UIImageView * _Nonnull make))block;
- (instancetype)ja_builder:(void (NS_NOESCAPE ^)(UIImageView * _Nonnull make))block;

@end

@interface UIImageView (JACoder)

@end

NS_ASSUME_NONNULL_END
