//
//  UITextField+KLExtend.m
//  KLTools
//
//  Created by neville on 2018/5/18.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "UITextField+KLExtend.h"

@implementation UITextField (KLExtend)

- (UITextField *(^)(NSString *))setText {
    return ^id(NSString *text) {
        self.text = text;
        
        return self;
    };
}
- (UITextField *(^)(UIColor *))setTextColor {
    return ^id(UIColor *color) {
        self.textColor = color;
        
        return self;
    };
}
- (UITextField *(^)(UIFont *))setFont {
    return ^id(UIFont *font) {
        self.font = font;
        
        return self;
    };
}
- (UITextField *(^)(NSString *))setPlaceholder {
    return ^id(NSString *placeholder) {
        self.placeholder = placeholder;
        
        return self;
    };
}

@end
