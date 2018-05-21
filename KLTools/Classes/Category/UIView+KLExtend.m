//
//  UIView+KLExtend.m
//  KLTools
//
//  Created by neville on 2018/5/18.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "UIView+KLExtend.h"

@implementation UIView (KLExtend)

- (UIView *(^)(NSArray<UIView *> *))setSubviews {
    
    return ^id (NSArray<UIView *> *views) {
        for (UIView *view in views) {
            [self addSubview:view];
        }
        
        return self;
    };
}

- (UIView *(^)(UIColor *))setBackgroundColor {
    return ^id(UIColor *color) {
        self.backgroundColor = color;
        
        return self;
    };
}

- (UIView *(^)(CGFloat))setRadius {
    return ^id(CGFloat radius) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = radius;
        
        return self;
    };
}

- (UIView *(^)(CGFloat))setBorderWidth {
    return ^id(CGFloat width) {
        self.layer.borderWidth = width;
        
        return self;
    };
}

- (UIView *(^)(UIColor *))setBorderColor {
    return ^id(UIColor *color) {
        self.layer.borderColor = color.CGColor;
        
        return self;
    };
}


- (UIView *(^)(CGFloat))setX {
    return ^id(CGFloat x) {
        self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        
        return self;
    };
}
- (UIView *(^)(CGFloat))setY {
    return ^id(CGFloat y) {
        self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
        
        return self;
    };
}
- (UIView *(^)(CGFloat))setWidth {
    return ^id(CGFloat width) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
        
        return self;
    };
}
- (UIView *(^)(CGFloat))setHeight {
    return ^id(CGFloat height) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
        
        return self;
    };
}

@end
