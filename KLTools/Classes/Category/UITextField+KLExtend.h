//
//  UITextField+KLExtend.h
//  KLTools
//
//  Created by neville on 2018/5/18.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (KLExtend)

/**
 set the textField text
 */
- (UITextField *(^)(NSString *))setText;

/**
 set the textField text color
 */
- (UITextField *(^)(UIColor *))setTextColor;

/**
 set the textField text font
 */
- (UITextField *(^)(UIFont *))setFont;

/**
 set the textField placeholder text
 */
- (UITextField *(^)(NSString *))setPlaceholder;

@end
