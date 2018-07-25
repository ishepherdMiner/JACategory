//
//  UISlider+JACoder.h
//  AFNetworking
//
//  Created by Jason on 24/07/2018.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISlider (JABuilder)

+ (instancetype)ja_builder:(void (NS_NOESCAPE ^)(UISlider * _Nonnull make))block;
- (instancetype)ja_builder:(void (NS_NOESCAPE ^)(UISlider * _Nonnull make))block;

@end

@interface UISlider (JACoder)

@end

NS_ASSUME_NONNULL_END
