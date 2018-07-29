//
//  UICollectionView+JACoder.m
//  AFNetworking
//
//  Created by Jason on 29/07/2018.
//

#import "UICollectionView+JACoder.h"

@implementation UICollectionView (JACoder)

+ (instancetype)ja_builderWithFrame:(CGRect)frame
                             layout:(UICollectionViewLayout *)layout
                              block:(void (NS_NOESCAPE ^)(UICollectionView * _Nonnull make))block {
    UICollectionView *instance = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    block(instance);
    return instance;
}
@end
