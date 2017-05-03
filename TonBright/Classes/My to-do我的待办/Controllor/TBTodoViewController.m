//
//  TBTodoViewController.m
//  TonBright
//
//  Created by jie peng on 2017/5/2.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "TBTodoViewController.h"
#import "TBLoginViewController.h"

@interface TBTodoViewController ()

@end

@implementation TBTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TBCommonBgColor;
    self.navigationItem.title = @"待办事项";
   }


- (IBAction)loginAction:(UIButton *)sender {
    TBLoginViewController *loginVc = [[TBLoginViewController alloc] init];
    [self presentViewController:loginVc animated:YES completion:nil];
    
    
    
}

@end
