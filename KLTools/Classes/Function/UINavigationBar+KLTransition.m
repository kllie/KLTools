//
//  UINavigationBar+KLTransition.m
//  KLTools
//
//  Created by neville on 2018/5/18.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "UINavigationBar+KLTransition.h"
#import <objc/runtime.h>

static NSString *const kc_backgroundViewKey = @"kc_backgroundView";

@implementation UINavigationBar (KLTransition)

- (UIView *)kc_backgroundView {
    UIView *view = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kc_backgroundViewKey));
    
    if (!view) {
        view = [UIView new];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIView *backgroundView = [self valueForKey:@"backgroundView"];
        
        [self insertSubview:view aboveSubview:backgroundView];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        
        objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(kc_backgroundViewKey), view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (void)setKc_backgroundAlpha:(CGFloat)kc_backgroundAlpha {
    UIView *backgroundView = [self valueForKey:@"backgroundView"];
    UIView *shadowView = [backgroundView valueForKey:@"shadowView"];
    shadowView.alpha = kc_backgroundAlpha;
    shadowView.hidden = kc_backgroundAlpha == 0;
    
    [self kc_backgroundView].alpha = kc_backgroundAlpha;
    if (self.isTranslucent) {
        if (@available(iOS 10.0, *)) {
            if (![self backgroundImageForBarMetrics:UIBarMetricsDefault]) {
                UIView *backgroundEffectView = [backgroundView valueForKey:@"backgroundEffectView"];
                backgroundEffectView.alpha = kc_backgroundAlpha;
                return;
            }
        } else {
            UIView *adaptiveBackdrop = [backgroundView valueForKey:@"adaptiveBackdrop"];
            UIView *backdropEffectView = [adaptiveBackdrop valueForKey:@"backdropEffectView"];
            backdropEffectView.alpha = kc_backgroundAlpha;

            return;
        }
    }
    backgroundView.alpha = kc_backgroundAlpha;
}

- (CGFloat)kc_backgroundAlpha {
    UIView *backgroundView = [self valueForKey:@"backgroundView"];
    return backgroundView.alpha;
}

- (void)setKc_backgroundColor:(UIColor *)kc_backgroundColor {
    [self kc_backgroundView].backgroundColor = kc_backgroundColor;
}

- (UIColor *)kc_backgroundColor {
    return [self kc_backgroundView].backgroundColor;
}

@end
