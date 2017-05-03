//
//  TBLoginTextField.m
//  TonBright
//
//  Created by jie peng on 2017/5/3.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "TBLoginTextField.h"

@implementation TBLoginTextField

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.tintColor = [UIColor whiteColor];
    
    self.placeholderColor = [UIColor grayColor];
}

- (BOOL)becomeFirstResponder{
    self.placeholderColor = [UIColor whiteColor];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    self.placeholderColor = [UIColor grayColor];
    return [super resignFirstResponder];
}


@end
