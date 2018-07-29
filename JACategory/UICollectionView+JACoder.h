//
//  UICollectionView+JACoder.h
//  AFNetworking
//
//  Created by Jason on 29/07/2018.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (JABuilder)

+ (instancetype)ja_builderWithFrame:(CGRect)frame
                             layout:(UICollectionViewLayout *)style
                              block:(void (NS_NOESCAPE ^)(UICollectionView * _Nonnull make))block;

- (instancetype)ja_builder:(void (NS_NOESCAPE ^)(UICollectionView * _Nonnull make))block;

@end


@interface UICollectionView (JACoder)

@end

NS_ASSUME_NONNULL_END
