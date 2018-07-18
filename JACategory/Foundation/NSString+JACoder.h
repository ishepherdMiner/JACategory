//
//  NSString+JACoder.h
//  Daily_modules
//
//  Created by Jason on 09/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (JACoder)

/**
 *  OC字符串转换为C语言字符串
 *
 *  @return C语言字符串
 */
- (const char *)ja_cString;

/**
 *  C语言字符串转换成OC字符串
 *
 *  @param cString c语言字符串
 *
 *  @return OC字符串
 */
+ (NSString *)ja_ocString:(const char*)cString;

/**
 *  去除字符串两端空格后的字符串
 *
 *  @return 去除字符串两端空格后的字符串
 */
- (NSString *)ja_trim;

/**
 *  保留指定精度
 *
 *  @param value 要保留的小数点位数
 *
 *  @return double类型的数据
 */
- (instancetype)ja_accuracyDigital:(NSUInteger)value;

/**
 是否是有效的IP地址

 @return 是否是有效的IP地址
 */
- (BOOL)ja_isValidIP;

/**
 *  对网络请求的特殊字符进行编码
 *
 *  @param input 要进行编码的网络请求的字符串
 *
 *  @return 编码后的字符串
 *
 */
+ (NSString *)ja_encodeToPercentEscapeString:(NSString *)input;

/**
 *  将已经编码后的特殊字符进行解码
 *
 *  @param input 要解码的字符串
 *
 *  @return 解码后的字符串
 */
+ (NSString *)ja_decodeToUrlString:(NSString *)input;

/**
 *  单行文本 自适应内容
 *
 *  @param font 字体(默认是系统字体)
 *
 *  @return 文本所需尺寸
 */
- (CGSize)ja_singleLineWithFont:(UIFont *)font __IOS_AVAILABLE(7.0);

/**
 *  多行文本 指定宽度 自适应内容
 *
 *  @param font  字体
 *  @param width 行宽
 *
 *  @return 文本尺寸
 */
- (CGSize)ja_multiLineWithFont:(UIFont *)font
                withinWidth:(CGFloat)width __IOS_AVAILABLE(7.0);

/**
 *  多行文本 指定宽度 截取选项 自适应内容
 *
 *  @param font    字体
 *  @param width   行宽
 *  @param options 截取选项
 *
 *  @return 文本尺寸
 */
- (CGSize)ja_multiLineWithFont:(UIFont *)font
                   withinWidth:(CGFloat)width
                       options:(NSStringDrawingOptions)options __IOS_AVAILABLE(7.0);

- (CGSize)ja_multiLineWithAttrs:(NSDictionary *)attrs
                    withinWidth:(CGFloat)width
                        options:(NSStringDrawingOptions)options __IOS_AVAILABLE(7.0);


/**
 字节转换成NSString对象

 @param bytes 字节
 @param length 字节的长度
 @return NSString对象
 */
- (NSString *)ja_stringWithBytes:(uint8_t *)bytes length:(int)length;

/**
 设置字符串属性

 @param regex 正则表达式
 @param attrs 要设置的属性
 @return 根据正则处理后的NSAttributeString对象
 */
- (NSAttributedString *)ja_matchWithRegex:(NSString *)regex
                                    attrs:(NSDictionary *)attrs;


/**
 遍历当前字符串

 @param execBlock 执行回调,每次传递当前遍历的字符
 */
- (void)ja_mapString:(void (^)(NSString *c))execBlock;

/**
 *  返回base64编码的字符串内容
 */
- (NSString *)ja_base64encode;

/**
 *  返回base64解码的字符串内容
 */
- (NSString *)ja_base64decode;

/**
 *  计算MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 -s "string"
 *  @endcode
 *
 *  @return 32个字符的MD5散列字符串
 */
- (NSString *)ja_md5String;

/**
 *  计算SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1
 *  @endcode
 *
 *  @return 40个字符的SHA1散列字符串
 */
- (NSString *)ja_sha1String;

/**
 *  计算SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (NSString *)ja_sha256String;

/**
 *  计算SHA 512散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512
 *  @endcode
 *
 *  @return 128个字符的SHA 512散列字符串
 */
- (NSString *)ja_sha512String;

// Refer
// https://en.wikipedia.org/wiki/Hash-based_message_authentication_code
// http://baike.baidu.com/item/hmac
/**
 *  计算HMAC MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl dgst -md5 -hmac "key"
 *  @endcode
 *
 *  @return 32个字符的HMAC MD5散列字符串
 */
- (NSString *)ja_hmacMD5StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1 -hmac "key"
 *  @endcode
 *
 *  @return 40个字符的HMAC SHA1散列字符串
 */
- (NSString *)ja_hmacSHA1StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256 -hmac "key"
 *  @endcode
 *
 *  @return 64个字符的HMAC SHA256散列字符串
 */
- (NSString *)ja_hmacSHA256StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA512散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512 -hmac "key"
 *  @endcode
 *
 *  @return 128个字符的HMAC SHA512散列字符串
 */
- (NSString *)ja_hmacSHA512StringWithKey:(NSString *)key;

/**
 *  计算文件的MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 file.dat
 *  @endcode
 *
 *  @return 32个字符的MD5散列字符串
 */
- (NSString *)ja_fileMD5Hash;

/**
 *  计算文件的SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha1 file.dat
 *  @endcode
 *
 *  @return 40个字符的SHA1散列字符串
 */
- (NSString *)ja_fileSHA1Hash;

/**
 *  计算文件的SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha256 file.dat
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (NSString *)ja_fileSHA256Hash;

/**
 *  计算文件的SHA512散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha512 file.dat
 *  @endcode
 *
 *  @return 128个字符的SHA512散列字符串
 */
- (NSString *)ja_fileSHA512Hash;

@end

/// JAFormatter JAUI JAHTTP JASecurity
@interface NSString (JAConvenient)

/**
 快速判断是否一般有效的字符串对象
 非空,非Null,是字符串,有长度,不是空字符串
 
 @param instance 待判断的对象
 @return 是否是一般有效的字符串
 */
+ (BOOL)ja_valid:(id)instance;

@end

NS_ASSUME_NONNULL_END