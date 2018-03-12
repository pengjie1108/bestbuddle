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
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"检索" style:UIBarButtonItemStylePlain target:self action:@selector(inquire)];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TBContractListCell class]) bundle:nil] forCellReuseIdentifier:TBContractListCellId];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
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
    __weak typeof(self) weakSelf = self;
    [self showProgressHUD];
    
    NSMutableDictionary *params = conditionDictionary.mutableCopy;
    [params setObject:[TBAPPSetting shareAppSetting].userid forKey:@"tokenuserid"];
    [params setObject:[TBAPPSetting shareAppSetting].tokenid forKey:@"tokenid"];
    [params setObject:[TBAPPSetting shareAppSetting].topcompanyid forKey:@"topcompanyid"];
    
    [self.manager POST:TBContractListURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* _Nullable responseObject) {
        NSString *stat = [NSString stringWithString:responseObject[@"stat"]];
        if (![stat intValue]) {
            [weakSelf showTextHUDWithMessage:@"查询成功"];
            weakSelf.contractLists = (NSArray<TBContractList*> *)[NSArray yy_modelArrayWithClass:[TBContractList class] json:responseObject[@"data"][@"caseinfolist"]];
            [weakSelf.tableView setSeparatorColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1]];
            [weakSelf.tableView reloadData];
            [responseObject writeToFile:@"/Users/jiepeng/Desktop/contractList.plist" atomically:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf showTextHUDWithMessage:@"查询失败"];
            TBLog(@"请求失败 - %@", error);
           }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return self.contractLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TBContractListCell *cell = [tableView dequeueReusableCellWithIdentifier:TBContractListCellId];
    cell.contractList = self.contractLists[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取caseid
    TBContractDetailController *contractDetailVC = [[TBContractDetailController alloc] init];
    contractDetailVC.caseid = self.contractLists[indexPath.row].caseid;
    [self.navigationController pushViewController:contractDetailVC animated:YES];
}

@end
