//
//  TBMeViewController.m
//  TonBright
//
//  Created by jie peng on 2017/5/2.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "TBMeViewController.h"
#import <Masonry.h>
#import "TBLoginViewController.h"

@interface TBMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSUserDefaults *userDefault;

@property (nonatomic,weak) UITableView *tableview;
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
    companyIDLabel.text = [NSString stringWithFormat:@"员工公司ID :%@",[TBAPPSetting shareAppSetting].companyid];
    companyIDLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:companyIDLabel];
    
    UILabel *companyNmLabel = [[UILabel alloc] init];
    companyNmLabel.text = [NSString stringWithFormat:@"员工公司名  :%@",[TBAPPSetting shareAppSetting].companyname];
    companyNmLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:companyNmLabel];
    
    UILabel *userLoginNmLabel = [[UILabel alloc] init];
    userLoginNmLabel.text = [NSString stringWithFormat:@"员工登录名  :%@",[TBAPPSetting shareAppSetting].loginname];
    userLoginNmLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:userLoginNmLabel];
    
    UILabel *departmentNmLabel = [[UILabel alloc] init];
    departmentNmLabel.text = [NSString stringWithFormat:@"员工所在部门:%@",[TBAPPSetting shareAppSetting].departmentname];
    departmentNmLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:departmentNmLabel];
    
    UIButton *singOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    singOutBtn.backgroundColor = [UIColor colorWithRed:139/255.0 green:208/255.0 blue:91/255.0 alpha:1];
    [singOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [singOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [singOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [singOutBtn addTarget:self action:@selector(singOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:singOutBtn];
    
    UILabel *aboutLableUp = [[UILabel alloc] init];
    aboutLableUp.text  = [NSString stringWithFormat:@"同辉融资租赁（上海）股份有限公司 版权所有"];
    aboutLableUp.shadowColor = [UIColor grayColor];
    aboutLableUp.shadowOffset = CGSizeMake(0.5, 0.5);
    [aboutLableUp setTintColor:[UIColor blackColor]];
    [aboutLableUp setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:aboutLableUp];
    
    UILabel *aboutLableMiddle = [[UILabel alloc] init];
    aboutLableMiddle.text  = [NSString stringWithFormat:@"Copyright @2014-2018 Tonbright"];
    aboutLableMiddle.shadowColor = [UIColor grayColor];
    aboutLableMiddle.shadowOffset = CGSizeMake(0.5, 0.5);
    [aboutLableMiddle setTintColor:[UIColor blackColor]];
    [aboutLableMiddle setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:aboutLableMiddle];
    
    UILabel *aboutLableDown = [[UILabel alloc] init];
    aboutLableDown.text  = [NSString stringWithFormat:@"All Rights Reserved."];
    aboutLableDown.shadowColor = [UIColor grayColor];
    aboutLableDown.shadowOffset = CGSizeMake(0.5, 0.5);
    [aboutLableDown setTintColor:[UIColor blackColor]];
    [aboutLableDown setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:aboutLableDown];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 100) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableview = tableView;
    
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
    
    [departmentNmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userLoginNmLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(userLoginNmLabel);
    }];
    
    [singOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(departmentNmLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(35);
    }];
    
    [aboutLableDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-59);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [aboutLableMiddle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(aboutLableDown.mas_top).offset(-5);
        make.centerX.mas_equalTo(aboutLableDown);
    }];
    
    [aboutLableUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(aboutLableMiddle.mas_top).offset(-5);
        make.centerX.mas_equalTo(aboutLableMiddle);
    }];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(singOutBtn.mas_bottom).offset(10);
    }];
    
}

- (void)singOut{
    UIViewController  *tbLoginVC = [[UIStoryboard storyboardWithName:@"TBLoginViewController" bundle:nil] instantiateInitialViewController];
    [UIApplication sharedApplication].keyWindow.rootViewController = tbLoginVC;
    TBLogFunc;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellID];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"关于同辉用车无忧员工APP"];
    }else if(indexPath.row == 1){
        cell.textLabel.text = [NSString stringWithFormat:@"检查新版本"];
    }else if(indexPath.row == 2){
        cell.textLabel.text = [NSString stringWithFormat:@"使用条款和隐私政策"];
    }
    return cell;
}


@end
