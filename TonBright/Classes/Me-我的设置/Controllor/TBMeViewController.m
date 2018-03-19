//
//  TBMeViewController.m
//  TonBright
//
//  Created by jie peng on 2017/5/2.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#define MAS_SHORTHAND
//可以自动装箱基本数据类型,//使用后可以不适用前缀mas_
#define MAS_SHORTHAND_GLOBALS
//屏幕的尺寸
#define kMainScreenSize [UIScreen mainScreen].bounds.size

#import "TBMeViewController.h"
#import <Masonry.h>
#import "TBLoginViewController.h"
#import "TBMeAboutTableViewCell.h"

@interface TBMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSUserDefaults *userDefault;

@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic,weak) UIAlertController *alertVC;

@end

@implementation TBMeViewController

static NSString * const meAboutCellID = @"meAboutCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"个人设置";
    
    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:self.view.frame];
    scroll.backgroundColor = [UIColor whiteColor];
    scroll.contentSize = CGSizeMake(0, self.view.pj_height + 1);
    scroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scroll];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [scroll addSubview:logoImageView];
    
    UILabel *introduceLabel = [[UILabel alloc] init];
    introduceLabel.text = @"同辉用车无忧员工端";
    introduceLabel.textColor = [UIColor blackColor];
    [introduceLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [scroll addSubview:introduceLabel];
    
    UILabel *companyIDLabel = [[UILabel alloc] init];
    companyIDLabel.text = [NSString stringWithFormat:@"员工公司ID:%@",[TBAPPSetting shareAppSetting].companyid];
    companyIDLabel.font = [UIFont systemFontOfSize:13];
    [scroll addSubview:companyIDLabel];
    
    UILabel *companyNmLabel = [[UILabel alloc] init];
    companyNmLabel.text = [NSString stringWithFormat:@"员工公司名:%@",[TBAPPSetting shareAppSetting].companyname];
    companyNmLabel.font = [UIFont systemFontOfSize:13];
    companyNmLabel.numberOfLines = 0;
    [scroll addSubview:companyNmLabel];
    
    UILabel *userLoginNmLabel = [[UILabel alloc] init];
    userLoginNmLabel.text = [NSString stringWithFormat:@"员工登录名:%@",[TBAPPSetting shareAppSetting].loginname];
    userLoginNmLabel.font = [UIFont systemFontOfSize:13];
    [scroll addSubview:userLoginNmLabel];
    
    UIButton *singOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    singOutBtn.backgroundColor = [UIColor colorWithRed:139/255.0 green:208/255.0 blue:91/255.0 alpha:1];
    [singOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [singOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [singOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    singOutBtn.layer.cornerRadius = 3;
    singOutBtn.layer.masksToBounds = YES;
    [singOutBtn addTarget:self action:@selector(singOut) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:singOutBtn];
    
    UILabel *aboutLableUp = [[UILabel alloc] init];
    aboutLableUp.text  = [NSString stringWithFormat:@"同辉融资租赁（上海）股份有限公司 版权所有"];
    aboutLableUp.shadowColor = [UIColor grayColor];
    aboutLableUp.shadowOffset = CGSizeMake(0.5, 0.5);
    [aboutLableUp setTintColor:[UIColor blackColor]];
    [aboutLableUp setFont:[UIFont systemFontOfSize:12]];
    [scroll addSubview:aboutLableUp];
    
    UILabel *aboutLableMiddle = [[UILabel alloc] init];
    aboutLableMiddle.text  = [NSString stringWithFormat:@"Copyright @2014-2018 Tonbright"];
    aboutLableMiddle.shadowColor = [UIColor grayColor];
    aboutLableMiddle.shadowOffset = CGSizeMake(0.5, 0.5);
    [aboutLableMiddle setTintColor:[UIColor blackColor]];
    [aboutLableMiddle setFont:[UIFont systemFontOfSize:12]];
    [scroll addSubview:aboutLableMiddle];
    
    UILabel *aboutLableDown = [[UILabel alloc] init];
    aboutLableDown.text  = [NSString stringWithFormat:@"All Rights Reserved."];
    aboutLableDown.shadowColor = [UIColor grayColor];
    aboutLableDown.shadowOffset = CGSizeMake(0.5, 0.5);
    [aboutLableDown setTintColor:[UIColor blackColor]];
    [aboutLableDown setFont:[UIFont systemFontOfSize:12]];
    [scroll addSubview:aboutLableDown];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 100) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    // 取消系统分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置tableView背景色
    [scroll addSubview:tableView];
    tableView.bounces = NO;
    [tableView registerClass:[TBMeAboutTableViewCell class] forCellReuseIdentifier:meAboutCellID];
    self.tableView = tableView;
    
    //自动布局
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(25);
        make.centerX.equalTo(scroll);
    }];
    
    [introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoImageView.mas_bottom).offset(17);
        make.centerX.mas_equalTo(logoImageView);
    }];
    
    [companyIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(introduceLabel.mas_bottom).offset(20);
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
        make.top.mas_equalTo(userLoginNmLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(35);
    }];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(singOutBtn.mas_bottom).offset(10);
        make.height.equalTo(138);
        make.width.equalTo(kMainScreenSize.width);
    }];
    
    [aboutLableDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tableView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(scroll);
    }];
    
    [aboutLableMiddle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(aboutLableDown.mas_bottom).offset(5);
        make.centerX.mas_equalTo(scroll);
    }];
    
    [aboutLableUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(aboutLableMiddle.mas_bottom).offset(5);
        make.centerX.mas_equalTo(aboutLableMiddle);
    }];
    
    
    
}


/**
 登出
 */
- (void)singOut{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定退出登录吗？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"确认"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   UIViewController  *tbLoginVC = [[UIStoryboard storyboardWithName:@"TBLoginViewController" bundle:nil] instantiateInitialViewController];
                                                   [UIApplication sharedApplication].keyWindow.rootViewController = tbLoginVC;
                                                   [self dismissViewControllerAnimated:YES completion:nil];
                                               }];
    [alertVC addAction:ok];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       [self dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alertVC addAction:cancel];
    
   [self presentViewController:alertVC animated:YES completion:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TBMeAboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:meAboutCellID];
    if (cell == nil) {
        cell = [[TBMeAboutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:meAboutCellID];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"关于同辉"];
    }else if(indexPath.row == 1){
        cell.textLabel.text = [NSString stringWithFormat:@"检查新版本"];
    }else if(indexPath.row == 2){
        cell.textLabel.text = [NSString stringWithFormat:@"使用条款和隐私政策"];
    }
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UIViewController *aboutThVC = [[UIViewController alloc] init];
        UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:self.view.frame];
        scroll.showsVerticalScrollIndicator = NO;
        aboutThVC.view.backgroundColor = [UIColor whiteColor];
        [aboutThVC.view addSubview:scroll];
        aboutThVC.navigationItem.title = @"关于同辉";
        [aboutThVC hidesBottomBarWhenPushed];
        CGFloat imageH;
        UIImage *image;
        image = [UIImage imageNamed:@"about.jpg"];
        imageH = image.size.height;
        TBLog(@"SreenWidth%lf",SreenWidth);
        if(SreenWidth == 320){
            image = [UIImage imageNamed:@"about640.jpg"];
            imageH = image.size.height;
        }else if(SreenWidth == 414){//plus
            image = [UIImage imageNamed:@"about1080.jpg"];
            imageH = image.size.height;
        }else if(SreenHeight == 812){//适配iphoneX
            image = [UIImage imageNamed:@"about1125.jpg"];
            imageH = image.size.height;
        }
        scroll.contentSize=CGSizeMake(0, imageH + 50);
        UIImageView *  imagev = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, SreenWidth, imageH)];
        imagev.image=image;
        [scroll addSubview:imagev];
        [self.navigationController pushViewController:aboutThVC animated:YES];
    }else if (indexPath.row == 2){
        UIViewController *termsVC = [[UIViewController alloc] init];
        UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:self.view.frame];
        scroll.showsVerticalScrollIndicator = NO;
        termsVC.view.backgroundColor = [UIColor whiteColor];
        [termsVC.view addSubview:scroll];
        termsVC.navigationItem.title = @"使用条款";
        NSString *path = [[NSBundle mainBundle] pathForResource:@"article" ofType:@"txt"];
        NSString *txt = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:txt];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 10;
        UIFont *font = [UIFont systemFontOfSize:14];
        [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, txt.length)];
        [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, txt.length)];
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.text = txt;
        label.numberOfLines = 0;
        label.attributedText = attributeString;
        CGSize size = [label sizeThatFits:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)];
        label.pj_size = size;
        NSLog(@"size:%@", NSStringFromCGSize(size));
        NSLog(@"label.frame.size:%@", NSStringFromCGSize(label.frame.size));
        scroll.contentSize = size;
        [scroll addSubview:label];
        [label sizeToFit];
        [self.navigationController pushViewController:termsVC animated:YES];
    }
}


@end
