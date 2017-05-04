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
#import <YYModel.h>
#import "TBUser.h"

static NSString * const TBCommonURL = @"http://121.40.92.131/newbusiness/apipj/api.user.login.php";

@interface TBLoginViewController ()
@property (weak, nonatomic) IBOutlet TBLoginTextField *loginName;
@property (weak, nonatomic) IBOutlet TBLoginTextField *passWord;

@end

@implementation TBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginName.text = @"TH14074";
    self.passWord.text = @"111111";
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)login:(id)sender {
    
    [MBProgressHUD showMessage:@"登录中..." toView:self.view];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"loginname"] = self.loginName.text;
    params[@"password"] = self.passWord.text;
    
    __weak typeof(self) weakSelf = self;
    
    [[TBHTTPSessionManager manager] POST:TBCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
       TBLog(@"responseObject----%@",[responseObject class])
       TBLog(@"responseObject-stat----%@",[responseObject[@"stat"] class])
       TBLog(@"responseObject-data----%@",[responseObject[@"data"] class])
        TBLog(@"responseObject-data-tokenid-----%@",[responseObject[@"data"][@"tokenid"] class])
       TBLog(@"responseObject-error----%@",[responseObject[@"error"] class])
       NSString *stat = [NSString stringWithString:responseObject[@"stat"]];
       
        TBUser *user = [TBUser yy_modelWithDictionary:responseObject[@"data"]];

        if ([stat intValue] == 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:@"登陆成功"];
                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                }];
            });
   }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TBLog(@"请求失败--%@",error);
    }];
    
   }

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

@end
