//
//  KLStarView.h
//  PersonalTrainer
//
//  Created by zhaobinhua on 2018/5/24.
//  Copyright © 2018年 geekeast. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 打分方式

 - KLStarTypeInteger: 整数
 - KLStarTypeDecimal: 小数
 */
typedef NS_ENUM(NSUInteger, KLStarType) {
    KLStarTypeInteger,
    KLStarTypeDecimal
};

@protocol KLStarViewDelegate <NSObject>

- (void)didMarkComplete:(CGFloat)score;

@end

@interface KLStarView : UIView

@property (nonatomic, assign) NSUInteger starCount;         //星星数量（默认5）

@property (nonatomic, assign) CGFloat totalScore;           //总分数（默认10）

@property (nonatomic, strong) UIImage *starImage;           //星星图片

@property (nonatomic, strong) UIColor *starFrontColor;      //打分后的颜色（默认orangeColor）

@property (nonatomic, strong) UIColor *starBackgroundColor; //星星背景颜色（默认whiteColor）

@property (nonatomic, assign) NSUInteger currentIndex;      //当前星星位置(在EMarkTypeInteger模式下使用）范围[1 - starCount]

@property (nonatomic, assign) CGFloat currentPercent;       //在EMarkTypeDecimal模式下使用范围[0.-1.]

@property (nonatomic, assign) KLStarType markType;          //打分类型

@property (nonatomic, weak) id<KLStarViewDelegate> delegate;

@end
