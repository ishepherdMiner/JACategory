//
//  NSURL+JACoder.h
//  Daily_modules
//
//  Created by Jason on 06/04/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (JACoder)

/**
 *  分割URL,得到参数字典
 *
 *  @return URL的参数字典
 */
- (NSDictionary *)ja_queryPairs;

@end

NS_ASSUME_NONNULL_END
