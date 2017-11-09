//
//  NSArray+JACoder.m
//  Daily_modules
//
//  Created by Jason on 09/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "NSArray+JACoder.h"

@implementation NSArray (JACoder)

#if DEBUG
- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        // 遍历数组
        [strM appendString:[NSString stringWithFormat:@"\t%@,\n",obj]];
    }];
    [strM appendString:@")"];
    return strM;
}
#endif

// http://blog.csdn.net/lin1109221208/article/details/51852659
#pragma mark -- 将数组拆分成固定长度
- (NSArray *)ja_splitWithSubsize:(int)subSize {
    // 数组将被拆分成指定长度数组的个数
    unsigned long count = self.count % subSize == 0 ? (self.count / subSize) : (self.count / subSize + 1);
    
    // 用来保存指定长度数组的可变数组对象
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    // 利用总个数进行循环，将指定长度的元素加入数组
    for (int i = 0; i < count; i ++) {
        // 数组下标
        int index = i * subSize;
        // 保存拆分的固定长度的数组元素的可变数组
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        // 移除子数组的所有元素
        [arr1 removeAllObjects];
        
        int j = index;
        // 将数组下标乘以1、2、3，得到拆分时数组的最大下标值，但最大不能超过数组的总大小
        while (j < subSize*(i + 1) && j < self.count) {
            [arr1 addObject:[self objectAtIndex:j]];
            j += 1;
        }
        // 将子数组添加到保存子数组的数组中
        [arr addObject:[arr1 copy]];
    }
    
    return [arr copy];
}
/**
 *  将数组拆分成固定长度的子数组
 *
 *  @param array 需要拆分的数组
 *  @param subSize 指定长度
 *
 */
//+ (NSArray *)ja_splitArray: (NSArray *)array withSubSize:(int)subSize {
//    // 数组将被拆分成指定长度数组的个数
//    unsigned long count = array.count % subSize == 0 ? (array.count / subSize) : (array.count / subSize + 1);
//    // 用来保存指定长度数组的可变数组对象
//    NSMutableArray *arr = [[NSMutableArray alloc] init];
//
//    // 利用总个数进行循环，将指定长度的元素加入数组
//    for (int i = 0; i < count; i ++) {
//        // 数组下标
//        int index = i * subSize;
//        // 保存拆分的固定长度的数组元素的可变数组
//        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
//        // 移除子数组的所有元素
//        [arr1 removeAllObjects];
//
//        int j = index;
//        // 将数组下标乘以1、2、3，得到拆分时数组的最大下标值，但最大不能超过数组的总大小
//        while (j < subSize*(i + 1) && j < array.count) {
//            [arr1 addObject:[array objectAtIndex:j]];
//            j += 1;
//        }
//        // 将子数组添加到保存子数组的数组中
//        [arr addObject:[arr1 copy]];
//    }
//
//    return [arr copy];
//}

+ (NSArray *)ja_allFilesAtPath:(NSString*)dirString {    
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:10];
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    NSArray* tempArray = [fileMgr contentsOfDirectoryAtPath:dirString error:nil];
    for (NSString* fileName in tempArray) {
        BOOL flag = true;
        NSString* fullPath = [dirString stringByAppendingPathComponent:fileName];
        if ([fileMgr fileExistsAtPath:fullPath isDirectory:&flag]) {
            if (!flag) {
                [array addObject:fullPath];
            }else {
                [NSArray ja_allFilesAtPath:fullPath];
            }
        }
    }
    return array;
}

@end
