//
//  UIImageView+JACoder.m
//  AFNetworking
//
//  Created by HZ-Jason on 25/07/2018.
//

#import "UIImageView+JACoder.h"

@implementation UIImageView (JACoder)

+ (instancetype)ja_builderWithImage:(UIImage *)image
                              block:(void (^)(UIImageView * _Nonnull make))block {
    UIImageView *instance = [[UIImageView alloc] initWithImage:image];
    block(instance);
    return instance;
}

@end
