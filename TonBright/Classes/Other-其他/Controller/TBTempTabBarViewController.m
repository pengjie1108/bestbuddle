//
//  TBTempTabBarViewController.m
//  TonBright
//
//  Created by jie peng on 2018/3/7.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBTempTabBarViewController.h"
#import "TBSystemViewController.h"
#import "TBMeViewController.h"
#import "TBTempSystemViewController.h"
#import "TBContractListViewController.h"

@interface TBTempTabBarViewController ()

@end

@implementation TBTempTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupItemTitleTextAttributes];
    
    [self setupChildViewControllers];
    
}

//设置tabBar格式
- (void)setupItemTitleTextAttributes{
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

//设置子控制器
- (void)setupChildViewControllers{
    
    [self setupOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[[TBContractListViewController alloc] init]] title:@"系统" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[[TBMeViewController alloc] init]] title:@"个人" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
}

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    vc.tabBarItem.title = title;
    if (image.length) {
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    [self addChildViewController:vc];
}

@end
