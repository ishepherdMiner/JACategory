//
//  NSFileManager+JACoder.h
//  Summary
//
//  Created by Jason on 08/06/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSFileManager (JACoder)

/// shortcut
/// .../sandbox/Document
- (NSString *)ja_documentOfPath;

/// .../sandbox/Library
- (NSString *)ja_libraryOfPath;

/// .../sandbox/Library/Cache
- (NSString *)ja_cacheOfPath;

/// .../sandbox/tmp
- (NSString *)ja_tmpOfPath;

/// .../sandbox/Library/Documentation
- (NSString *)ja_documentationOfPath;

/**
 追加文件路径格式的路径,主要是自动追加分隔符

 @param filePath 文件或文件夹名
 @param directory 文件夹
 @return 文件路径
 */
- (NSString *)ja_appendFilePathFormat:(NSString *)filePath
                         directory:(NSString *)directory;

/// 在docuement文件夹下创建文件夹，若已存在，则返回路径
- (NSString *)ja_createDirectoryAtDocumentWithName:(NSString *)name;
- (NSString *)ja_createDirectoryAtCacheWithName:(NSString *)name;
- (NSString *)ja_createDirectoryAtTmpWithName:(NSString *)name;

@end
NS_ASSUME_NONNULL_END
