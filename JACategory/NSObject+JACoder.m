//
//  NSObject+JACoder.m
//  Daily_modules
//
//  Created by Jason on 09/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "NSObject+JACoder.h"
#import <objc/message.h>
#import <dlfcn.h>
#import <mach-o/ldsyms.h>

@implementation NSObject (JACoder)

+ (void)ja_hookMethod:(Class)cls
       originSelector:(SEL)originSel
     swizzledSelector:(SEL)swizzlSel {
    
    Method originalMethod = class_getInstanceMethod(cls, originSel);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzlSel);
    BOOL didAddMethod =
    class_addMethod(cls,
                    originSel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls,
                            swizzlSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

const void* propertiesKey = "com.coder.category.propertiesKey";
const void* ivarKey = "com.coder.category.ivarKey";
const void* methodKey = "com.coder.category.methodKey";
// const void* propertyEncodeTypePairsKey = "com.coder.category.propertyEncodeTypePairsKey";

- (NSArray *)ja_propertyList:(BOOL)recursive {
    NSArray *glist = objc_getAssociatedObject([self class], propertiesKey);
    
    return glist == nil ? ^{
        
        unsigned int count = 0;
        NSMutableArray *plistM = [NSMutableArray arrayWithCapacity:count];
        
        Class cls = [self class];
        do {
            objc_property_t *list = class_copyPropertyList(cls, &count);
            for (int i = 0; i < count; ++i) {
                objc_property_t pty = list[i];
                const char *pname = property_getName(pty);
                [plistM addObject:[NSString stringWithUTF8String:pname]];
            }
            free(list);
            cls = [cls superclass];
        } while (cls && recursive);
        objc_setAssociatedObject([self class],propertiesKey, plistM, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
#if DEBUG
        NSLog(@"[JA]:Found %ld properties on %@",(unsigned long)plistM.count,[self class]);
#endif
        
        return plistM.copy;
        
    }() : glist;
}
/*
- (NSDictionary *)ja_propertyEncodeTypePairs:(BOOL)recursive {
    
    NSDictionary *glist = objc_getAssociatedObject([self class], propertyEncodeTypePairsKey);
    
    return glist == nil ? ^{
        
        unsigned int count = 0;
        NSMutableDictionary *plistDicM = [NSMutableDictionary dictionaryWithCapacity:count];
        
        Class cls = [self class];
        do {
            objc_property_t *list = class_copyPropertyList(cls, &count);
            for (int i = 0; i < count; ++i) {
                objc_property_t pty = list[i];
                const char *pname = property_getName(pty);
                const char *pattr = property_getAttributes(pty);
                NSString *pname_utf8 = [NSString stringWithUTF8String:pname];
                NSString *pattr_utf8 = [NSString stringWithUTF8String:pattr];
                
                /// https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1
                if ([pattr_utf8 rangeOfString:@"c"].location != NSNotFound) {
                    
                }else if ([pattr_utf8 rangeOfString:@"NSString"].location != NSNotFound) {
                    pattr_utf8 = @"NSString";
                }else if ([pattr_utf8 rangeOfString:@"NSNumber"].location != NSNotFound) {
                    pattr_utf8 = @"NSNumber";
                }else if ([pattr_utf8 rangeOfString:@"TQ"].location != NSNotFound) {
                    pattr_utf8 = @"NSUInteger";
                }else if ([pattr_utf8 rangeOfString:@"NSArray"].location != NSNotFound) {
                    pattr_utf8 = @"NSArray";
                }else if ([pattr_utf8 rangeOfString:@"@"].location != NSNotFound) {
                    if ([pattr_utf8 componentsSeparatedByString:@"\""].count >= 2) {
                        pattr_utf8 = [pattr_utf8 componentsSeparatedByString:@"\""][1];
                    }
                }
                
                // ...
                [plistDicM setObject:pattr_utf8 forKey:pname_utf8];
            }
            free(list);
            cls = [cls superclass];
        } while (cls && recursive);
        objc_setAssociatedObject([self class],propertyEncodeTypePairsKey, plistDicM, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        return plistDicM.copy;
        
    }() : glist;
}
*/

- (NSArray *)ja_ivarList:(BOOL)recursive{
    
    NSArray *glist = objc_getAssociatedObject([self class], ivarKey);
    
    return glist == nil ? ^{
        
        unsigned int count = 0;
        NSMutableArray *plistM = [NSMutableArray arrayWithCapacity:count];
        
        Class cls = [self class];
        do {
            Ivar *list = class_copyIvarList(cls, &count);
            for (int i = 0; i < count; ++i) {
                Ivar ity = list[i];
                const char *iname = ivar_getName(ity);
                [plistM addObject:[NSString stringWithUTF8String:iname]];
            }
            free(list);
            cls = [cls superclass];
        } while (cls && recursive);
        
#if DEBUG
        NSLog(@"[JA]:Found %ld ivar on %@",(unsigned long)plistM.count,[self class]);
#endif
        
        objc_setAssociatedObject([self class],ivarKey, plistM, OBJC_ASSOCIATION_COPY_NONATOMIC);
        return plistM.copy;
        
    }() : glist;
}

- (NSArray *)ja_methodList:(BOOL)recursive {
    NSArray *glist = objc_getAssociatedObject([self class], methodKey);
    
    return glist == nil ? ^{
        
        unsigned int methodCount = 0;
        NSMutableArray *plistM = [NSMutableArray arrayWithCapacity:methodCount];
        
        Class cls = [self class];
        do {
            Method *methods = class_copyMethodList(cls, &methodCount);
            
            for (unsigned int i = 0; i < methodCount; i++) {
                Method method = methods[i];
                
                /*
                 printf("\t'%s'|'%s' of encoding '%s'\n",
                 class_getName(cls),
                 sel_getName(method_getName(method)),
                 method_getTypeEncoding(method));
                 */
                
                [plistM addObject:[NSString stringWithUTF8String:sel_getName(method_getName(method))]];
            }
            free(methods);
            cls = [cls superclass];
        }while (cls && recursive);
        
#if DEBUG
        printf("Found %d methods on '%s'\n", methodCount, class_getName([self class]));
#endif
        
        objc_setAssociatedObject([self class],ivarKey, plistM, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        return plistM.copy;
        
    }() : glist;
}

- (void)ja_cleanCacheList {
    objc_removeAssociatedObjects([self class]);
}

+ (NSArray *)ja_developerClasses {
    NSMutableArray *dClasses = [NSMutableArray array];
    unsigned int count;
    const char **classes;
    Dl_info info;
    
    // 1.获取app的路径
    dladdr(&_mh_execute_header, &info);
    
    // 2.返回当前运行的app的所有类的名字，并传出个数
    // classes：二维数组 存放所有类的列表名称
    // count：所有的类的个数
    classes = objc_copyClassNamesForImage(info.dli_fname, &count);
    
    for (int i = 0; i < count; i++) {
        //3.遍历并打印，转换Objective-C的字符串
        NSString *className = [NSString stringWithCString:classes[i] encoding:NSUTF8StringEncoding];        
        [dClasses addObject:className];
        
#ifdef DEBUG
        NSLog(@"[JA]:%@",className);
#endif
    }
    return [dClasses copy];
}

+ (NSArray *)ja_allClasses {
    NSMutableArray *dClasses = [NSMutableArray array];
    int numClasses;
    Class * classes = NULL;
    
    // 1.获取当前app运行时所有的类，包括系统创建的类和开发者创建的类
    numClasses = objc_getClassList(NULL, 0);
    
    if (numClasses > 0 ){
        // 2.创建一个可以容纳numClasses个的大小空间
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        
        // 3.重新获取具体类的列表和个数
        numClasses = objc_getClassList(classes, numClasses);
        
        // 4.遍历
        for (int i = 0; i < numClasses; i++) {
            Class class = classes[i];
            NSString *className = [NSString stringWithCString:class_getName(class) encoding:NSUTF8StringEncoding];
            [dClasses addObject:className];
            
#ifdef DEBUG
            NSLog(@"[JA]:%@", className);
#endif
            
        }
        free(classes);
    }
    return [dClasses copy];
}
@end
