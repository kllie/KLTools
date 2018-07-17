//
//  UIView+KLExtend.h
//  KLTools
//
//  Created by neville on 2018/5/18.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+KLFrame.h"
#import "UILabel+KLExtend.h"
#import "UIButton+KLExtend.h"
#import "UITextField+KLExtend.h"
#import "UIColor+KLExtend.h"
#import "UIImage+KLExtend.h"
#import "NSString+KLExtend.h"

@interface UIView (KLExtend)

/**
 Set view subviews
 */
- (UIView *(^)(NSArray<UIView *> *))setSubviews;

/**
 Set view background color
 */
- (UIView *(^)(UIColor *))setBackgroundColor;

/**
 Set view radius
 */
- (UIView *(^)(CGFloat))setRadius;

/**
 Set view borderline color
 */
- (UIView *(^)(UIColor *))setBorderColor;

/**
 Set view borderline width
 */
- (UIView *(^)(CGFloat))setBorderWidth;

/**
 Set view frame origin x
 */
- (UIView *(^)(CGFloat))setX;

/**
 Set view frame origin y
 */
- (UIView *(^)(CGFloat))setY;

/**
 Set view frame size width
 */
- (UIView *(^)(CGFloat))setWidth;

/**
 Set view frame size height
 */
- (UIView *(^)(CGFloat))setHeight;



@end
