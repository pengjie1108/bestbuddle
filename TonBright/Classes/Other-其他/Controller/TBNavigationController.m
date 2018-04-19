//
//  TBNavigationController.m
//  TonBright
//
//  Created by jie peng on 2018/3/19.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBNavigationController.h"

@interface TBNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation TBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = [UIColor whiteColor];
    navBar.barTintColor = [UIColor redColor];
//    [navBar setShadowImage:[UIImage new]];

    // 设置文字的属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] =[UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17.0];
    [navBar setTitleTextAttributes:textAttrs];
    
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsCompact];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        // 左上角
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"ic_back_white"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"ic_back_white"] forState:UIControlStateHighlighted];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        backButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton sizeToFit];

        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

        // 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;
    }

    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //当导航控制器的子控制器个数 > 1有效
    return self.childViewControllers.count > 1;
}


-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (@available(iOS 11.2, *)) {
        self.navigationBar.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
        self.navigationBar.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
    }
}


@end
