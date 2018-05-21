//
//  UIButton+KLExtend.m
//  KLTools
//
//  Created by neville on 2018/5/18.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "UIButton+KLExtend.h"

@implementation UIButton (KLExtend)

- (UIButton *(^)(NSString *))setTitle {
    return ^id(NSString *title) {
        [self setTitle:title forState:UIControlStateNormal];
        
        return self;
    };
}

- (UIButton *(^)(NSString *))setSelectedTitle {
    return ^id(NSString *title) {
        [self setTitle:title forState:UIControlStateSelected];
        
        return self;
    };
}

- (UIButton *(^)(NSString *))setDisabledTitle {
    return ^id(NSString *title) {
        [self setTitle:title forState:UIControlStateDisabled];
        
        return self;
    };
}

- (UIButton *(^)(NSString *))setHighlightedTitle {
    return ^id(NSString *title) {
        [self setTitle:title forState:UIControlStateHighlighted];
        
        return self;
    };
}

- (UIButton *(^)(UIColor *))setTitleColor {
    return ^id(UIColor *color) {
        [self setTitleColor:color forState:UIControlStateNormal];
        
        return self;
    };
}

- (UIButton *(^)(UIColor *))setSelectedTitleColor {
    return ^id(UIColor *color) {
        [self setTitleColor:color forState:UIControlStateSelected];
        
        return self;
    };
}

- (UIButton *(^)(UIColor *))setDisabledTitleColor {
    return ^id(UIColor *color) {
        [self setTitleColor:color forState:UIControlStateDisabled];
        
        return self;
    };
}

- (UIButton *(^)(UIColor *))setHighlightedTitleColor {
    return ^id(UIColor *color) {
        [self setTitleColor:color forState:UIControlStateHighlighted];
        
        return self;
    };
}

- (UIButton *(^)(UIImage *))setNormalImage {
    return ^id(UIImage *image) {
        [self setImage:image forState:UIControlStateNormal];
        
        return self;
    };
}

- (UIButton *(^)(UIImage *))setSelectedImage {
    return ^id(UIImage *image) {
        [self setImage:image forState:UIControlStateSelected];
        
        return self;
    };
}

- (UIButton *(^)(UIImage *))setDisabledImage {
    return ^id(UIImage *image) {
        [self setImage:image forState:UIControlStateDisabled];
        
        return self;
    };
}

- (UIButton *(^)(UIImage *))setHighlightedImage {
    return ^id(UIImage *image) {
        [self setImage:image forState:UIControlStateHighlighted];
        
        return self;
    };
}

- (UIButton *(^)(UIImage *))setNormalBackgroundImage {
    return ^id(UIImage *image) {
        [self setBackgroundImage:image forState:UIControlStateNormal];
        
        return self;
    };
}

- (UIButton *(^)(UIImage *))setSelectedBackgroundImage {
    return ^id(UIImage *image) {
        [self setBackgroundImage:image forState:UIControlStateSelected];
        
        return self;
    };
}

- (UIButton *(^)(UIImage *))setDisabledBackgroundImage {
    return ^id(UIImage *image) {
        [self setBackgroundImage:image forState:UIControlStateDisabled];
        
        return self;
    };
}

- (UIButton *(^)(UIImage *))setHighlightedBackgroundImage {
    return ^id(UIImage *image) {
        [self setBackgroundImage:image forState:UIControlStateHighlighted];
        
        return self;
    };
}

- (UIButton *(^)(UIFont *))setFont {
    return ^id(UIFont *font) {
        self.titleLabel.font = font;
        
        return self;
    };
}

@end
