//
//  UIViewController+TBMBPProgressHUD.m
//  TonBright
//
//  Created by jie peng on 2017/5/5.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "UIViewController+TBMBPProgressHUD.h"
#import "UIView+TBMBProgressHUD.h"

@implementation UIViewController (TBMBPProgressHUD)


-(MBProgressHUD *)progressHUD
{
    if (!self.view.progressHUD) {
        [self.view setupProgressHUD];
    }
    return self.view.progressHUD;
}

/**
 *  使用HUD显示一段文字, 1秒后自动隐藏
 */
- (void)showTextHUDWithMessage:(NSString*)message
{
    [self showTextHUDWithMessage:message andHideAfterDelay:1.0f];
}

- (void)showTextHUDWithMessage:(NSString*)message andHideAfterDelay:(NSTimeInterval)timeInterval {
    
    if ([message length] == 0) {
        [self.progressHUD hideAnimated:NO afterDelay:0];
        return;
    }
    
    self.progressHUD.mode = MBProgressHUDModeText;
    self.progressHUD.label.text = message;
    [self.progressHUD showAnimated:YES];
    //    [self.progressHUD hide:YES afterDelay:timeInterval];
    [self hideProgressHUDAfterDelay:timeInterval];
}

- (void)showProgressHUD {
    [self showProgressHUDWithMessage:nil];
}

- (void)showProgressHUDWithMessage:(NSString*)message {
    [self showProgressHUDWithMessage:message mode:MBProgressHUDModeIndeterminate];
}

- (void)showProgressHUDWithMessage:(NSString*)message mode:(MBProgressHUDMode)mode {
    self.progressHUD.mode = mode;
    self.progressHUD.label.text = message;
    [self.progressHUD showAnimated:YES];
}

- (void)hideProgressHUD {
    [self hideProgressHUDAfterDelay:0];
}

- (void)hideProgressHUDAfterDelay:(NSTimeInterval)timeInterval {
    [self.progressHUD hideAnimated:YES afterDelay:timeInterval];
}



@end
