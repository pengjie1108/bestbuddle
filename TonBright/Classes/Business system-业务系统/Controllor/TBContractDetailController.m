//
//  TBContractDetailController.m
//  TonBright
//
//  Created by jie peng on 2018/2/24.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBContractDetailController.h"
#import "TBHTTPSessionManager.h"
#import <YYModel.h>
#import "TBContractDetailData.h"
#import "TBDetailBaseContentCell.h"
#import "TBCustomerBaseContentCell.h"
#import "TBCustomerCaseContentCell.h"
#import "TBCustomerData.h"
#import "TBObjectRelateDataCell.h"
#import "TBFinancingPlanDataCell.h"
#import "TBRepaymentplanCell.h"
#import "TBApproveHisCell.h"

@interface TBContractDetailController ()
/** 请求管理者 */
@property (nonatomic, weak) TBHTTPSessionManager *manager;
@property (nonatomic,strong) TBContractDetailData *detailData;
@property (nonatomic,strong) NSMutableArray * boolArr;
@property (nonatomic,strong) NSArray *sectionArray;
@property (nonatomic,strong) TBCustomerData *customerData;
@property (nonatomic,strong) NSArray *approvalHistoryArray;
@property(nonatomic,assign)CGFloat historyY;
@end

@implementation TBContractDetailController

/** sectionArray属性的懒加载 */
- (NSArray *)sectionArray{
    if (!_sectionArray) {
        _sectionArray = @[@"合同基本信息",@"客户基本信息",@"客户案件信息",@"物件相关信息",@"融资方案信息",@"还款计划",@"审批履历"];
    }
    return _sectionArray;
}

/** boolArr属性的懒加载 */
- (NSMutableArray *)boolArr {
    if (!_boolArr) {
        _boolArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.sectionArray.count; i ++) {
            [_boolArr addObject:@NO];
        }
    }
    return _boolArr;
}

/** manager属性的懒加载 */
- (TBHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [TBHTTPSessionManager manager];
    }
    return _manager;
}

/** 合同详细API */
//static NSString * const TBContractDetailURL = @"http://192.168.1.65/nbsst/api/api.caseinfo.get.php";
static NSString * const TBContractDetailURL = @"http://203.156.252.183:81/nbs/api/api.caseinfo.get.php";

/** 客户信息API */
//static NSString * const TBCustomerDetailURL = @"http://192.168.1.65/nbsst/api/api.custome.get.php";
static NSString * const TBCustomerDetailURL = @"http://203.156.252.183:81/nbs/api/api.custome.get.php";

/** cell的重用标识 */
static NSString * const TBDetailBaseContentCellId = @"TBDetailBaseContentCell";
static NSString * const TBCustomerBaseContentCellId = @"TBCustomerBaseContentCell";
static NSString * const TBCustomerCaseContentCellId = @"TBCustomerCaseContentCell";
static NSString * const TBObjectRelateDataCellId = @"TBObjectRelateDataCell";
static NSString * const TBFinancingPlanDataCellId = @"TBFinancingPlanDataCell";
static NSString * const TBRepaymentplanCellId = @"TBRepaymentplanCell";
static NSString * const TBApproveHisCellId = @"TBApproveHisCell";

- (id)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"合同详细";
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TBDetailBaseContentCell class]) bundle:nil] forCellReuseIdentifier:TBDetailBaseContentCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TBCustomerBaseContentCell class]) bundle:nil] forCellReuseIdentifier:TBCustomerBaseContentCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TBCustomerCaseContentCell class]) bundle:nil] forCellReuseIdentifier:TBCustomerCaseContentCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TBObjectRelateDataCell class]) bundle:nil] forCellReuseIdentifier:TBObjectRelateDataCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TBFinancingPlanDataCell class]) bundle:nil] forCellReuseIdentifier:TBFinancingPlanDataCellId];
    [self.tableView registerClass:[TBRepaymentplanCell class] forCellReuseIdentifier:TBRepaymentplanCellId];
    [self.tableView registerClass:[TBApproveHisCell class] forCellReuseIdentifier:TBApproveHisCellId];
    [self getCaseDatafrom:self.caseid];
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
}

//查询案件
- (void)getCaseDatafrom:(NSString *)caseid{
    __weak typeof(self) weakSelf = self;
    [self showProgressHUD];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:caseid forKey:@"caseid"];
    [params setObject:[TBAPPSetting shareAppSetting].userid forKey:@"tokenuserid"];
    [params setObject:[TBAPPSetting shareAppSetting].tokenid forKey:@"tokenid"];
    [params setObject:[TBAPPSetting shareAppSetting].topcompanyid forKey:@"topcompanyid"];
    
    [self.manager POST:TBContractDetailURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* _Nullable responseObject) {
        NSString *stat = [NSString stringWithString:responseObject[@"stat"]];
        if ([stat intValue] == 0) {
            [weakSelf showTextHUDWithMessage:@"查询成功"];
            weakSelf.detailData = [TBContractDetailData yy_modelWithJSON:responseObject[@"data"]];
            [weakSelf getCustomerDatafrom:self.detailData.customerid];
            weakSelf.approvalHistoryArray = [self.detailData.approvehis componentsSeparatedByString:@"---------------------------------------------------------------------------------------"];
            [weakSelf.tableView reloadData];
        }else{
            NSString *errorString = [NSString stringWithFormat:@"%@",responseObject[@"error"]];
            [weakSelf showTextHUDWithMessage:[NSString stringWithFormat:@"登录失败:%@",errorString]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf showTextHUDWithMessage:@"查询失败"];
        TBLog(@"请求失败 - %@", error);
    }];
}

//查询客户
- (void)getCustomerDatafrom:(NSString *)customerid{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:customerid forKey:@"customerid"];
    [params setObject:[TBAPPSetting shareAppSetting].userid forKey:@"tokenuserid"];
    [params setObject:[TBAPPSetting shareAppSetting].tokenid forKey:@"tokenid"];
    [params setObject:[TBAPPSetting shareAppSetting].topcompanyid forKey:@"topcompanyid"];
    
    [self.manager POST:TBCustomerDetailURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* _Nullable responseObject) {
        NSString *stat = [NSString stringWithString:responseObject[@"stat"]];
        if ([stat intValue] == 0) {
            weakSelf.customerData = [TBCustomerData yy_modelWithJSON:responseObject[@"data"]];
            [weakSelf.tableView reloadData];
        }else{
            NSString *errorString = [NSString stringWithFormat:@"%@",responseObject[@"error"]];
            [weakSelf showTextHUDWithMessage:[NSString stringWithFormat:@"登录失败:%@",errorString]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [weakSelf showTextHUDWithMessage:@"查询失败"];
        TBLog(@"请求失败 - %@", error);
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.boolArr[section] boolValue] == NO) {
        return 0;
    }else {
        if (section == 5) {
            return self.detailData.paymentplanlist.count;
        }else if (section == 6){
            return self.approvalHistoryArray.count - 1;
        }else{
        return 1;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.pj_width, 44)];
    headerView.tag = 20180 + section;
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView setUserInteractionEnabled:YES];
    
    UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
    iv.image = [_boolArr[section] boolValue] ? [UIImage imageNamed:@"buddy_header_arrow_down"] : [UIImage imageNamed:@"buddy_header_arrow_right"];
    [headerView addSubview:iv];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, self.tableView.pj_width - 100, 50)];
    label.text = self.sectionArray[section];
    label.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:label];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    [headerView addGestureRecognizer:tap];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        if (indexPath.section == 0) {
            TBDetailBaseContentCell *cell = [tableView dequeueReusableCellWithIdentifier:TBDetailBaseContentCellId];
            cell.contractDetailData = self.detailData;
            return cell;
        }else if (indexPath.section == 1){
            TBCustomerBaseContentCell *cell = [tableView dequeueReusableCellWithIdentifier:TBCustomerBaseContentCellId];
            cell.customerData = self.customerData;
            return cell;
        }else if (indexPath.section == 2){
            TBCustomerCaseContentCell *cell = [tableView dequeueReusableCellWithIdentifier:TBCustomerCaseContentCellId];
            cell.detailData = self.detailData;
            cell.customerData = self.customerData;
            return cell;
        }else if (indexPath.section == 3){
            TBObjectRelateDataCell *cell = [tableView dequeueReusableCellWithIdentifier:TBObjectRelateDataCellId];
            cell.detailData = self.detailData;
            return cell;
        }else if (indexPath.section == 4){
            TBFinancingPlanDataCell *cell = [tableView dequeueReusableCellWithIdentifier:TBFinancingPlanDataCellId];
            cell.detailData = self.detailData;
            return cell;
        }else if (indexPath.section == 5){
            TBRepaymentplanCell *cell = [tableView dequeueReusableCellWithIdentifier:TBRepaymentplanCellId];
            cell.planList = self.detailData.paymentplanlist[indexPath.row];
            return cell;
        }else if (indexPath.section == 6){
            TBApproveHisCell *cell = [tableView dequeueReusableCellWithIdentifier:TBApproveHisCellId];
            cell.approveHisString = self.approvalHistoryArray[indexPath.row];
            return cell;
        }else{
            return nil;
        }
}


- (void)tapGR:(UITapGestureRecognizer *)tapGR {
    
    NSInteger section = tapGR.view.tag - 20180;
    
    if ([_boolArr[section] boolValue] == YES) {
        [_boolArr replaceObjectAtIndex:section withObject:@NO];
    }else {
        [_boolArr replaceObjectAtIndex:section withObject:@YES];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5) {
        
    }
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
    CGRect  tabRect=self.tabBarController.tabBar.frame;
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

@end
