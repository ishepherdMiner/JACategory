//
//  NSObject+JACoder.h
//  Daily_modules
//
//  Created by Jason on 09/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

/*============================
 *           列表
 *============================
 * 交换方法
 * 属性列表
 * 变量列表
 * 方法列表
 * 清空缓存列表
 *============================*/

@interface NSObject (JACoder)

/**
 交换方法

 @param cls 类
 @param originSel 原始方法
 @param swizzlSel 目标方法
 */
+ (void)ja_hookMethod:(Class)cls
       originSelector:(SEL)originSel
     swizzledSelector:(SEL)swizzlSel;

/**
 属性列表
 
 @param recursive 是否递归
 @return 属性列表
 */
- (NSArray *)ja_propertyList:(BOOL)recursive;


/**
 属性与类型列表
 @{
    属性1:类型1,
    属性2:类型2
 }
 @param recursive 是否递归
 @return 保存属性与类型的字典对象
 */
- (NSDictionary *)ja_propertyEncodeTypePairs:(BOOL)recursive;

/**
 变量列表
 
 @param recursive 是否递归
 @return 变量列表
 */
- (NSArray *)ja_ivarList:(BOOL)recursive;

/**
 * 方法列表
 *
 * @param recursive 是否递归
 */
- (NSArray *)ja_methodList:(BOOL)recursive;

/**
 清空缓存列表
 */
- (void)ja_cleanCacheList;

/// 不支持C++的类的获取
// ====================================
/// 获得开发者创建的类的类名列表
+ (NSArray *)ja_developerClasses;

/// 获得app所有的类名列表
+ (NSArray *)ja_allClasses;

@end
