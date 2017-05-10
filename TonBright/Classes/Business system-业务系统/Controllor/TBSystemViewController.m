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

@interface TBSystemViewController ()

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) NSArray *dataArr;

@property (nonatomic, strong) NSMutableDictionary * dataDic;
//每组的标题
@property (nonatomic, strong) NSMutableArray * sectionArr;
//存储是否展开的BOOL值
@property (nonatomic, strong) NSMutableArray * boolArr;

@end

static NSString *tableSampleIdentifier = @"tableSampleIdentifier";

@implementation TBSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"业务系统";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableSampleIdentifier];
    [self.dataArray writeToFile:@"/Users/jiepeng/Desktop/menus.plist" atomically:YES];
//    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (NSArray *)dataArray{
    
    if (!_dataArray) {
        //获取数据源
        NSArray *userfunctionArray = [TBAPPSetting shareAppSetting].userfunction;
        NSMutableArray *zhuBiaoArray = [NSMutableArray array];
        NSMutableArray *anJianArray = [NSMutableArray array];
        NSMutableArray *heTongArray = [NSMutableArray array];
        NSMutableArray *zhiXingArray = [NSMutableArray array];
        NSMutableArray *yueDuArray = [NSMutableArray array];
        NSMutableArray *baoBiaoArray = [NSMutableArray array];
        NSMutableArray *xiTongSZArray = [NSMutableArray array];
        NSMutableArray *tempArray = [NSMutableArray array];
        NSMutableArray *nmArray = [NSMutableArray array];
        
        //解析数据
        for (NSDictionary* dict in userfunctionArray) {
            if ([dict[@"ismenu"] intValue]) {
            NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
                int menuorder = [dict[@"menuorder"] intValue] - 1;
                [self.boolArr addObject:@NO];
                if (menuorder == 0) {
                    [zhuBiaoArray addObject:dict];
                    [tempDict setValue:zhuBiaoArray forKey:@"functions"];
                    [tempDict setValue:dict[@"menu"] forKey:@"name"];
                    [tempArray setObject:tempDict atIndexedSubscript:menuorder];
                }else if (menuorder == 1){
                    [anJianArray addObject:dict];
                    [tempDict setValue:anJianArray forKey:@"functions"];
                    [tempDict setValue:dict[@"menu"] forKey:@"name"];
                    [tempArray setObject:tempDict atIndexedSubscript:menuorder];
                }else if (menuorder == 2){
                    [heTongArray addObject:dict];
                    [tempDict setValue:heTongArray forKey:@"functions"];
                    [tempDict setValue:dict[@"menu"] forKey:@"name"];
                    [tempArray setObject:tempDict atIndexedSubscript:menuorder];
                }else if (menuorder == 3){
                    [zhiXingArray addObject:dict];
                    [tempDict setValue:zhiXingArray forKey:@"functions"];
                    [tempDict setValue:dict[@"menu"] forKey:@"name"];
                    [tempArray setObject:tempDict atIndexedSubscript:menuorder];
                }else if (menuorder == 4){
                    [yueDuArray addObject:dict];
                    [tempDict setValue:yueDuArray forKey:@"functions"];
                    [tempDict setValue:dict[@"menu"] forKey:@"name"];
                    [tempArray setObject:tempDict atIndexedSubscript:menuorder];
                }else if (menuorder == 5){
                    [baoBiaoArray addObject:dict];
                    [tempDict setValue:baoBiaoArray forKey:@"functions"];
                    [tempDict setValue:dict[@"menu"] forKey:@"name"];
                    [tempArray setObject:tempDict atIndexedSubscript:menuorder];
                }else if (menuorder == 98){
                    menuorder = 6;
                    [xiTongSZArray addObject:dict];
                    [tempDict setValue:xiTongSZArray forKey:@"functions"];
                    [tempDict setValue:dict[@"menu"] forKey:@"name"];
                    [tempArray setObject:tempDict atIndexedSubscript:menuorder];
                }
            }
        }
        for (NSDictionary *dict in tempArray) {
            [nmArray addObject:[TBSystemMenu systemMenuWithDict:dict]];
        }
        _dataArray = nmArray;
    }
    
    return _dataArray;
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
    
    //判断是否展开，如果未展开则返回0
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
    
    //创建header的view
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.pj_width, 50)];
    headerView.tag = 2016 + section;
    headerView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [headerView setUserInteractionEnabled:YES];
    //添加imageview
    UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
    
    //三目运算选择展开或者闭合时候的图标
    iv.image = [_boolArr[section] boolValue] ? [UIImage imageNamed:@"buddy_header_arrow_down"] : [UIImage imageNamed:@"buddy_header_arrow_right"];
    [headerView addSubview:iv];
    
    //添加标题label
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, self.tableView.pj_width - 100, 50)];
    TBSystemMenu *systemMenu = self.dataArray[section];

    label.text = systemMenu.name;
    [headerView addSubview:label];
    
    //添加分组人数和在线人数显示的label
    UILabel * labelR = [[UILabel alloc] initWithFrame:CGRectMake(self.tableView.pj_width - 60, 0, 60, 50)];
    labelR.textAlignment = NSTextAlignmentCenter;
    //这里小编把在线人数全部设置成了0，可以根据需求更改
    labelR.text = [NSString stringWithFormat:@"%lu",systemMenu.functions.count ];
    [headerView addSubview:labelR];
    
    //添加轻扣手势
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


- (void)tapGR:(UITapGestureRecognizer *)tapGR {
    //获取section
    NSInteger section = tapGR.view.tag - 2016;
    //判断改变bool值
    if ([_boolArr[section] boolValue] == YES) {
        [_boolArr replaceObjectAtIndex:section withObject:@NO];
    }else {
        [_boolArr replaceObjectAtIndex:section withObject:@YES];
    }
    //刷新某个section
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
}


- (NSMutableArray *)boolArr {
    
    if (!_boolArr) {
        
        _boolArr = [[NSMutableArray alloc] init];
    }
    return _boolArr;
}

@end
