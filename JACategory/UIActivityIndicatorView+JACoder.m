//
//  UIActivityIndicatorView+JACoder.m
//  AFNetworking
//
//  Created by HZ-Jason on 01/08/2018.
//

#import "UIActivityIndicatorView+JACoder.h"

@implementation UIActivityIndicatorView (JACoder)

+ (instancetype)ja_builderWithStyle:(UIActivityIndicatorViewStyle)style
                              block:(void (NS_NOESCAPE ^)(UIActivityIndicatorView * _Nonnull make))block {
    
    UIActivityIndicatorView *instance = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    block(instance);
    return instance;
}

@end
