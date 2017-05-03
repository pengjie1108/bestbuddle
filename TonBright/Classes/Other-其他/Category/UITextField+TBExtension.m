//
//  UITextField+TBExtension.m
//  TonBright
//
//  Created by jie peng on 2017/5/3.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "UITextField+TBExtension.h"

static NSString * const TBPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (TBExtension)

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    NSString *oldPlaceholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = oldPlaceholder;
    
    if (placeholderColor == nil) {
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.098 alpha:0];
    }
    
    [self setValue:placeholderColor forKeyPath:TBPlaceholderColorKey];
    
}

- (UIColor *)placeholderColor{
    return [self valueForKeyPath:TBPlaceholderColorKey];
}


@end
