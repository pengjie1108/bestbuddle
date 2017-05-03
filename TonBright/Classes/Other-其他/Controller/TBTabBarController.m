//
//  TBTabBarController.m
//  TonBright
//
//  Created by jie peng on 2017/5/2.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "TBTabBarController.h"
#import "TBSystemViewController.h"
#import "TBFocusViewController.h"
#import "TBMeViewController.h"
#import "TBTodoViewController.h"
#import "TBTabBar.h"

@interface TBTabBarController ()

@end

@implementation TBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupItemTitleTextAttributes];
    
    [self setupChildViewControllers];
    
    [self setupTabBar];
    
}

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

- (void)setupChildViewControllers{
    
    [self setupOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[[TBTodoViewController alloc ] init]]  title:@"待办" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[[TBSystemViewController alloc] init]] title:@"系统" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
     [self setupOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[[TBFocusViewController alloc] init]] title:@"关注" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
     [self setupOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[[TBMeViewController alloc] init]] title:@"我的" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
}

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    vc.tabBarItem.title = title;
    if (image.length) {
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    [self addChildViewController:vc];
}

- (void)setupTabBar{
    
    [self setValue:[[TBTabBar alloc] init] forKeyPath:@"tabBar"];
}


@end
