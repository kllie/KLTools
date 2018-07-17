//
//  KLIndexView.h
//  KLTools
//
//  Created by neville on 2018/6/15.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 代理方法 */
@protocol KLIndexViewDelegate <NSObject>

@optional
- (void)tableView:(UITableView *_Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
- (CGFloat)tableView:(UITableView *_Nullable)tableView heightForHeaderInSection:(NSInteger)section;
- (nullable UIView *)tableView:(UITableView *_Nullable)tableView viewForHeaderInSection:(NSInteger)section;

@required
/** 当前选中下标 */
- (void)selectedSectionIndexTitle:(NSString *_Nullable)title atIndex:(NSInteger)index;
/** 添加指示器视图 */
- (void)addIndicatorView:(UIView *_Nullable)view;

@end

/** 数据源方法 */
@protocol KLIndexViewDataSource <NSObject>

@required
- (NSInteger)tableView:(UITableView *_Nullable)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *_Nullable)tableView:(UITableView *_Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
- (NSInteger)numberOfSectionsInTableView:(UITableView *_Nullable)tableView;

/** 组标题数组 */
- (NSArray<NSString *> *_Nullable)sectionIndexTitles;

@end

@interface KLIndexView : UIControl <UITableViewDelegate, UITableViewDataSource, CAAnimationDelegate>

@property (nonatomic, weak, nullable) id<KLIndexViewDelegate> delegate;
@property (nonatomic, weak, nullable) id<KLIndexViewDataSource> dataSource;

/**< 字体大小 */
@property (nonatomic, assign) CGFloat titleFontSize;
/**< 字体颜色 */
@property (nonatomic, strong) UIColor * titleColor;
/**< 选中字体颜色 */
@property (nonatomic, strong) UIColor * selectTitleColor;
/**< 选中背景颜色 */
@property (nonatomic, strong) UIColor * selectBgColor;
/**< 右边距 */
@property (nonatomic, assign) CGFloat marginRight;
/**< 文字间距 */
@property (nonatomic, assign) CGFloat titleSpace;
/**< 指示器视图距离右侧的偏移量 */
@property (nonatomic, assign) CGFloat indicatorMarginRight;
/**< 开启震动反馈 (iOS10及以上) 设置 --> 声音与触感 --> 系统触感反馈打开 */
@property (nonatomic, assign) BOOL vibrationOn;
/**< 开启搜索功能  */
@property (nonatomic, assign) BOOL searchOn;

/** 设置当前选中组 */
- (void)setSelectionIndex:(NSInteger)index;

- (void)reloadData;

@end
