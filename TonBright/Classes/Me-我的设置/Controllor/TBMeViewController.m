//
//  TBMeViewController.m
//  TonBright
//
//  Created by jie peng on 2017/5/2.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "TBMeViewController.h"
#import <Masonry.h>


@interface TBMeViewController ()

@end

@implementation TBMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];

    
}

- (void)setUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"个人设置";
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    logoImageView.pj_centerX = self.view.pj_centerX;
    logoImageView.pj_centerY = 150;
    [self.view addSubview:logoImageView];
    
    UILabel *introduceLabel = [[UILabel alloc] init];
    introduceLabel.text = @"同辉用车无忧员工端";
    introduceLabel.font = [UIFont systemFontOfSize:17];
    introduceLabel.textColor = [UIColor blackColor];
    [self.view addSubview:introduceLabel];
    
    UILabel *companyIDLabel = [[UILabel alloc] init];
    companyIDLabel.text = [NSString stringWithFormat:@"公司ID:%@",[TBAPPSetting shareAppSetting].topcompanyid];
    companyIDLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:companyIDLabel];
    
    UILabel *companyNmLabel = [[UILabel alloc] init];
    companyNmLabel.text = [NSString stringWithFormat:@"商户公司:%@",[TBAPPSetting shareAppSetting].topcompanyid];
    companyNmLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:companyNmLabel];
    
    UILabel *userLoginNmLabel = [[UILabel alloc] init];
    userLoginNmLabel.text = [NSString stringWithFormat:@"用户账户:%@",[TBAPPSetting shareAppSetting].loginname];
    userLoginNmLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:userLoginNmLabel];
    
    UIButton *singOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    singOutBtn.backgroundColor = [UIColor colorWithRed:139/255.0 green:208/255.0 blue:91/255.0 alpha:1];
    [singOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [singOutBtn setTintColor:[UIColor blackColor]];
    [self.view addSubview:singOutBtn];
    
    [introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoImageView.mas_bottom).offset(30);
        make.centerX.mas_equalTo(logoImageView);
    }];
    
    [companyIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(introduceLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view).offset(20);
    }];
    
    [companyNmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(companyIDLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(companyIDLabel);
    }];
    
    [userLoginNmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(companyNmLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(companyNmLabel);
    }];
    
    [singOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(userLoginNmLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(35);
    }];
    
}


@end
