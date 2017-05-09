//
//  TBSystemViewController.m
//  TonBright
//
//  Created by jie peng on 2017/5/2.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "TBSystemViewController.h"
#import "TBSystemTableViewCell.h"
#import "TBSystemMenu.h"
#import <YYModel.h>

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
    [self loadData];
    self.dataArray;
}

- (NSArray *)dataArray{
    
    if (!_dataArray) {
        //获取数据源
        NSArray *userfunctionArray = [TBAPPSetting shareAppSetting].userfunction;
        NSMutableArray *tempArray = [NSMutableArray array];

        //解析数据
        for (NSDictionary* dict in userfunctionArray) {
            if ([dict[@"ismenu"] intValue]) {
                
                TBSystemMenu *mu = [TBSystemMenu yy_modelWithDictionary:dict];
                
                [tempArray addObject:mu];
            }
        }
        _dataArray = tempArray.copy;
        
        
    }
    
    return _dataArray;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self)
    {
        
    }
    return self;
}


- (void)loadData {
    
    NSArray * secArr = @[@"我的好友", @"小学同学", @"初中同学", @"高中同学", @"大学同学"];
    NSArray * rowsArr = @[@(12), @(10), @(15), @(13), @(22)];
    
    for (int i = 0; i < secArr.count; i++) {
        
        NSMutableArray * friendArr = [[NSMutableArray alloc] init];
        for (int j = 0; j < [rowsArr[i] intValue]; j++) {
            
            [friendArr addObject:@(j)];
        }
        [self.sectionArr addObject:secArr[i]];
        [self.boolArr addObject:@NO];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //判断是否展开，如果未展开则返回0
    if ([self.boolArr[section] boolValue] == NO) {
        
        return 0;
    }else {
        
        return [self.dataArr[section] count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TBSystemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableSampleIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        
        if (indexPath.row < [self.dataArr[indexPath.section] count]) {
            //这里可以传入请求的数据，此方法可以根据自己的需求做更改
            [cell configCellWithData:nil row:indexPath.row];
        }
      
    }
    
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //创建header的view
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.pj_width, 50)];
    headerView.tag = 2016 + section;
    headerView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    
    //添加imageview
    UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
    
    //三目运算选择展开或者闭合时候的图标
    iv.image = [_boolArr[section] boolValue] ? [UIImage imageNamed:@"buddy_header_arrow_down"] : [UIImage imageNamed:@"buddy_header_arrow_right"];
    [headerView addSubview:iv];
    
    //添加标题label
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, self.tableView.pj_width - 100, 50)];
    label.text = self.sectionArr[section];
    [headerView addSubview:label];
    
    //添加分组人数和在线人数显示的label
    UILabel * labelR = [[UILabel alloc] initWithFrame:CGRectMake(self.tableView.pj_width - 60, 0, 60, 50)];
    labelR.textAlignment = NSTextAlignmentCenter;
    //这里小编把在线人数全部设置成了0，可以根据需求更改
    labelR.text = [NSString stringWithFormat:@"%d/%lu", 0, [self.dataArr[section] count]];
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
    
    return 70;
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


@end
