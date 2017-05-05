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

static NSString * const TBCommonURL = @"http://121.40.92.131/newbusiness/apipj/api.user.login.php";

@interface TBLoginViewController ()

@property (weak, nonatomic) IBOutlet TBLoginTextField *loginNameTextField;
@property (weak, nonatomic) IBOutlet TBLoginTextField *passWordTextField;

@end

@implementation TBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginNameTextField.text = @"TH14074";
    self.passWordTextField.text = @"111111";
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (IBAction)login:(id)sender {
    
    [self showProgressHUD];
    
    NSCharacterSet *whiteNewChars = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *loginname = [self.loginNameTextField.text stringByTrimmingCharactersInSet:whiteNewChars];
    NSString *password = [self.passWordTextField.text stringByTrimmingCharactersInSet:whiteNewChars];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"loginname"] = loginname;
    params[@"password"] = password;
    
    __weak typeof(self) weakSelf = self;
    [[TBHTTPSessionManager manager] POST:TBCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {

        NSString *stat = [NSString stringWithString:responseObject[@"stat"]];
        if (![stat intValue]) {
            //模拟网络延迟
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf hideProgressHUD];
                [weakSelf setAppSeting:responseObject[@"data"]];
                NSLog(@"%zd",(NSInteger)responseObject[@"cauthtype"]);
                TBTabBarController *tabVc = [[TBTabBarController alloc] init];
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                window.rootViewController = tabVc;
                [tabVc showTextHUDWithMessage:@"登录成功"];
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
    [TBAPPSetting shareAppSetting].cauthtype = (NSInteger)responseObject[@"cauthtype"] ;
    [TBAPPSetting shareAppSetting].gauthtype = (NSInteger)responseObject[@"gauthtype"];
    [TBAPPSetting shareAppSetting].userid = responseObject[@"userid"];
    [TBAPPSetting shareAppSetting].topcompanyid = responseObject[@"topcompanyid"];
    [TBAPPSetting shareAppSetting].usernm = responseObject[@"usernm"];
    [TBAPPSetting shareAppSetting].userrole = responseObject[@"userrole"];
    [TBAPPSetting shareAppSetting].userfunction = responseObject[@"userfunction"];
}


@end
