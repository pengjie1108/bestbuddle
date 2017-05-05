//
//  UIViewController+TBMBPProgressHUD.h
//  TonBright
//
//  Created by jie peng on 2017/5/5.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (TBMBPProgressHUD)

/**
 *  获取当前view的唯一HUD
 */
- (MBProgressHUD*)progressHUD;

/**
 *  使用HUD显示一段文字, 1秒后自动隐藏
 */
- (void)showTextHUDWithMessage:(NSString*)message;

/**
 *  使用HUD显示一段文字，指定时间后隐藏
 */
- (void)showTextHUDWithMessage:(NSString*)message andHideAfterDelay:(NSTimeInterval)timeInterval;

/**
 *  显示不带文字的任务处理提示
 */
- (void)showProgressHUD;
/**
 *  显示带文字的任务处理提示
 */
- (void)showProgressHUDWithMessage:(NSString*)message;
/**
 *  使用指定模式显示HUD
 */
- (void)showProgressHUDWithMessage:(NSString*)message mode:(MBProgressHUDMode)mode;

/**
 *  隐藏HUD
 */
- (void)hideProgressHUD;
/**
 *  指定时间后隐藏HUD
 */
- (void)hideProgressHUDAfterDelay:(NSTimeInterval)timeInterval;


@end
