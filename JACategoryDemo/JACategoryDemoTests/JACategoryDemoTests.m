//
//  JACategoryDemoTests.m
//  JACategoryDemoTests
//
//  Created by Jason on 29/08/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <JACategory.h>

@interface JACategoryDemoTests : XCTestCase

@property (nonatomic,strong) NSObject *objTest;
@end

@implementation JACategoryDemoTests

- (void)setUp {
    [super setUp];
    _objTest = [[NSObject alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testObject {
    NSLog(@"成员变量列表:%@",[_objTest ja_ivarList:true]);
    
    NSLog(@"属性列表:%@",[_objTest ja_propertyList:true]);
    NSLog(@"方法列表:%@",[_objTest ja_methodList:true]);
    NSLog(@"自定义类列表:%@",[NSObject ja_developerClasses]);
    // NSLog(@"所有类列表:%@",[NSObject ja_allClasses]);     
}

// ja_splitArray
- (void)testArray {
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSLog(@"mainBundle中的所有文件:%@",[NSArray ja_allFilesAtPath:path]);
    
    NSArray *newArrs = [@[@"1",@"3",@"8",@"9",@"1",@"3",@"8",@"9",@"1",@"3",@"8",@"9"] ja_splitWithSubsize:3];
    NSLog(@"数组分割成几个子数组:%@",newArrs);
    XCTAssert([[newArrs.lastObject lastObject] isEqualToString:@"9"]);
}

- (void)testBundle {
    NSBundle *b = [NSBundle ja_bundleWithName:@"example"];
    XCTAssert(b,@"未找到对应bundle");
    UIImage *img = [b ja_imageWithName:@"Action_JSDebug"];
    XCTAssert(img,@"未找到对应图片");
}

- (void)testData {
    NSString *key = @"Apple#$%789";
    NSData *data = [[NSData alloc] initWithBase64EncodedString:@"https://www.google.co.id/search?source=hp&ei=AvkDWtDnCoKlUdf4psAP&btnG=Search&q=iOS11".ja_base64encode options:0];
    NSString *dataString = [NSData ja_convertDataToHex:[data ja_aes256EncryptWithKey:key]];
    NSLog(@"密文:%@",dataString);
    NSString *pureString = [[[NSData ja_convertHexToData:dataString] ja_aes256DecryptWithKey:key] ja_toString];
    NSLog(@"明文:%@",pureString);
    XCTAssert([pureString isEqualToString:@"https://www.google.co.id/search?source=hp&ei=AvkDWtDnCoKlUdf4psAP&btnG=Search&q=iOS11"]);
}

- (void)testURL {
    NSURL *url = [NSURL URLWithString:@"https://www.google.co.id/search?source=hp&ei=AvkDWtDnCoKlUdf4psAP&btnG=Search&q=iOS11"];
    XCTAssert([[[url ja_splitQuery] objectForKey:@"btnG"] isEqualToString:@"Search"]);
}

- (void)testDevice {
    NSLog(@"设备model:%@",[UIDevice ja_model]);
}

- (void)testString {
    NSLog(@"%s",[@"hello" ja_cString]);
    NSLog(@"%@",[NSString ja_ocString:[@"hello" ja_cString]]);
    XCTAssert([[@" hello " ja_trim] isEqualToString:@"hello"]);
    [@"hello world" ja_map:^(NSString *c) {
        NSLog(@"%@",c);
    }];
    NSLog(@"1:%@",[@"hello world" ja_base64encode]);
    NSLog(@"2:%@",[[@"hello world" ja_base64encode] ja_base64decode]);
    NSLog(@"3:%@",[@"hello" ja_md5String]);
    NSLog(@"4:%@",[@"hello" ja_sha1String]);
    NSLog(@"5:%@",[@"hello" ja_sha256String]);
    NSLog(@"6:%@",[@"hello" ja_sha512String]);
}

- (void)testDate {
    NSLog(@"[JA]1:%@",[NSDate ja_dateFromString:@"2017-11-20" format:@"yyyy/MM/dd"]);
    NSLog(@"[JA]2:%@",[NSDate ja_stringFromDate:[NSDate ja_dateFromString:@"2017-11-20" format:@"yyyy/MM/dd"] withDateFormat:@"yyyy/MM/dd"]);
}

- (void)testFileManager {
    NSLog(@"%@",[[NSFileManager defaultManager] ja_documentOfPath]);
    NSLog(@"%@",[[NSFileManager defaultManager] ja_tmpOfPath]);
    NSLog(@"%@",[[NSFileManager defaultManager] ja_cacheOfPath]);
    NSLog(@"%@",[[NSFileManager defaultManager] ja_documentationOfPath]);
    
    NSFileManager *fg = [NSFileManager defaultManager];
    NSString *path = [fg ja_createDirectoryAtCacheWithName:@"test"];
    NSData *data = [[NSData alloc] initWithBase64EncodedString:@"https://www.google.co.id/search?source=hp&ei=AvkDWtDnCoKlUdf4psAP&btnG=Search&q=iOS11".ja_base64encode options:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"helloworld.c"];
    XCTAssert([fg createFileAtPath:filePath contents:data attributes:nil]);
    NSLog(@"所有文件:%@",[NSArray ja_allFilesAtPath:path]);
}

- (void)testNumber {
    NSLog(@"%@",[NSNumber ja_randomNumber:10 to:15]);
    NSLog(@"%@",[NSNumber ja_randomTimestamp:10 to:15]);
    NSNumber *num = [NSNumber ja_notRounding:1.5823 afterPoint:2];
    XCTAssert(num.doubleValue == 1.58);
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
