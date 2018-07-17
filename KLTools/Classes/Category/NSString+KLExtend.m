//
//  NSString+KLExtend.m
//  KLTools
//
//  Created by neville on 2018/6/21.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "NSString+KLExtend.h"

@implementation NSString (KLExtend)

- (CGSize)getSize:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    CGSize size = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size;
}

- (CGSize)getAttributedSize:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace font:(UIFont *)font maxWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpace;
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *dic = @{
                          NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:paraStyle,
                          NSKernAttributeName:@(wordSpace)
                          };
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;
}

@end
