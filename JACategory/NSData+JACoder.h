//
//  NSData+JACoder.h
//  Summary
//
//  Created by Jason on 06/06/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (JACoder)

/**
 二进制转换为NSString对象,编码格式为UTF8
 
 @return 字符串对象
 */
- (NSString *)ja_toString;

/**
 AES256加密

 @param key 秘钥
 @return 加密后的二进制数据
 */
- (NSData *)ja_aes256EncryptWithKey:(NSString *)key;

/**
 AES256解密

 @param key 密匙
 @return 解密后的二进制数据
 */
- (NSData *)ja_aes256DecryptWithKey:(NSString *)key;

/**
 十六进制字符串转换为NSData对象

 @param content 16进制字符串
 @return NSData对象
 */
+ (NSData *)ja_convertHexToData:(NSString *)content;

/**
 NSData对象转换为十六进制字符串

 @param data NSData对象
 @return 十六进制字符串
 */
+ (NSString *)ja_convertDataToHex:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
