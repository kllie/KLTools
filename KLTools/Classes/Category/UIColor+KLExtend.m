//
//  UIColor+KLExtend.m
//  KLTools
//
//  Created by neville on 2018/5/18.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "UIColor+KLExtend.h"

@implementation UIColor (KLExtend)

+ (UIColor *)colorWithHexRGB:(NSString *)hex {
    return [self colorWithHexRGB:hex alpha:1.0];
}

+ (UIColor *)colorWithHexRGB:(NSString *)hex alpha:(float)alpha {
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (hex != nil) {
        NSScanner *scanner = [NSScanner scannerWithString:hex];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:alpha];
    return result;
}

- (UIImage *)imageWithColor {
    CGSize size = CGSizeMake(1.0f, 1.0f);
    return [self imageWithColor:size];
}

- (UIImage *)imageWithColor:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
