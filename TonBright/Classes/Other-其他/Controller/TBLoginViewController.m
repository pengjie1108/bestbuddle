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

static NSString * const TBCommonURL = @"http://121.40.92.131/newbusiness/apipj/api.user.login.php";

@interface TBLoginViewController ()
@property (weak, nonatomic) IBOutlet TBLoginTextField *loginName;
@property (weak, nonatomic) IBOutlet TBLoginTextField *passWord;

@end

@implementation TBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)login:(id)sender {
    
    [MBProgressHUD showMessage:@"登录中..."];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"loginname"] = self.loginName.text;
    params[@"password"] = self.passWord.text;
    
    [[TBHTTPSessionManager manager] POST:TBCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        TBLog(@"stat--%@",responseObject[@"stat"])
        
        if (responseObject[@"stat"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                [MBProgressHUD showSuccess:@"登陆成功"];
                [self dismissViewControllerAnimated:YES completion:nil];

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
