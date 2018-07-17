//
//  KLIndexView.m
//  KLTools
//
//  Created by neville on 2018/6/15.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "KLIndexView.h"
#import "KLIndicatorView.h"

#import <AudioToolbox/AudioToolbox.h>

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

API_AVAILABLE(ios(10.0))
@interface KLIndexView ()

@property (nonatomic, strong) KLIndicatorView *indicatorView;
/**< 组标题数组 */
@property (nonatomic, copy) NSArray<NSString *> *indexItems;
/**< 标题视图数组 */
@property (nonatomic, strong) NSMutableArray<UILabel *> *itemsViewArray;
/**< 当前选中下标 */
@property (nonatomic, assign) NSInteger selectedIndex;
/**< Y坐标最小值 */
@property (nonatomic, assign) CGFloat minY;
/**< Y坐标最大值 */
@property (nonatomic, assign) CGFloat maxY;
/**< item大小，参照W大小设置 */
@property (nonatomic, assign) CGSize itemMaxSize;
/**< 当前选中item的背景圆 */
@property (nonatomic, strong) UIImageView *selectedImageView;
/**< 是否需要调用代理方法，如果是scrollView自带的滚动，则不需要触发代理方法，如果是滑动指示器视图，则触发代理方法 */
@property (nonatomic, assign) BOOL isCallback;
/**< 是否显示指示器，只有触摸标题，才显示指示器 */
@property (nonatomic, assign) BOOL isShowIndicator;
/**< 是否在进行动画 */
@property (nonatomic, assign) BOOL isAnimating;
/**< 是否是上拉滚动 */
@property (nonatomic, assign) BOOL isUpScroll;
/**< 是否第一次加载tableView */
@property (nonatomic, assign) BOOL isFirstLoad;
/**< 滚动的偏移量 */
@property (nonatomic, assign) CGFloat oldY;
/**< 是否允许改变当前组 */
@property (nonatomic, assign) BOOL isAllowedChange;
/**< 震动反馈  */
@property (nonatomic, strong) UIImpactFeedbackGenerator *generator;

@end

@implementation KLIndexView

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [self.dataSource numberOfSectionsInTableView:tableView];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [self.dataSource tableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [self.delegate tableView:tableView heightForHeaderInSection:section];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.delegate tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (self.isAllowedChange && !self.isUpScroll && !self.isFirstLoad) {
        // 最上面组头（不一定是第一个组头，指最近刚被顶出去的组头）又被拉回来
        [self setSelectionIndex:section];  //section
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (self.isAllowedChange && !self.isFirstLoad && self.isUpScroll) {
        // 最上面的组头被顶出去
        [self setSelectionIndex:section + 1]; //section + 1
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > self.oldY) {
        self.isUpScroll = YES;      // 上滑
    }
    else {
        self.isUpScroll = NO;       // 下滑
    }
    self.isFirstLoad = NO;
    
    self.oldY = scrollView.contentOffset.y;
}

#pragma mark - ----------------------具体实现----------------------

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
        [self initializeAllTitles];
    }
    return self;
}

- (void)initialize {
    self.isShowIndicator = NO;
    // 默认就允许滚动改变组
    self.isAllowedChange = YES;
    
    self.isFirstLoad = YES;
    // 观察当前index
    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    // 初始化属性设置
    [self attributeSettings];
}

#pragma mark - 初始化属性设置

- (void)attributeSettings {
    //文字大小
    if (self.titleFontSize == 0) {
        self.titleFontSize = 10;
    }
    //字体颜色
    if (!self.titleColor) {
        self.titleColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.f];
    }
    //选中字体颜色
    if (!self.selectTitleColor) {
        self.selectTitleColor = [UIColor whiteColor];
    }
    //选中背景颜色
    if (!self.selectBgColor) {
        self.selectBgColor = [UIColor redColor];
    }
    //右边距
    if (self.marginRight == 0) {
        self.marginRight = 7;
    }
    //文字间距
    if (self.titleSpace == 0) {
        self.titleSpace = 4;
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"selectedIndex"];
    self.generator = nil;
}

#pragma mark - Public Methods

- (void)setSelectionIndex:(NSInteger)index {
    if (index >= 0 && index <= self.indexItems.count) {
        // 改变组下标
        self.isCallback = NO;
        self.selectedIndex = index;
    }
}

- (void)reloadData {
    [self initializeAllTitles];
}

#pragma mark - 初始化title

- (void)initializeAllTitles {
    // 获取标题组
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(sectionIndexTitles)]) {
        self.indexItems = [self.dataSource sectionIndexTitles];
        if (self.indexItems.count == 0) {
            return;
        }
    } else {
        return;
    }
    
    // 移除所有的自视图
    for (UIView *viewType in self.subviews) {
        if ([viewType isKindOfClass:[UILabel class]]) {
            [viewType removeFromSuperview];
        }
    }
    //高度是否符合
    CGFloat totalHeight = (self.indexItems.count * self.titleFontSize) + ((self.indexItems.count + 1) * self.titleSpace);
    if (CGRectGetHeight(self.frame) < totalHeight) {
        return;
    }
    //宽度是否符合
    CGFloat totalWidth = self.titleFontSize + self.marginRight;
    if (CGRectGetWidth(self.frame) < totalWidth) {
        return;
    }
    //设置Y坐标最小值
    self.minY = (CGRectGetHeight(self.frame) - totalHeight) / 2.0;
    CGFloat startY = self.minY  + self.titleSpace;
    //以 'W' 字母为标准作为其他字母的标准宽高
    self.itemMaxSize = [@"W" boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:self.titleFontSize]} context:nil].size;
    // 标题视图布局
    for (int i = 0; i < self.indexItems.count; i++) {
        NSString *title = self.indexItems[i];
        UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - self.marginRight - self.titleFontSize, startY, self.itemMaxSize.width, self.itemMaxSize.height)];
        
        //是否有搜索
        if ([title isEqualToString:UITableViewIndexSearch]) {
            itemLabel.text = nil;
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            //定义图片内容及位置和大小
            attch.image = [UIImage imageNamed:@"KLResource.bundle/index_search"];
            attch.bounds = CGRectMake(0, 0, self.itemMaxSize.height - 2, self.itemMaxSize.height - 2);
            NSAttributedString *attri = [NSAttributedString attributedStringWithAttachment:attch];
            itemLabel.attributedText = attri;
        } else {
            itemLabel.font = [UIFont boldSystemFontOfSize:self.titleFontSize];
            itemLabel.textColor = self.titleColor;
            itemLabel.text = title;
            itemLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        [self.itemsViewArray addObject:itemLabel];
        [self addSubview:itemLabel];
        [self insertSubview:itemLabel aboveSubview:self.selectedImageView];
        //重新计算start Y
        startY = startY + self.itemMaxSize.height + self.titleSpace;
    }
    //设置Y坐标最大值
    self.maxY = startY;
}

#pragma mark - KVO监听当前选中下标

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    // 下标
    NSInteger newIndex = [[change objectForKey:@"new"] integerValue];
    NSInteger oldIndex = [[change objectForKey:@"old"] integerValue];
    // 处理新旧item
    if (oldIndex >= 0 && oldIndex < self.itemsViewArray.count) {
        UILabel *oldItemLabel = self.itemsViewArray[oldIndex];
        oldItemLabel.textColor = self.titleColor;
        self.selectedImageView.frame = CGRectZero;
    }
    if (newIndex >= 0 && newIndex < self.itemsViewArray.count) {
        UILabel *newItemLabel = self.itemsViewArray[newIndex];
        newItemLabel.textColor = self.selectTitleColor;
        // 处理选中圆形
        BOOL isLetter = NO;
        if (newItemLabel.text.length > 0) {
            // 判断特殊字符
            NSString *firstString = [newItemLabel.text substringWithRange:NSMakeRange(0, 1)];
            // 判断是否是字母
            unichar firstLetter = [newItemLabel.text characterAtIndex:0];
            if ((firstLetter >= 'a' && firstLetter <= 'z') || (firstLetter >= 'A' && firstLetter <= 'Z') || firstLetter == '#' || [firstString isEqualToString:@"★"]) {
                CGFloat diameter = ((self.itemMaxSize.width > self.itemMaxSize.height) ? self.itemMaxSize.width:self.itemMaxSize.height) + self.titleSpace;
                self.selectedImageView.frame = CGRectMake(0, 0, diameter, diameter);
                self.selectedImageView.center = newItemLabel.center;
                self.selectedImageView.layer.mask = [self imageMaskLayer:self.selectedImageView.bounds radiu:diameter/2.0];
                [self insertSubview:self.selectedImageView belowSubview:newItemLabel];
                
                isLetter = YES;
            }
        }
        
        //回调代理方法
        if (self.isCallback && self.delegate && [self.delegate respondsToSelector:@selector(selectedSectionIndexTitle:atIndex:)]) {
            [self.delegate selectedSectionIndexTitle:self.indexItems[newIndex] atIndex:newIndex];
            
            if (isLetter) {
                // 只有手势滑动，才会触发指示器视图
                if (!self.indicatorView) {
                    self.indicatorView = [[KLIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
                }
                self.indicatorView.alpha = 1.0f;
                [self.indicatorView setOrigin:CGPointMake(SCREEN_WIDTH - self.marginRight - self.titleFontSize - self.indicatorMarginRight, newItemLabel.center.y + self.frame.origin.y) title:newItemLabel.text];
                // 将指示器视图添加到scrollView的父视图上
                if (self.delegate && [self.delegate respondsToSelector:@selector(addIndicatorView:)]) {
                    [self.delegate addIndicatorView:self.indicatorView];
                }
            }
        }
    }
}

#pragma mark - 事件处理

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:self];
    // 滑动期间不允许scrollview改变组
    self.isAllowedChange = NO;
    [self selectedIndexByPoint:location];
    
    if (@available(iOS 10.0, *)) {
        if (self.vibrationOn)
            self.generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    }
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:self];
    [self selectedIndexByPoint:location];
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:self];
    
    if (location.y < self.minY || location.y > self.maxY) {
        return;
    }
    
    [self selectedIndexByPoint:location];
    
    //如果当前有动画正在进行，则停止当前动画，再开始新动画，否则，直接开始新动画
    if ([self.indicatorView.layer animationForKey:@"basic"]) {
        [self.indicatorView.layer removeAnimationForKey:@"basic"];
        self.isAnimating = YES;
    }
    else {
        //判断是否有搜索
        BOOL isSearch = NO;
        if (self.indexItems.count > 0) {
            NSString *firstTitle = self.indexItems[self.selectedIndex];
            if (firstTitle == UITableViewIndexSearch) {
                isSearch = YES;
            }
        }
        
        if (!isSearch) {
            [self animationView:self.indicatorView];
        }
        
    }
    // 滑动结束后，允许scrollview改变组
    self.isAllowedChange = YES;
    
    self.generator = nil;
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    //只有当指示视图在视图上时，才能进行动画
    if (self.indicatorView.superview) {
        [self animationView:self.indicatorView];
    }
    //滑动结束后，允许scrollview改变组
    self.isAllowedChange = YES;
    
    self.generator = nil;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //滑动到视图之外时的处理
    [self cancelTrackingWithEvent:event];
}

- (void)animationView:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"opacity";
    animation.duration = 0.3;
    animation.fromValue = @1;
    animation.toValue = @0;
    animation.repeatCount = 1;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = @"forwards";
    
    //即将开始进行动画前，判断指示器视图是否已经添加到父视图上
    if (!self.indicatorView.superview) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(addIndicatorView:)]) {
            [self.delegate addIndicatorView:self.indicatorView];
        }
    }
    //当前动画可以被结束
    self.isAnimating = NO;
    [view.layer addAnimation:animation forKey:@"basic"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //self.isAnimating = YES，表示需要停止当前动画，开始新的动画，NO表示结束当前动画
    if (self.isAnimating) {
        [self animationView:self.indicatorView];
    }
    else {
        [self.indicatorView removeFromSuperview];
        [self.indicatorView.layer removeAllAnimations];
    }
}

#pragma mark - 根据Y坐标计算选中位置，当坐标有效时，返回YES
- (void)selectedIndexByPoint:(CGPoint)location {
    if (location.y >= self.minY && location.y <= self.maxY) {
        //计算下标
        NSInteger offsetY = location.y - self.minY - (self.titleSpace / 2.0);
        //单位高
        CGFloat item = self.itemMaxSize.height + self.titleSpace;
        //计算当前下标
        NSInteger index = (offsetY / item) ;//+ ((offsetY % item == 0)?0:1) - 1;
        
        if (index != self.selectedIndex && index < self.indexItems.count && index >= 0) {
            self.isCallback = YES;
            self.selectedIndex = index;
            if (@available(iOS 10.0, *)) {
                if (self.vibrationOn) {
                    [self.generator prepare];
                    [self.generator impactOccurred];
                }
            }
        }
    }
}

#pragma mark - getter

- (NSMutableArray *)itemsViewArray {
    if (!_itemsViewArray) {
        _itemsViewArray = [NSMutableArray array];
    }
    return _itemsViewArray;
}

- (UIImageView *)selectedImageView {
    if (!_selectedImageView) {
        _selectedImageView = [[UIImageView alloc] init];
        _selectedImageView.backgroundColor = self.selectBgColor;
    }
    return _selectedImageView;
}

- (CAShapeLayer *)imageMaskLayer:(CGRect)bounds radiu:(CGFloat)radiu {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radiu, radiu)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}

@end
