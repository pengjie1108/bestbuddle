//
//  UIBarButtonItem+TBExtension.m
//  TonBright
//
//  Created by jie peng on 2018/3/19.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "UIBarButtonItem+TBExtension.h"

@implementation UIBarButtonItem (TBExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[self alloc] initWithCustomView:button];
}
@end
