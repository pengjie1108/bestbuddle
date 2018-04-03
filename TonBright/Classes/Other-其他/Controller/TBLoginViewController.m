//
//  TBLoginViewController.m
//  TonBright
//
//  Created by jie peng on 2017/5/3.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "TBLoginViewController.h"
#import "TBLoginTextField.h"
#import "TBHTTPSessionManager.h"
#import "TBTabBarController.h"
#import "TBAPPSetting.h"
#import "TBTempTabBarViewController.h"

////static NSString * const TBCommonURL = @"http://192.168.1.65/nbsst/api/api.m.user.login.php";
//static NSString * const TBCommonURL = @"http://203.156.252.183:81/nbs/api/api.m.user.login.php";

@interface TBLoginViewController ()

@property (weak, nonatomic) IBOutlet TBLoginTextField *loginNameTextField;
@property (weak, nonatomic) IBOutlet TBLoginTextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imv_remberP;

@end

@implementation TBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginNameTextField.text = [TBAPPSetting shareAppSetting].loginUserName;
    if ([TBAPPSetting shareAppSetting].keepLogin) {
        _passWordTextField.text = [[TBAPPSetting shareAppSetting] passwordForUserName:[TBAPPSetting shareAppSetting].loginUserName];
        _imv_remberP.image = [UIImage imageNamed:@"勾选框_选中"];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (IBAction)rememberPwdClick:(id)sender {
    [TBAPPSetting shareAppSetting].keepLogin = ![TBAPPSetting shareAppSetting].keepLogin;
    if ([TBAPPSetting shareAppSetting].keepLogin) {
        _imv_remberP.image = [UIImage imageNamed:@"勾选框_选中"];
    } else {
        _imv_remberP.image = [UIImage imageNamed:@"勾选框"];
    }
}


/**
 登录执行

 @param sender 登录按钮
 */
- (IBAction)login:(id)sender {
    [self.view endEditing:YES];
    //保存账号
    [TBAPPSetting shareAppSetting].loginUserName = _loginNameTextField.text;

    //进行账号密码为空判断---------------
    
    [self showProgressHUD];
    //过滤字符串开始位置和结束位置的空格
    NSCharacterSet *whiteNewChars = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *loginname = [self.loginNameTextField.text stringByTrimmingCharactersInSet:whiteNewChars];
    NSString *password = [self.passWordTextField.text stringByTrimmingCharactersInSet:whiteNewChars];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"loginname"] = loginname;
    params[@"password"] = password;

    __weak typeof(self) weakSelf = self;
    [[TBHTTPSessionManager manager] POST:TBLoginURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* _Nullable responseObject) {

        NSString *stat = [NSString stringWithFormat:@"%@",responseObject[@"stat"]];
        if (![stat intValue]) {
            //模拟网络延迟
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf hideProgressHUD];
                [weakSelf setAppSeting:responseObject[@"data"]];
                TBTempTabBarViewController *tabVc = [[TBTempTabBarViewController alloc] init];
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                window.rootViewController = tabVc;
                [tabVc showTextHUDWithMessage:@"登录成功"];
            });
        }else{
        NSString *errorString = [NSString stringWithFormat:@"%@",responseObject[@"error"]];
        [weakSelf showTextHUDWithMessage:[NSString stringWithFormat:@"登录失败:%@",errorString]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == -1001) {
            [weakSelf showTextHUDWithMessage:@"登录失败:请求超时"];
        }
        [weakSelf showTextHUDWithMessage:@"登录失败"];
        TBLog(@"请求失败--%@",error);
    }];
    
   }

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)setAppSeting:(NSDictionary *_Nullable)responseObject{
    [TBAPPSetting shareAppSetting].loginname = responseObject[@"loginname"];
    [TBAPPSetting shareAppSetting].tokenid = responseObject[@"tokenid"];
    [TBAPPSetting shareAppSetting].cauthtype = [responseObject[@"cauthtype"] intValue];
    [TBAPPSetting shareAppSetting].gauthtype = [responseObject[@"gauthtype"] intValue];
    [TBAPPSetting shareAppSetting].userid = responseObject[@"userid"];
    [TBAPPSetting shareAppSetting].topcompanyid = responseObject[@"topcompanyid"];
    [TBAPPSetting shareAppSetting].usernm = responseObject[@"usernm"];
    [TBAPPSetting shareAppSetting].userrole = responseObject[@"userrole"];
    [TBAPPSetting shareAppSetting].userfunction = responseObject[@"userfunction"];
    [TBAPPSetting shareAppSetting].companyname = responseObject[@"companyname"];
    [TBAPPSetting shareAppSetting].companyid = responseObject[@"companyid"];
    [TBAPPSetting shareAppSetting].departmentname = responseObject[@"departmentname"];
    if ([TBAPPSetting shareAppSetting].keepLogin) {
        [[TBAPPSetting shareAppSetting] setPassword:_passWordTextField.text userName:_loginNameTextField.text];
    } else {
        [[TBAPPSetting shareAppSetting] setPassword:@"" userName:_loginNameTextField.text];
    }
}


@end
