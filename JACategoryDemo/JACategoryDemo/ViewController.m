//
//  ViewController.m
//  JACategoryDemo
//
//  Created by Jason on 10/08/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "ViewController.h"
#import <JACategory/JACategory.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self urlSplit];
}

- (void)urlSplit {
    NSURL *url = [NSURL URLWithString:@"https://www.google.co.id/search?source=hp&ei=AvkDWtDnCoKlUdf4psAP&btnG=Search&q=iOS11"];
    NSLog(@"%@",[url ja_splitQuery]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
