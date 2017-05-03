//
//  TBTabBar.m
//  TonBright
//
//  Created by jie peng on 2017/5/2.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "TBTabBar.h"

@interface TBTabBar()

@property (nonatomic,weak) UIButton *publishButton;

@end

@implementation TBTabBar

- (UIButton *) publishButton{
    
    if (!_publishButton) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    return _publishButton;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat buttonW = self.pj_width / 5;
    CGFloat buttonH = self.pj_height;
    
    CGFloat tabBarButtonY = 0;
    
    int tabBarButtonIndex = 0;
    
    for (UIView *subview in self.subviews) {
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
        CGFloat tabBarButtonX = tabBarButtonIndex * buttonW;
        if (tabBarButtonIndex >= 2) {
            tabBarButtonX += buttonW;
        }
        subview.frame = CGRectMake(tabBarButtonX, tabBarButtonY, buttonW, buttonH);
        
        tabBarButtonIndex ++;
    }
    
    self.publishButton.pj_width = buttonW;
    self.publishButton.pj_height = buttonH;
    self.publishButton.pj_centerX = self.pj_width * 0.5;
    self.publishButton.pj_centerY = self.pj_height * 0.5;
    
}

- (void)publishClick{
    
    NSLog(@"%s",__FUNCTION__);
}


@end
