//
//  UIView+JACoder.m
//  Daily_modules
//
//  Created by Jason on 09/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "UIView+JACoder.h"
#import <objc/message.h>
#import <QuartzCore/QuartzCore.h>

@implementation UIView (JACoder)

+ (instancetype)ja_builder:(void (^)(UIView * _Nonnull make))block {
    UIView *instance = [[self alloc] init];
    block(instance);
    return instance;
}

- (instancetype)ja_builder:(void (^)(UIView * _Nonnull make))block {
    block(self);
    return self;
}

- (UIView*)ja_findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse{
    for( UIView* subview in self.subviews ) {
        BOOL stop = true;
        if(recurse(subview,&stop)) {
            return [subview ja_findViewRecursively:recurse];
        } else if( stop ) {
            return subview;
        }
    }    
    return nil;
}

- (CGFloat)ja_width {
    return self.frame.size.width;
}

- (CGFloat)ja_height {
    return self.frame.size.height;
}

- (CGFloat)ja_x {
    return self.frame.origin.x;
}

- (CGFloat)ja_y {
    return self.frame.origin.y;
}

- (void)setJa_y:(CGFloat)y {
    CGRect r = self.frame;
    r.origin.y = y;
    self.frame = r;
}

- (void)setJa_x:(CGFloat)x {
    CGRect r = self.frame;
    r.origin.x = x;
    self.frame = r;
}

- (void)setJa_width:(CGFloat)width {
    CGRect r = self.frame;
    r.size.width = width;
    self.frame = r;
}

- (void)setJa_height:(CGFloat)height {
    CGRect r = self.frame;
    r.size.height = height;
    self.frame = r;
}

- (CGFloat)ja_centerX {
    return self.center.x;
}

- (CGFloat)ja_centerY {
    return self.center.y;
}

- (void)setJa_centerX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setJa_centerY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

/** 
 * 水平居中 
 */
- (void)ja_alignHor{
    self.ja_x = (self.superview.ja_width - self.ja_width) * 0.5;
}

/** 
 * 垂直居中 
 */
- (void)ja_alignVer{
    self.ja_y = (self.superview.ja_height - self.ja_height) * 0.5;
}

/**
 通过响应者链条获取view所在的控制器
 
 @return view所在的控制器
 */
- (UIViewController *)ja_parentController{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

- (instancetype)ja_placeholder {
    if ([self isKindOfClass:[UILabel class]]) {
        [(UILabel *)self setTextColor:[UIColor clearColor]];
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return self;
}

- (void)ja_drawCircleWithColor:(UIColor *)color
                         width:(CGFloat)width {
    
    CGFloat min = MIN(self.bounds.size.width, self.bounds.size.height);
    self.layer.cornerRadius = min * 0.5;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
    [self setNeedsDisplay];
}

@end

#define kShadowViewTag 2132
#define kValidDirections [NSArray arrayWithObjects: @"top", @"bottom", @"left", @"right",nil]

@implementation UIView (Shadow)

- (void)makeInsetShadow
{
    NSArray *shadowDirections = [NSArray arrayWithObjects:@"top", @"bottom", @"left" , @"right" , nil];
    UIColor *color = [UIColor colorWithRed:(0.0) green:(0.0) blue:(0.0) alpha:0.5];
    
    UIView *shadowView = [self createShadowViewWithRadius:3 Color:color Directions:shadowDirections];
    shadowView.tag = kShadowViewTag;
    
    [self addSubview:shadowView];
}

- (void)makeInsetShadowWithRadius:(float)radius Alpha:(float)alpha
{
    NSArray *shadowDirections = [NSArray arrayWithObjects:@"top", @"bottom", @"left" , @"right" , nil];
    UIColor *color = [UIColor colorWithRed:(0.0) green:(0.0) blue:(0.0) alpha:alpha];
    
    UIView *shadowView = [self createShadowViewWithRadius:radius Color:color Directions:shadowDirections];
    shadowView.tag = kShadowViewTag;
    
    [self addSubview:shadowView];
}

- (void)makeInsetShadowWithRadius:(float)radius Color:(UIColor *)color Directions:(NSArray *)directions
{
    UIView *shadowView = [self createShadowViewWithRadius:radius Color:color Directions:directions];
    shadowView.tag = kShadowViewTag;
    
    [self addSubview:shadowView];
}

- (UIView *)createShadowViewWithRadius:(float)radius Color:(UIColor *)color Directions:(NSArray *)directions
{
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    shadowView.backgroundColor = [UIColor clearColor];
    
    // Ignore duplicate direction
    NSMutableDictionary *directionDict = [[NSMutableDictionary alloc] init];
    for (NSString *direction in directions) [directionDict setObject:@"1" forKey:direction];
    
    for (NSString *direction in directionDict) {
        // Ignore invalid direction
        if ([kValidDirections containsObject:direction])
        {
            CAGradientLayer *shadow = [CAGradientLayer layer];
            
            if ([direction isEqualToString:@"top"]) {
                [shadow setStartPoint:CGPointMake(0.5, 0.0)];
                [shadow setEndPoint:CGPointMake(0.5, 1.0)];
                shadow.frame = CGRectMake(0, 0, self.bounds.size.width, radius);
            }
            else if ([direction isEqualToString:@"bottom"])
            {
                [shadow setStartPoint:CGPointMake(0.5, 1.0)];
                [shadow setEndPoint:CGPointMake(0.5, 0.0)];
                shadow.frame = CGRectMake(0, self.bounds.size.height - radius, self.bounds.size.width, radius);
            } else if ([direction isEqualToString:@"left"])
            {
                shadow.frame = CGRectMake(0, 0, radius, self.bounds.size.height);
                [shadow setStartPoint:CGPointMake(0.0, 0.5)];
                [shadow setEndPoint:CGPointMake(1.0, 0.5)];
            } else if ([direction isEqualToString:@"right"])
            {
                shadow.frame = CGRectMake(self.bounds.size.width - radius, 0, radius, self.bounds.size.height);
                [shadow setStartPoint:CGPointMake(1.0, 0.5)];
                [shadow setEndPoint:CGPointMake(0.0, 0.5)];
            }
            
            shadow.colors = [NSArray arrayWithObjects:(id)[color CGColor], (id)[[UIColor clearColor] CGColor], nil];
            [shadowView.layer insertSublayer:shadow atIndex:0];
        }
    }
    
    return shadowView;
}



@end
