//
//  UITableView+JACoder.m
//  AFNetworking
//
//  Created by HZ-Jason on 25/07/2018.
//

#import "UITableView+JACoder.h"

@implementation UITableView (JACoder)

+ (instancetype)ja_builderWithFrame:(CGRect)frame
                              style:(UITableViewStyle)style
                              block:(void (^)(UITableView * _Nonnull make))block {
    
    UITableView *instance = [[UITableView alloc] initWithFrame:frame style:style];
    block(instance);
    return instance;
}

@end
