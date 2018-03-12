//
//  TBTempSystemViewController.m
//  TonBright
//
//  Created by jie peng on 2018/3/7.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBTempSystemViewController.h"
#import "TBContractListViewController.h"


@interface TBTempSystemViewController ()

@end

@implementation TBTempSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.title = @"业务系统";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *contractListBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [contractListBtn setTitle:@"合同查看" forState:UIControlStateNormal];
    contractListBtn.frame = CGRectMake(100, 100, 100, 100);
    [contractListBtn addTarget:self action:@selector(pushContractVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:contractListBtn];
}

- (void)pushContractVC{
    TBContractListViewController *contractListVc = [[TBContractListViewController alloc] init];
    contractListVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:contractListVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
