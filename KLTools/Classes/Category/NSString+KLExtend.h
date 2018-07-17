//
//  NSString+KLExtend.h
//  KLTools
//
//  Created by neville on 2018/6/21.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (KLExtend)

/**
 获取文本size
 */
- (CGSize)getSize:(UIFont *)font maxWidth:(CGFloat)maxWidth;

/**
 获取富文本size
 */
- (CGSize)getAttributedSize:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace font:(UIFont *)font maxWidth:(CGFloat)width;

@end
