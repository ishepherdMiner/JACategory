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

#ifdef DEBUG
    #define NSLog(...) printf("%s -LineNumber:%d: %s\n",__PRETTY_FUNCTION__, __LINE__ ,[[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
    #define NSLog(format, ...)
#endif

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

#if DEBUG

const void* propertiesKey = "com.coder.category.propertiesKey";
const void* ivarKey = "com.coder.category.ivarKey";
const void* methodKey = "com.coder.category.methodKey";

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
        
        NSLog(@"[JA]:Found %ld properties on %@",(unsigned long)plistM.count,[self class]);
        
        return plistM.copy;
        
    }() : glist;
}

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
        
        NSLog(@"[JA]:Found %ld ivar on %@",(unsigned long)plistM.count,[self class]);
        
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
        
        printf("Found %d methods on '%s'\n", methodCount, class_getName([self class]));
        
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
        
        NSLog(@"[JA]:%@",className);
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
            
            NSLog(@"[JA]:%@", className);
            
        }
        free(classes);
    }
    return [dClasses copy];
}

#endif
@end
