//
//  UIScrollView+JACoder.h
//  AFNetworking
//
//  Created by Jason on 24/07/2018.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (JABuilder)

+ (instancetype)ja_builder:(void (NS_NOESCAPE ^)(UIScrollView * _Nonnull make))block;
- (instancetype)ja_builder:(void (NS_NOESCAPE ^)(UIScrollView * _Nonnull make))block;

@end

@interface UIScrollView (JACoder)

@end

NS_ASSUME_NONNULL_END
