//
//  UITextView+JACoder.h
//  AFNetworking
//
//  Created by Jason on 24/07/2018.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (JABuilder)

+ (instancetype)ja_builder:(void (NS_NOESCAPE ^)(UITextView * _Nonnull make))block;
- (instancetype)ja_builder:(void (NS_NOESCAPE ^)(UITextView * _Nonnull make))block;

@end

@interface UITextView (JACoder)

@end

NS_ASSUME_NONNULL_END
