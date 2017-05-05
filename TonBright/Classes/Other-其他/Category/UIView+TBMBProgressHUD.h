//
//  UIView+TBMBProgressHUD.h
//  TonBright
//
//  Created by jie peng on 2017/5/5.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface UIView (TBMBProgressHUD)

@property (nonatomic,strong) MBProgressHUD *progressHUD;

- (void)setupProgressHUD;

@end
