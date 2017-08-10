//
//  UIImageView+JACoder.m
//  MStarReader
//
//  Created by Jason on 07/07/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "UIImageView+JACoder.h"

@implementation UIImageView (JACoder)
- (void)addShadow {
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1, 3);
    self.layer.shadowOpacity = 1.0;
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = false;
}
@end
