//
//  UITableView+JACoder.h
//  AFNetworking
//
//  Created by HZ-Jason on 25/07/2018.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (JABuilder)

+ (instancetype)ja_builderWithFrame:(CGRect)frame
                              style:(UITableViewStyle)style
                              block:(void (NS_NOESCAPE ^)(UITableView * _Nonnull make))block;

- (instancetype)ja_builder:(void (NS_NOESCAPE ^)(UITableView * _Nonnull make))block;

@end

@interface UITableView (JACoder)

@end
NS_ASSUME_NONNULL_END
