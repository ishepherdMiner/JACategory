//
//  UIResponder+JACoder.m
//  AFNetworking
//
//  Created by HZ-Jason on 02/08/2018.
//

#import "UIResponder+JACoder.h"

static __weak id currentFirstResponder;

@implementation UIResponder (JACoder)

+ (id)ja_currentFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}

- (void)findFirstResponder:(id)sender {
    currentFirstResponder = self;
}

@end
