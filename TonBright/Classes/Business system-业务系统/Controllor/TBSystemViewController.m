//
//  TBSystemViewController.m
//  TonBright
//
//  Created by jie peng on 2017/5/2.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "TBSystemViewController.h"
#import "TBSystemMenu.h"
#import "TBFunction.h"
#import "TBContractListViewController.h"

@interface TBSystemViewController ()

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic, strong) NSMutableArray * boolArr;

@end

static NSString *tableSampleIdentifier = @"tableSampleIdentifier";


@implementation TBSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"业务系统";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableSampleIdentifier];
//    [self.dataArray writeToFile:@"/Users/jiepeng/Desktop/menus.plist" atomically:YES];
}

- (id)init{
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.boolArr[section] boolValue] == NO) {
        
        return 0;
        
    }else {
        
        TBSystemMenu *systemMenu = self.dataArray[section];
        
        return systemMenu.functions.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableSampleIdentifier forIndexPath:indexPath];
    TBSystemMenu *systemMenu = self.dataArray[indexPath.section];
    TBFunction *functionMenu = systemMenu.functions[indexPath.row];
    cell.textLabel.text = functionMenu.functionnm;
    
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.pj_width, 50)];
    headerView.tag = 2017 + section;
    headerView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [headerView setUserInteractionEnabled:YES];

    UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
    
    iv.image = [_boolArr[section] boolValue] ? [UIImage imageNamed:@"buddy_header_arrow_down"] : [UIImage imageNamed:@"buddy_header_arrow_right"];
    [headerView addSubview:iv];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, self.tableView.pj_width - 100, 50)];
    TBSystemMenu *systemMenu = self.dataArray[section];

    label.text = systemMenu.name;
    [headerView addSubview:label];
    
    UILabel * labelR = [[UILabel alloc] initWithFrame:CGRectMake(self.tableView.pj_width - 60, 0, 60, 50)];
    labelR.textAlignment = NSTextAlignmentCenter;
    labelR.text = [NSString stringWithFormat:@"%lu",systemMenu.functions.count ];
    [headerView addSubview:labelR];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    [headerView addGestureRecognizer:tap];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}


#pragma 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取URL
    TBSystemMenu *systemMenu = self.dataArray[indexPath.section];
    TBFunction *functionMenu = systemMenu.functions[indexPath.row];
    NSString *url = functionMenu.functionurl;
    TBLog(@"%@",url);
    
    if ([url isEqualToString:@"t_contract_check_list.php"]) {
        TBContractListViewController *contractListVc = [[TBContractListViewController alloc] init];
        contractListVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:contractListVc animated:YES];
    }
    
}


- (void)tapGR:(UITapGestureRecognizer *)tapGR {

    NSInteger section = tapGR.view.tag - 2017;
    
    if ([_boolArr[section] boolValue] == YES) {
        [_boolArr replaceObjectAtIndex:section withObject:@NO];
    }else {
        [_boolArr replaceObjectAtIndex:section withObject:@YES];
    }

    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
}


- (NSMutableArray *)boolArr {
    
    if (!_boolArr) {
        
        _boolArr = [[NSMutableArray alloc] init];
    }
    return _boolArr;
}

- (NSArray *)dataArray{
    
    if (!_dataArray) {
        //获取数据源
        NSArray *userfunctionArray = [TBAPPSetting shareAppSetting].userfunction;
        [userfunctionArray writeToFile:@"/Users/jiepeng/Desktop/userfunctions.plist" atomically:YES];
        NSMutableArray *zhuBiaoArray = [NSMutableArray array];
        NSMutableArray *anJianArray = [NSMutableArray array];
        NSMutableArray *heTongArray = [NSMutableArray array];
        NSMutableArray *zhiXingArray = [NSMutableArray array];
        NSMutableArray *yueDuArray = [NSMutableArray array];
        NSMutableArray *baoBiaoArray = [NSMutableArray array];
        NSMutableArray *xiTongSZArray = [NSMutableArray array];
        NSMutableArray *tempArray = [NSMutableArray array];
        NSMutableArray *nmArray = [NSMutableArray array];
        NSMutableDictionary *zhuBiaoDict = [NSMutableDictionary dictionary];
        NSMutableDictionary *anJianDict = [NSMutableDictionary dictionary];
        NSMutableDictionary *heTongADict = [NSMutableDictionary dictionary];
        NSMutableDictionary *zhiXingDict = [NSMutableDictionary dictionary];
        NSMutableDictionary *yueDuDict = [NSMutableDictionary dictionary];
        NSMutableDictionary *baoBiaoDict = [NSMutableDictionary dictionary];
        NSMutableDictionary *xiTongSZDict = [NSMutableDictionary dictionary];
        //解析数据
        for (NSDictionary* dict in userfunctionArray) {
            if ([dict[@"ismenu"] intValue]) {
                int menuorder = [dict[@"menuorder"] intValue] - 1;
                if (menuorder == 0) {
                    [zhuBiaoArray addObject:dict];
                    [zhuBiaoDict setValue:zhuBiaoArray forKey:@"functions"];
                    [zhuBiaoDict setValue:dict[@"menu"] forKey:@"name"];
                }else if (menuorder == 1){
                    [anJianArray addObject:dict];
                    [anJianDict setValue:anJianArray forKey:@"functions"];
                    [anJianDict setValue:dict[@"menu"] forKey:@"name"];
                }else if (menuorder == 2){
                    [heTongArray addObject:dict];
                    [heTongADict setValue:heTongArray forKey:@"functions"];
                    [heTongADict setValue:dict[@"menu"] forKey:@"name"];
                }else if (menuorder == 3){
                    [zhiXingArray addObject:dict];
                    [zhiXingDict setValue:zhiXingArray forKey:@"functions"];
                    [zhiXingDict setValue:dict[@"menu"] forKey:@"name"];
                }else if (menuorder == 4){
                    [yueDuArray addObject:dict];
                    [yueDuDict setValue:yueDuArray forKey:@"functions"];
                    [yueDuDict setValue:dict[@"menu"] forKey:@"name"];
                }else if (menuorder == 5){
                    [baoBiaoArray addObject:dict];
                    [baoBiaoDict setValue:baoBiaoArray forKey:@"functions"];
                    [baoBiaoDict setValue:dict[@"menu"] forKey:@"name"];
                }else if (menuorder == 98){
                    menuorder = 6;
                    [xiTongSZArray addObject:dict];
                    [xiTongSZDict setValue:xiTongSZArray forKey:@"functions"];
                    [xiTongSZDict setValue:dict[@"menu"] forKey:@"name"];
                }
            }
        }
        if (zhuBiaoDict.count) {
            [tempArray addObject:zhuBiaoDict];
        }
        if (anJianDict.count) {
            [tempArray addObject:anJianDict];
        }
        if (heTongADict.count) {
            [tempArray addObject:heTongADict];
        }
        if (zhiXingDict.count) {
            [tempArray addObject:zhiXingDict];
        }
        if (yueDuDict.count) {
            [tempArray addObject:yueDuDict];
        }
        if (baoBiaoDict.count) {
            [tempArray addObject:baoBiaoDict];
        }
        if (xiTongSZDict.count) {
            [tempArray addObject:xiTongSZDict];
        }
        
        for (NSDictionary *dict in tempArray) {
            [self.boolArr addObject:@NO];
            [nmArray addObject:[TBSystemMenu systemMenuWithDict:dict]];
        }
        _dataArray = nmArray;
    }
    
    return _dataArray;
}

@end
