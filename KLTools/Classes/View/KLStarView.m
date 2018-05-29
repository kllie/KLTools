//
//  KLStarView.m
//  PersonalTrainer
//
//  Created by zhaobinhua on 2018/5/24.
//  Copyright © 2018年 geekeast. All rights reserved.
//

#import "KLStarView.h"

@interface KLStarView ()

@property (nonatomic, assign) CGFloat starWidth;

@end

@implementation KLStarView

#pragma mark - life cycle

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];
}

#pragma mark - init methods

- (void)setupView {
    self.backgroundColor = [UIColor clearColor];
    self.starWidth = 0.0;
    
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.backgroundColor = [UIColor clearColor];
    self.starWidth = rect.size.width / self.starCount;
    for (int i = 0; i < self.starCount; i++) {
        CGRect starRect = CGRectMake(i * self.starWidth, 0, self.starWidth, rect.size.height);
        [self.starImage drawInRect:starRect];
    }
    
    [self.starBackgroundColor set];
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
    
    CGRect newRect = CGRectZero;
    if (self.markType == KLStarTypeInteger) {
        newRect = CGRectMake(0, 0, self.currentIndex * self.starWidth, rect.size.height);
    } else {
        newRect = CGRectMake(0, 0, self.currentPercent * rect.size.width, rect.size.height);
    }
    [self.starFrontColor set];
    UIRectFillUsingBlendMode(newRect, kCGBlendModeSourceIn);
}

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat xPoint = [[touches anyObject] locationInView:self].x;
    if (self.markType == KLStarTypeInteger) {
        if(self.currentIndex == 1) {
            self.currentIndex = roundf(xPoint / self.starWidth);
        } else {
            self.currentIndex = ceilf(xPoint / self.starWidth);
        }
    } else {
        self.currentPercent = xPoint / self.bounds.size.width;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat xPoint = [[touches anyObject] locationInView:self].x;
    if (self.markType == KLStarTypeInteger) {
        if(self.currentIndex == 1) {
            self.currentIndex = roundf(xPoint / self.starWidth);
        } else {
            self.currentIndex = ceilf(xPoint / self.starWidth);
        }
    } else {
        self.currentPercent = xPoint / self.bounds.size.width;
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_delegate && [_delegate respondsToSelector:@selector(didMarkComplete:)]) {
        CGFloat score = 0.0;
        if (self.markType == KLStarTypeInteger) {
            if (self.currentIndex > self.starCount) {
                self.currentIndex = self.starCount;
            }
            self.currentIndex = self.currentIndex > self.starCount ? self.starCount : self.currentIndex;
            score = self.currentIndex * self.totalScore / self.starCount;
        } else {
            self.currentPercent = self.currentPercent > 1. ? 1. : self.currentPercent;
            self.currentPercent = self.currentPercent < 0. ? 0. : self.currentPercent;
            score = self.currentPercent * self.totalScore;
        }
        [_delegate didMarkComplete:score];
    }
    [self setNeedsDisplay];
}

#pragma mark - lazy

- (NSUInteger)starCount {
    if (_starCount <= 0) {
        _starCount = 5;
    }
    return _starCount;
}

- (CGFloat)totalScore {
    if (_totalScore <= 0.001) {
        _totalScore = 10.0;
    }
    return _totalScore;
}

- (UIImage *)starImage {
    if(!_starImage) {
        _starImage = [UIImage imageNamed:@"star"];
    }
    return _starImage;
}

- (UIColor *)starBackgroundColor {
    if(!_starBackgroundColor) {
        _starBackgroundColor = [UIColor whiteColor];
    }
    return _starBackgroundColor;
}

- (UIColor *)starFrontColor {
    if(!_starFrontColor) {
        _starFrontColor = [UIColor orangeColor];
    }
    return _starFrontColor;
}

@end
