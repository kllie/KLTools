//
//  UILabel+KLExtend.m
//  KLTools
//
//  Created by neville on 2018/5/18.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "UILabel+KLExtend.h"

@implementation UILabel (KLExtend)

- (UILabel *(^)(NSString *))setText {
    return ^id(NSString *text) {
        self.text = text;
        
        return self;
    };
}
- (UILabel *(^)(UIColor *))setTextColor {
    return ^id(UIColor *color) {
        self.textColor = color;
        
        return self;
    };
}

- (UILabel *(^)(UIFont *))setFont {
    return ^id(UIFont *font) {
        self.font = font;
        
        return self;
    };
}
- (UILabel *(^)(NSTextAlignment))setTextAlignment {
    return ^id(NSTextAlignment alignment) {
        self.textAlignment = alignment;
        
        return self;
    };
}

@end
