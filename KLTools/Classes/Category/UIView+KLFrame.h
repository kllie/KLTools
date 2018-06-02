//
//  UIView+KLFrame.h
//  KLTools
//
//  Created by neville on 2018/5/18.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KLFrame)

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@end
