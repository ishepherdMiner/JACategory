//
//  NSDictionary+JACoder.m
//  Daily_modules
//
//  Created by Jason on 09/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "NSDictionary+JACoder.h"

@implementation NSDictionary (JACoder)

+ (NSDictionary*)ja_dictionaryWithFilename:(NSString *)fileName {
    return [self ja_dictionaryWithFilename:fileName bundle:nil];
}

+ (NSDictionary *)ja_dictionaryWithFilename:(NSString *)fileName
                                     bundle:(NSBundle *)bundle {
    
    NSParameterAssert(fileName);
    NSString *filePath = nil;
    if (bundle == nil) {
        filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    }else {
        if ([fileName hasSuffix:@"json"]) {
            filePath = [bundle pathForResource:fileName ofType:nil];
        }else {
            filePath = [bundle pathForResource:fileName ofType:@"json"];
        }
    }
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                           options:0
                                                             error:&error];
    
    if (error != nil) return nil;
    return result;
}

#if DEBUG
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *desc = [NSMutableString string];
    
    NSMutableString *tabString = [[NSMutableString alloc] initWithCapacity:level];
    for (NSUInteger i = 0; i < level; ++i) {
        [tabString appendString:@"\t"];
    }
    
    NSString *tab = @"";
    if (level > 0) {
        tab = tabString;
    }
    
    [desc appendString:@"\t{\n"];
    
    // 遍历数组,self就是当前的数组
    for (id key in self.allKeys) {
        id obj = [self objectForKey:key];
        
        if ([obj isKindOfClass:[NSString class]]) {
            [desc appendFormat:@"%@\t%@ = \"%@\",\n", tab, key, obj];
        } else if ([obj isKindOfClass:[NSArray class]]
                   || [obj isKindOfClass:[NSDictionary class]]
                   || [obj isKindOfClass:[NSSet class]]) {
            [desc appendFormat:@"%@\t%@ = %@,\n", tab, key, [obj descriptionWithLocale:locale indent:level + 1]];
        } else if ([obj isKindOfClass:[NSData class]]) {
            // 如果是NSData类型，尝试去解析结果，以打印出可阅读的数据
            NSError *error = nil;
            NSObject *result =  [NSJSONSerialization JSONObjectWithData:obj
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&error];
            // 解析成功
            if (error == nil && result != nil) {
                if ([result isKindOfClass:[NSDictionary class]]
                    || [result isKindOfClass:[NSArray class]]
                    || [result isKindOfClass:[NSSet class]]) {
                    NSString *str = [((NSDictionary *)result) descriptionWithLocale:locale indent:level + 1];
                    [desc appendFormat:@"%@\t%@ = %@,\n", tab, key, str];
                } else if ([obj isKindOfClass:[NSString class]]) {
                    [desc appendFormat:@"%@\t%@ = \"%@\",\n", tab, key, result];
                }
            } else {
                @try {
                    NSString *str = [[NSString alloc] initWithData:obj encoding:NSUTF8StringEncoding];
                    if (str != nil) {
                        [desc appendFormat:@"%@\t%@ = \"%@\",\n", tab, key, str];
                    } else {
                        [desc appendFormat:@"%@\t%@ = %@,\n", tab, key, obj];
                    }
                }
                @catch (NSException *exception) {
                    [desc appendFormat:@"%@\t%@ = %@,\n", tab, key, obj];
                }
            }
        } else {
            [desc appendFormat:@"%@\t%@ = %@,\n", tab, key, obj];
        }
    }
    
    [desc appendFormat:@"%@}", tab];
    
    return desc;
}
#endif
@end

@implementation NSDictionary (JAConvenient)

/**
 是否是有效的字典对象
 是字典 && 长度非空
 
 @param instance 待判断的对象
 @return 判断结果
 */
+ (BOOL)ja_valid:(id)instance {
    if ([instance isKindOfClass:[NSDictionary class]] && [instance count] > 0) {
        return YES;
    }
    return NO;
}

@end