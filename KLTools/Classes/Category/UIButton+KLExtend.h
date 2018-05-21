//
//  UIButton+KLExtend.h
//  KLTools
//
//  Created by neville on 2018/5/18.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (KLExtend)

/**
 Set the button title in normal
 */
- (UIButton *(^)(NSString *))setTitle;

/**
 Set the button title in selected
 */
- (UIButton *(^)(NSString *))setSelectedTitle;

/**
 Set the button title in disabled
 */
- (UIButton *(^)(NSString *))setDisabledTitle;

/**
 Set the button title in highlighted
 */
- (UIButton *(^)(NSString *))setHighlightedTitle;

/**
 Set the button title color in normal
 */
- (UIButton *(^)(UIColor *))setTitleColor;

/**
 Set the button title color in selected
 */
- (UIButton *(^)(UIColor *))setSelectedTitleColor;

/**
 Set the button title color in Disabled
 */
- (UIButton *(^)(UIColor *))setDisabledTitleColor;

/**
 Set the button title color in Highlighted
 */
- (UIButton *(^)(UIColor *))setHighlightedTitleColor;

/**
 Set the button image in normal
 */
- (UIButton *(^)(UIImage *))setNormalImage;

/**
 Set the button image in selected
 */
- (UIButton *(^)(UIImage *))setSelectedImage;

/**
 Set the button image in disabled
 */
- (UIButton *(^)(UIImage *))setDisabledImage;

/**
 Set the button image in highlighted
 */
- (UIButton *(^)(UIImage *))setHighlightedImage;

/**
 Set the button background image in normal
 */
- (UIButton *(^)(UIImage *))setNormalBackgroundImage;

/**
 Set the button background image in selected
 */
- (UIButton *(^)(UIImage *))setSelectedBackgroundImage;

/**
 Set the button background image in disabled
 */
- (UIButton *(^)(UIImage *))setDisabledBackgroundImage;

/**
 Set the button background image in highlighted
 */
- (UIButton *(^)(UIImage *))setHighlightedBackgroundImage;

/**
 Set the button title font
 */
- (UIButton *(^)(UIFont *))setFont;

@end
