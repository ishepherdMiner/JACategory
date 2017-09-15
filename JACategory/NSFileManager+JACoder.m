//
//  NSFileManager+JACoder.m
//  Summary
//
//  Created by Jason on 08/06/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "NSFileManager+JACoder.h"

@implementation NSFileManager (JACoder)

/**
 *  获得用户沙盒的路径
 *
 *  @param type (NSSearchPathForDirectoriesInDomains 第二个默认传NSUserDomainMask)
 *
 *  @return 返回指定沙盒文件夹下的文件名列表
 */
- (NSArray *)ja_directoryPathWithType:(NSSearchPathDirectory)type{
    return NSSearchPathForDirectoriesInDomains(type, NSUserDomainMask, YES);
}

- (NSString *)ja_appendFilePathFormat:(NSString *)filePath
                         directory:(NSString *)directory {
    
    return [directory stringByAppendingPathComponent:filePath];
}

- (NSString *)ja_createDirectoryAtDocumentWithName:(NSString *)name {
    NSString *directoryPath = nil;
    if (name) {
        directoryPath = [self ja_appendFilePathFormat:name directory:[self ja_documentOfPath]];
    }else {
        directoryPath = [self ja_documentOfPath];
    }
    
    BOOL isDirectory = false;
    if ([self fileExistsAtPath:directoryPath isDirectory:&isDirectory]) {
        if (isDirectory) {
#if DEBUG
            NSLog(@"%@",@"[JA]:文件夹已存在");
#endif            
            return directoryPath;
        }
    }
    
    NSError *error = nil;
    BOOL r = [self createDirectoryAtPath:directoryPath withIntermediateDirectories:true attributes:nil error:&error];
#if DEBUG
    if (r) {
        NSLog(@"%@",@"[JA]:成功创建文件夹");
    }else if (error) {
        NSLog(@"%@",[NSString stringWithFormat:@"[JA]:创建失败[%@]",error]);
    }
    
#endif
    return directoryPath;
}

- (NSString *)ja_createDirectoryAtCacheWithName:(NSString *)name {
    NSString *directoryPath = nil;
    if (name) {
        directoryPath = [self ja_appendFilePathFormat:name directory:[self ja_cacheOfPath]];
    }else {
        directoryPath = [self ja_cacheOfPath];
    }
    
    NSError *error = nil;
    BOOL r = [self createDirectoryAtPath:directoryPath withIntermediateDirectories:true attributes:nil error:&error];
#if DEBUG
    if (r) {
        NSLog(@"%@",@"[JA]:成功创建文件夹");
    }else if (error) {
        NSLog(@"%@",[NSString stringWithFormat:@"[JA]:创建失败[%@]",error]);
    }
    
#endif
    return directoryPath;

}

- (NSString *)ja_documentOfPath {
    return [[self ja_directoryPathWithType:NSDocumentDirectory] objectAtIndex:0];
}

- (NSString *)ja_libraryOfPath {
    return [[self ja_directoryPathWithType:NSLibraryDirectory] objectAtIndex:0];
}

- (NSString *)ja_cacheOfPath {
    return [[self ja_directoryPathWithType:NSCachesDirectory] objectAtIndex:0];
}

- (NSString *)ja_documentationOfPath {
    return [[self ja_directoryPathWithType:NSDocumentDirectory] objectAtIndex:0];
}

- (NSString *)ja_tmpOfPath {
    return NSTemporaryDirectory();
}

@end
