//
//  TBContractListViewController.m
//  TonBright
//
//  Created by jie peng on 2017/5/15.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "TBContractListViewController.h"
#import "TBHTTPSessionManager.h"
#import "TBContractList.h"
#import "TBContractListCell.h"
#import <YYModel.h>
#import "TBCommonItemModel.h"
#import "TBInquireController.h"
#import "TBContractDetailController.h"


@interface TBContractListViewController ()<TBContractListProtocol>

/** 所有的合同查询(数组中存放的都是TBContractList模型) */
@property (nonatomic, strong) NSArray<TBContractList *> *contractLists;
/** 请求管理者 */
@property (nonatomic, weak) TBHTTPSessionManager *manager;

@property(nonatomic,assign)CGFloat historyY;

@property (nonatomic,assign) BOOL defaultFlag;
@end

//static NSString * const TBContractListURL = @"http://192.168.1.65/nbsst/api/api.caseinfo.list.php";
static NSString * const TBContractListURL = @"http://203.156.252.183:81/nbs/api/api.caseinfo.list.php";

@implementation TBContractListViewController

/** cell的重用标识 */
static NSString * const TBContractListCellId = @"TBContractListCell";

/** manager属性的懒加载 */
- (TBHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [TBHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"合同查看";
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"查询" style:UIBarButtonItemStylePlain target:self action:@selector(inquire)];
    [rightBtn setTintColor:[UIColor blackColor]];
    [rightBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName,nil] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItem = rightBtn;
     
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TBContractListCell class]) bundle:nil] forCellReuseIdentifier:TBContractListCellId];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    _defaultFlag = NO;
}

//跳转到检索控制器
- (void)inquire{
    TBInquireController *contractVc = [[TBInquireController alloc] init];
    contractVc.conditionDictionary = nil;
    contractVc.conditionDictionary = self.conditionDictionary;
    contractVc.delegate = self;
    [self.navigationController pushViewController:contractVc animated:YES];
}

- (void)getData:(NSDictionary *)conditionDictionary{
    TBLog(@"%d",_defaultFlag);
    if (_defaultFlag) {
        [self showProgressHUD];
    }
    
    NSMutableDictionary *params = conditionDictionary.mutableCopy;
    [params setObject:[TBAPPSetting shareAppSetting].userid forKey:@"tokenuserid"];
    [params setObject:[TBAPPSetting shareAppSetting].tokenid forKey:@"tokenid"];
    [params setObject:[TBAPPSetting shareAppSetting].topcompanyid forKey:@"topcompanyid"];
     __weak typeof(self) weakSelf = self;
    [self.manager POST:TBContractListURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* _Nullable responseObject) {
        NSString *stat = [NSString stringWithString:responseObject[@"stat"]];
        if (![stat intValue]) {
            if (_defaultFlag) {
                [weakSelf showTextHUDWithMessage:@"查询成功"];
            }
            weakSelf.contractLists = (NSArray<TBContractList*> *)[NSArray yy_modelArrayWithClass:[TBContractList class] json:responseObject[@"data"][@"caseinfolist"]];
            [weakSelf.tableView setSeparatorColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1]];
            [weakSelf.tableView reloadData];
            CGPoint offset = weakSelf.tableView.contentOffset;
            offset.y =  - weakSelf.tableView.contentInset.top - 64;
            [weakSelf.tableView setContentOffset:offset animated:YES];
            
        }else{
            NSString *errorString = [NSString stringWithFormat:@"%@",responseObject[@"error"]];
            [weakSelf showTextHUDWithMessage:[NSString stringWithFormat:@"登录失败:%@",errorString]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_defaultFlag) {
            [weakSelf showTextHUDWithMessage:@"查询失败"];
        }
            TBLog(@"请求失败 - %@", error);
           }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return self.contractLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TBContractListCell *cell = [tableView dequeueReusableCellWithIdentifier:TBContractListCellId];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contractList = self.contractLists[indexPath.row];
    UIColor *color = ((indexPath.row % 2) == 0) ? [UIColor clearColor] : [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
    cell.backgroundColor = color;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取caseid
    TBContractDetailController *contractDetailVC = [[TBContractDetailController alloc] init];
    contractDetailVC.caseid = self.contractLists[indexPath.row].caseid;
    [self.navigationController pushViewController:contractDetailVC animated:YES];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (_historyY+20<targetContentOffset->y)
    {
        [self setTabBarHidden:YES];
    }
    else if(_historyY-20>targetContentOffset->y)
    {
        
        [self setTabBarHidden:NO];
    }
    _historyY=targetContentOffset->y;
}

- (void)setTabBarHidden:(BOOL)hidden
{
    UIView *tab = self.tabBarController.view;
    CGRect  tabRect = self.tabBarController.tabBar.frame;
    if ([tab.subviews count] < 2) {
        return;
    }
    
    UIView *view;
    if ([[tab.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
        view = [tab.subviews objectAtIndex:1];
    } else {
        view = [tab.subviews objectAtIndex:0];
    }
    
    if (hidden) {
        view.frame = tab.bounds;
        tabRect.origin.y=[[UIScreen mainScreen]bounds].size.height+self.tabBarController.tabBar.frame.size.height;
    } else {
        view.frame = CGRectMake(tab.bounds.origin.x, tab.bounds.origin.y, tab.bounds.size.width, tab.bounds.size.height);
        tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.frame.size.height;
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame=tabRect;
    }completion:^(BOOL finished) {
        
    }];
    
}

//默认展示一个月内案例
- (void)inquireDefault{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    [lastMonthComps setMonth:-1];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    NSString *dateStr = [formatter stringFromDate:newdate];
    
    NSDictionary *dict = @{@"loanstartdatef":dateStr};
    [self getData:dict];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (!_defaultFlag) {
        [self inquireDefault];
        [self performSelector:@selector(delayMethods) withObject:nil afterDelay:2];
    }
}

- (void)delayMethods{
  _defaultFlag = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationItem.rightBarButtonItem.enabled = false;
    self.navigationItem.rightBarButtonItem.enabled = true;
}

@end
