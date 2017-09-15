//
//  NSData+JACoder.h
//  Summary
//
//  Created by Jason on 06/06/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (JACoder)

- (NSData *)ja_AES256EncryptWithKey:(NSString *)key;   // 加密
- (NSData *)ja_AES256DecryptWithKey:(NSString *)key;   // 解密

+ (NSString *)ja_base64encode:(NSString*)str;          // 同上base64编码
+ (NSData *)ja_convertHexStrToData:(NSString *)str;

@end
