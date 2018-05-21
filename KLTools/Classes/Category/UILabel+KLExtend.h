//
//  UILabel+KLExtend.h
//  KLTools
//
//  Created by neville on 2018/5/18.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (KLExtend)

/**
 Set the label text
 */
- (UILabel *(^)(NSString *))setText;

/**
 Set the label text color
 */
- (UILabel *(^)(UIColor *))setTextColor;

/**
 Set the label text font
 */
- (UILabel *(^)(UIFont *))setFont;

/**
 Set the label text alignment type
 */
- (UILabel *(^)(NSTextAlignment))setTextAlignment;

@end
