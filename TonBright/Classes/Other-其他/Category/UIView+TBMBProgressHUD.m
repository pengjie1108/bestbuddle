//
//  UIView+TBMBProgressHUD.m
//  TonBright
//
//  Created by jie peng on 2017/5/5.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "UIView+TBMBProgressHUD.h"
#import <MBProgressHUD.h>
#import <objc/runtime.h>


@implementation UIView (TBMBProgressHUD)

+ (void)load{
    SEL originalSelector = @selector(didAddSubview:);
    SEL overrideSelector = @selector(fc_didAddSubview:);
    
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method overrideMethod = class_getInstanceMethod(self, overrideSelector);
    
    if (class_addMethod(self, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        
        class_replaceMethod(self, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod);
    }

}

- (MBProgressHUD *)progressHUD
{
    return objc_getAssociatedObject(self, @selector(progressHUD));
}

- (void)setProgressHUD:(MBProgressHUD *)progressHUD
{
    objc_setAssociatedObject(self, @selector(progressHUD), progressHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setupProgressHUD
{
    if (self.progressHUD) {
        return;
    }
    
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    self.progressHUD.removeFromSuperViewOnHide = NO;
}


- (void)fc_didAddSubview:(UIView *)subview{
    [self fc_didAddSubview:subview];
    
    if (self.progressHUD) {
        [self bringSubviewToFront:self.progressHUD];
    }
}


@end
