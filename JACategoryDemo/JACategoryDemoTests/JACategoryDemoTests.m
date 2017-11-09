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

//- (void)testExample {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//}

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
}

- (void)testURL {
    NSURL *url = [NSURL URLWithString:@"https://www.google.co.id/search?source=hp&ei=AvkDWtDnCoKlUdf4psAP&btnG=Search&q=iOS11"];
    NSLog(@"%@",[url ja_splitQuery]);    
}

- (void)testString {
    NSLog(@"设备model:%@",[UIDevice ja_model]);
    
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
