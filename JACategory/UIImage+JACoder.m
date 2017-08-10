//
//  UIImage+JACoder.m
//  Daily_modules
//
//  Created by Jason on 12/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "UIImage+JACoder.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (JACoder)

- (UIImage *)ja_cropImageWithSize:(CGSize)size {
    CGFloat WH = MIN(size.width, size.height);
    CGRect rect = CGRectMake(0, 0, WH, WH);
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    [self drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)ja_imageWithCorner:(CGFloat)corner{
    CGFloat WH = MIN(self.size.width, self.size.height);
    CGRect rect = CGRectMake(0, 0, WH, WH);
    UIGraphicsBeginImageContextWithOptions(self.size, false, 0);
    UIBezierPath *path = nil;
    if (corner < WH * 0.5) {
        path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:corner];
    }else {
        path = [UIBezierPath bezierPathWithOvalInRect:rect];
    }
    [path addClip];
    [self drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (instancetype)ja_imageWithUIColor:(UIColor *)color size:(CGSize)size{
    return [self ja_imageWithCGColor:color.CGColor size:size];
}
+ (instancetype)ja_imageWithCGColor:(CGColorRef)colorref size:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, colorref);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 按给定的方向旋转图片 */
- (UIImage*)ja_rotate:(UIImageOrientation)orient
{
    CGRect bnds = CGRectZero;
    UIImage* copy = nil;
    CGContextRef ctxt = nil;
    CGImageRef imag = self.CGImage;
    CGRect rect = CGRectZero;
    CGAffineTransform tran = CGAffineTransformIdentity;
    
    rect.size.width = CGImageGetWidth(imag);
    rect.size.height = CGImageGetHeight(imag);
    
    bnds = rect;
    
    switch (orient)
    {
        case UIImageOrientationUp:
            return self;
            
        case UIImageOrientationUpMirrored:
            tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            tran = CGAffineTransformMakeTranslation(rect.size.width,
                                                    rect.size.height);
            tran = CGAffineTransformRotate(tran, M_PI);
            break;
            
        case UIImageOrientationDownMirrored:
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            tran = CGAffineTransformScale(tran, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeft:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeftMirrored:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(rect.size.height,
                                                    rect.size.width);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRight:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeScale(-1.0, 1.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
            break;
            
        default:
            return self;
    }
    
    UIGraphicsBeginImageContext(bnds.size);
    ctxt = UIGraphicsGetCurrentContext();
    
    switch (orient)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(ctxt, -1.0, 1.0);
            CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
            break;
            
        default:
            CGContextScaleCTM(ctxt, 1.0, -1.0);
            CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
            break;
    }
    
    CGContextConcatCTM(ctxt, tran);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, imag);
    
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copy;
}

/** 交换宽和高 */
static CGRect swapWidthAndHeight(CGRect rect)
{
    CGFloat swap = rect.size.width;
    
    rect.size.width = rect.size.height;
    rect.size.height = swap;
    
    return rect;
}


+ (UIImage *)ja_animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
#if SD_MAC
    return [[UIImage alloc] initWithData:data];
#endif
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *staticImage;
    
    if (count <= 1) {
        staticImage = [[UIImage alloc] initWithData:data];
    } else {
        // we will only retrieve the 1st frame. the full GIF support is available via the FLAnimatedImageView category.
        // this here is only code to allow drawing animated images as static ones

        CGFloat scale = 1;
        scale = [UIScreen mainScreen].scale;
        
        CGImageRef CGImage = CGImageSourceCreateImageAtIndex(source, 0, NULL);
        UIImage *frameImage = [UIImage imageWithCGImage:CGImage scale:scale orientation:UIImageOrientationUp];
        staticImage = [UIImage animatedImageWithImages:@[frameImage] duration:0.0f];
        CGImageRelease(CGImage);
    }
    
    CFRelease(source);
    
    return staticImage;
}

@end
