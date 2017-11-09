//
//  ViewController.m
//  JACategoryDemo
//
//  Created by Jason on 10/08/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "ViewController.h"
#import <JACategory.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self aes256];
    [self urlSplit];
}

- (void)aes256 {
    NSString *key = @"Apple#$%789";
    NSData *data = [[NSData alloc] initWithBase64EncodedString:@"https://www.google.co.id/search?source=hp&ei=AvkDWtDnCoKlUdf4psAP&btnG=Search&q=iOS11".ja_base64encode options:0];
    NSString *dataString = [NSData ja_convertDataToHex:[data ja_aes256EncryptWithKey:key]];
    NSLog(@"密文:%@",dataString);
    NSString *pureString = [[[NSData ja_convertHexToData:dataString] ja_aes256DecryptWithKey:key] ja_toString];
    NSLog(@"明文:%@",pureString);
}

- (void)urlSplit {
    NSURL *url = [NSURL URLWithString:@"https://www.google.co.id/search?source=hp&ei=AvkDWtDnCoKlUdf4psAP&btnG=Search&q=iOS11"];
    NSLog(@"%@",[url ja_splitQuery]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
