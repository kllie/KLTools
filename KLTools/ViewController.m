//
//  ViewController.m
//  KLTools
//
//  Created by neville on 2018/5/19.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "ViewController.h"
#import "KLTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"导航";
    
    UIView *view1 = [[UIView alloc] init];
    UIView *view2 = [[UIView alloc] init];
    UIView *view3 = [[UIView alloc] init];
    NSArray *views = @[view1, view2, view3];
    self.view.setSubviews(views);
    
    for (int i = 0; i < views.count; i++) {
        UIView *view = views[i];
        view.frame = CGRectMake(20, 100 + 80 * i, 200, 50);
        view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
