//
//  TBTodoViewController.m
//  TonBright
//
//  Created by jie peng on 2017/5/2.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "TBTodoViewController.h"

@interface TBTodoViewController ()

@end

@implementation TBTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TBCommonBgColor;
    self.navigationItem.title = @"待办事项";
    


        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(100, 50 , 200, 50);

//                label.text = [TBAPPSetting shareAppSetting].loginname;

//                label.text = [TBAPPSetting shareAppSetting].tokenid;
//
//                label.text = [NSString stringWithFormat:@"%zd",[TBAPPSetting shareAppSetting].cauthtype];
//
//                label.text = [NSString stringWithFormat:@"%zd",[TBAPPSetting shareAppSetting].gauthtype];
//
//                label.text = [TBAPPSetting shareAppSetting].userid;
//
//                label.text = [TBAPPSetting shareAppSetting].topcompanyid;
//
//                label.text = [TBAPPSetting shareAppSetting].usernm;
//
//                label.text = [TBAPPSetting shareAppSetting].userrole[0];
//
//                label.text = [TBAPPSetting shareAppSetting].userfunction[0];
    
    TBLog(@"%zd",[TBAPPSetting shareAppSetting].cauthtype);

        
        label.backgroundColor = TBRandomColor;
        [self.view addSubview:label];
    
   }



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    
    
    return cell;
}

@end
