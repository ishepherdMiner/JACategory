//
//  NSURL+JACoder.m
//  Daily_modules
//
//  Created by Jason on 06/04/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "NSURL+JACoder.h"

@implementation NSURL (JACoder)

- (NSDictionary *)ja_queryPairs {
    if (self.query) {
        NSArray *qS = [self.query componentsSeparatedByString:@"&"];
        
        NSMutableDictionary *qSDicM = [NSMutableDictionary dictionaryWithCapacity:qS.count];
        [qS enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *paramPair = [obj componentsSeparatedByString:@"="];
            [qSDicM setObject:paramPair.lastObject forKey:paramPair.firstObject];
        }];
        return [qSDicM copy];
    }else {
        return nil;
    }
}

@end
