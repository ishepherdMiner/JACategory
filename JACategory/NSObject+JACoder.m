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

+ (void)ja_hookWithOriginSelector:(SEL)originSel
                 swizzledSelector:(SEL)swizzlSel {
    
    Method originalMethod = class_getInstanceMethod(self, originSel);
    Method swizzledMethod = class_getInstanceMethod(self, swizzlSel);
    BOOL didAddMethod =
    class_addMethod(self,
                    originSel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self,
                            swizzlSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (NSArray *)ja_propertyList:(BOOL)recursive {
    NSArray *glist = objc_getAssociatedObject([self class], @selector(ja_propertyList:));
    
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
        objc_setAssociatedObject([self class],@selector(ja_propertyList:), plistM, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        NSLog(@"[JA]:Found %ld properties on %@",(unsigned long)plistM.count,[self class]);
        
        return plistM.copy;
        
    }() : glist;
}

- (NSArray *)ja_ivarList:(BOOL)recursive{
    
    NSArray *glist = objc_getAssociatedObject([self class], @selector(ja_ivarList:));
    
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
        
        objc_setAssociatedObject([self class],@selector(ja_ivarList:), plistM, OBJC_ASSOCIATION_COPY_NONATOMIC);
        return plistM.copy;
        
    }() : glist;
}

- (NSArray *)ja_methodList:(BOOL)recursive {
    NSArray *glist = objc_getAssociatedObject([self class], @selector(ja_methodList:));
    
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
        
        objc_setAssociatedObject([self class],@selector(ja_methodList:), plistM, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        return plistM.copy;
        
    }() : glist;
}

- (void)ja_cleanCacheList {
    objc_removeAssociatedObjects([self class]);
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

+ (BOOL)ja_validateMehodCanRunWithTarget:(id)target selectorStr:(NSString *)selectorStr{
    unsigned int methodCount =0;
    Method* methodList = class_copyMethodList([target class],&methodCount);
    NSMutableArray *methodsArray = [NSMutableArray arrayWithCapacity:methodCount];
    
    for(int i = 0; i < methodCount; i++){
        Method temp = methodList[i];
//        IMP imp = method_getImplementation(temp);
//        SEL name_f = method_getName(temp);
        const char* name_s =sel_getName(method_getName(temp));
        int arguments = method_getNumberOfArguments(temp);
        const char* encoding =method_getTypeEncoding(temp);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
              arguments,
              [NSString stringWithUTF8String:encoding]);
        [methodsArray addObject:[NSString stringWithUTF8String:name_s]];
    }
    free(methodList);
    for (NSString *methodStr in [methodsArray copy]) {
        if ([methodStr isEqualToString:selectorStr]) {
            return YES;
            break;
        }
    }
    return NO;
}

- (id)ja_runSelector:(SEL)aSelector withObjects:(NSArray *)objects {
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];
    
    NSUInteger i = 1;
    
    for (id object in objects) {
        id tempObject = object;
        [invocation setArgument:&tempObject atIndex:++i];
    }
    [invocation invoke];
    
    if ([signature methodReturnLength]) {
        id data;
        [invocation getReturnValue:&data];
        return data;
    }
    return nil;
}

#ifdef CUSTOM_DEBUG

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
        // 3.遍历并打印，转换Objective-C的字符串
        NSString *className = [NSString stringWithCString:classes[i] encoding:NSUTF8StringEncoding];        
        [dClasses addObject:className];
        
        NSLog(@"[JA]:%@",className);
    }
    return [dClasses copy];
}

#endif

@end
