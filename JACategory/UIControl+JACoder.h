//
//  UIControl+JACoder.h
//  AFNetworking
//
//  Created by Jason on 24/07/2018.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (JABuilder)

+ (instancetype)ja_builder:(void (NS_NOESCAPE ^)(UIControl * _Nonnull make))block;
- (instancetype)ja_builder:(void (NS_NOESCAPE ^)(UIControl * _Nonnull make))block;

@end

@interface UIControl (JACoder)

@end

NS_ASSUME_NONNULL_END
