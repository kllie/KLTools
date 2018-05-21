//
//  UIColor+KLExtend.h
//  KLTools
//
//  Created by neville on 2018/5/18.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (KLExtend)

/**
 生成颜色 - hex值

 @param hex hex值
 */
+ (UIColor *)colorWithHexRGB:(NSString *)hex;

#pragma mark - 生成Image

- (UIImage *)imageWithColor;
- (UIImage *)imageWithColor:(CGSize)size;

@end
