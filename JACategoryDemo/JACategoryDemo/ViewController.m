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
    
    [NSObject ja_getAllClasses];
    id obj1 = NSClassFromString(@"PodsDummy_JACategory");
    id obj2 = NSClassFromString(@"PodsDummy_Pods_JACategoryDemo");
    NSLog(@"%@,%@",obj1,obj2);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
