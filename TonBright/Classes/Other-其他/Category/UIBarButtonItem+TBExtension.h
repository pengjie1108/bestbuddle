//
//  UIBarButtonItem+TBExtension.h
//  TonBright
//
//  Created by jie peng on 2018/3/19.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (TBExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
