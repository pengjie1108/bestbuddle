//
//  TBInquireController.m
//  TonBright
//
//  Created by jie peng on 2018/2/22.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBInquireController.h"
#import "TBInquireDefaultCell.h"
#import "TBTimeTypeCell.h"
#import "TBContractListViewController.h"
#import "AbsenceDatePickerView.h"
#import "AbsenceTypePickerView.h"
#import "TBInquireData.h"
#import <YYModel.h>

@interface TBInquireController ()<TBTimeTypeCellDelegate>

@property (nonatomic,strong) NSArray <NSDictionary *> *itemNameDataArray;
//背景
@property (nonatomic, weak) UIView *bgView;
/** pickerView */
@property (nonatomic,strong)AbsenceDatePickerView *datePick;
@property (nonatomic,strong)AbsenceTypePickerView *typePick;

@property (nonatomic,strong) NSArray *casestatusArray;
@property (nonatomic,strong) NSArray *casetypeArray;
@end

@implementation TBInquireController

static NSString * const TBInquireDefaultCellId = @"TBInquireDefaultCell";
static NSString * const TBTimeTypeCellId = @"TBTimeTypeCell";

- (NSArray<NSDictionary *> *)itemNameDateArray{
    if (_itemNameDataArray == nil) {
        _itemNameDataArray = @[@{@"contractno":@"合同编号"},
                               @{@"customernm":@"客户名称"},
                               @{@"casestatus":@"状态"},
                               @{@"loanstartdatef":@"租赁期开始日from"},
                               @{@"loanstartdatet":@"租赁期开始日to"},
                               @{@"casetype":@"合同类型"},
                               @{@"loanconfirmdatef":@"起租确认日from"},
                               @{@"loanconfirmdatet":@"起租确认日to"},
                               @{@"companyid":@"出租人公司"},
                               @{@"settleamounttimef":@"结清日from"},
                               @{@"settleamounttimet":@"结清日to"},
                               @{@"salesusernm":@"销售担当"}];
    }
    return _itemNameDataArray;
}

- (NSArray *)casestatusArray{
    if (_casestatusArray == nil) {
        NSArray *array = @[@{@"parameterCode":@"1",@"parameterValue":@"编辑中"},
                               @{@"parameterCode":@"1.5",@"parameterValue":@"特批中"},
                               @{@"parameterCode":@"2",@"parameterValue":@"销售总监审批中"},
                               @{@"parameterCode":@"3",@"parameterValue":@"销售总监驳回"},
                               @{@"parameterCode":@"4",@"parameterValue":@"区域经理审批中"},
                               @{@"parameterCode":@"5",@"parameterValue":@"区域经理驳回"},
                               @{@"parameterCode":@"6",@"parameterValue":@"COO审批中"},
                               @{@"parameterCode":@"7",@"parameterValue":@"COO驳回"},
                               @{@"parameterCode":@"8",@"parameterValue":@"信审审批中"},
                               @{@"parameterCode":@"9",@"parameterValue":@"信审驳回"},
                               @{@"parameterCode":@"10",@"parameterValue":@"管理层审批中"},
                               @{@"parameterCode":@"11",@"parameterValue":@"管理层驳回"},
                               @{@"parameterCode":@"12",@"parameterValue":@"董事会审批中"},
                               @{@"parameterCode":@"13",@"parameterValue":@"董事会驳回"},
                               @{@"parameterCode":@"14",@"parameterValue":@"风控终审通过"},
                               @{@"parameterCode":@"15",@"parameterValue":@"已签约"},
                               @{@"parameterCode":@"16",@"parameterValue":@"已起租"},
                               @{@"parameterCode":@"20",@"parameterValue":@"结清财务审核中"},
                               @{@"parameterCode":@"21",@"parameterValue":@"结清风控审核中"},
                               @{@"parameterCode":@"22",@"parameterValue":@"结清风控审核通过"},
                               @{@"parameterCode":@"23",@"parameterValue":@"款项已结清"}];
        
       _casestatusArray = [NSArray yy_modelArrayWithClass:[AbsenceTypeEnumModel class] json:array];
    }
    return _casestatusArray;
}

- (NSArray *)casetypeArray{
    if (_casetypeArray == nil) {
        NSArray *array = @[@{@"parameterCode":@"T",@"parameterValue":@"标准方案"},
                           @{@"parameterCode":@"B",@"parameterValue":@"二手车方案"},
                           @{@"parameterCode":@"C",@"parameterValue":@"残值方案"},
                           @{@"parameterCode":@"D",@"parameterValue":@"建店融资"},
                           @{@"parameterCode":@"E",@"parameterValue":@"其他方案"},
                           @{@"parameterCode":@"Q",@"parameterValue":@"特快方案"},
                           @{@"parameterCode":@"H",@"parameterValue":@"新车回租"},
                           @{@"parameterCode":@"N",@"parameterValue":@"新标准方案"},
                           @{@"parameterCode":@"R",@"parameterValue":@"经营性租赁"}];
        
        _casetypeArray = [NSArray yy_modelArrayWithClass:[AbsenceTypeEnumModel class] json:array];
    }
    return _casetypeArray;
}

- (TBInquireData *)inquireData{
    
    if (!_inquireData) {
        _inquireData = [[TBInquireData alloc] init];
    }
    return _inquireData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"检索条件";
    self.tableView.separatorColor = [UIColor clearColor];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"查询" style:UIBarButtonItemStylePlain target:self action:@selector(inquire)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TBInquireDefaultCell class]) bundle:nil] forCellReuseIdentifier:TBInquireDefaultCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TBTimeTypeCell class]) bundle:nil] forCellReuseIdentifier:TBTimeTypeCellId];
}

//查询
- (void)inquire{
    TBLogFunc;
    //1.获取文本框的值
    NSArray *array = self.tableView.visibleCells;
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
    int i = 0;
    for (UITableViewCell *cell in array) {
        NSString *key = self.itemNameDataArray[i].allKeys[0];
        if ([cell isKindOfClass:[TBInquireDefaultCell class]]) {//有文本框,取出文本框内容
            TBInquireDefaultCell *defaultCell = (TBInquireDefaultCell *)cell;
            [tempDict setValue:defaultCell.itemContentTextField.text forKey:key];
        }else if([cell isKindOfClass:[TBTimeTypeCell class]]){
            TBTimeTypeCell *timeTypeCell = (TBTimeTypeCell *)cell;
            if (timeTypeCell.timeTitleKey.length) {
                [tempDict setValue:timeTypeCell.timeTitleKey forKey:key];
            }else{
            [tempDict setValue:timeTypeCell.timeTitle forKey:key];
            }
        }
        i ++;
     }
     self.conditionDictionary = tempDict;
   //2.页面跳转
    TBContractListViewController *contractListVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
    contractListVC.conditionDictionary = nil;
    contractListVC.conditionDictionary = self.conditionDictionary;
    if (self.delegate && [self.delegate respondsToSelector:@selector(getData:)]) {
        [self.delegate getData:self.conditionDictionary];
    }
    [self.navigationController popToViewController:contractListVC animated:YES];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemNameDateArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 2 || indexPath.row == 11){//常规cell
        TBInquireDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:TBInquireDefaultCellId];
        cell.itemNameLabel.text = [NSString stringWithFormat:@"%@",self.itemNameDateArray[indexPath.row].allValues[0]];
        if (self.conditionDictionary.count) {
            cell.itemContentTextField.text = [NSString stringWithFormat:@"%@",self.conditionDictionary[self.itemNameDateArray[indexPath.row].allKeys[0]]];
        }
        return cell;
    }else if ((indexPath.row == 2)||(indexPath.row == 5)||(indexPath.row == 8)) {//选项cell
        TBTimeTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:TBTimeTypeCellId];
        cell.headTitle = [NSString stringWithFormat:@"%@",self.itemNameDateArray[indexPath.row].allValues[0]];
        cell.pickType = 1;
        cell.delegate = self;
        cell.row = indexPath.row;
        if (indexPath.row == 2) {
            cell.timeTitle = self.inquireData.casestatus;
            cell.timeTitleKey = self.inquireData.casestatusKey;
        }else if(indexPath.row  == 5){
            cell.timeTitle = self.inquireData.casetype;
            cell.timeTitleKey = self.inquireData.casetypeKey;
        }else if(indexPath.row  == 8){
            cell.timeTitle = self.inquireData.casetype;
        }
        return cell;
    }else{//日期cell
        TBTimeTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:TBTimeTypeCellId];
        cell.headTitle = [NSString stringWithFormat:@"%@",self.itemNameDateArray[indexPath.row].allValues[0]];
        cell.pickType = 0;
        cell.delegate = self;
        cell.row = indexPath.row;
        if (indexPath.row  == 3) {
            cell.timeTitle = self.inquireData.loanstartdatef;
        }else if(indexPath.row  == 4){
            cell.timeTitle = self.inquireData.loanstartdatet;
        }else if(indexPath.row  == 6){
            cell.timeTitle = self.inquireData.loanconfirmdatef;
        }else if(indexPath.row  == 7){
            cell.timeTitle = self.inquireData.loanconfirmdatet;
        }else if(indexPath.row  == 9){
            cell.timeTitle = self.inquireData.settleamounttimef;
        }else if(indexPath.row  == 10){
            cell.timeTitle = self.inquireData.settleamounttimet;
        }
        return cell;
    }
}

//选择时间
- (void)timeTypeCellDidSelectTime:(NSInteger)row PickType:(NSInteger)pickType {
    [self.view endEditing:YES];
    //添加灰色透明背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SreenWidth, SreenHeight)];
    bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self.view.window addSubview:bgView];
    _bgView = bgView;
    //选择时间
    if (pickType == 0) {
        //添加时间选择器
        _datePick = [AbsenceDatePickerView absenceDatePickerView];
        _datePick.dateType = 1;
        _datePick.frame = CGRectMake(0, SreenHeight - 200, SreenWidth, 200);
        __weak typeof(self) weakSelf = self;
        _datePick.yesClick = ^ (NSString * str){
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (row == 3) {
                strongSelf.inquireData.loanstartdatef = str;
            }else if(row == 4) {
                strongSelf.inquireData.loanstartdatet = str;
            }else if(row == 6) {
                strongSelf.inquireData.loanconfirmdatef = str;
            }else if(row == 7) {
                strongSelf.inquireData.loanconfirmdatet = str;
            }else if(row == 9) {
                strongSelf.inquireData.settleamounttimef = str;
            }else if(row == 10) {
                strongSelf.inquireData.settleamounttimet = str;
            }
            
            [strongSelf.tableView reloadData];
            [strongSelf.bgView removeFromSuperview];
            [strongSelf.datePick removeFromSuperview];
        };
        _datePick.noClick = ^ (NSString * str){
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.bgView removeFromSuperview];
            [strongSelf.datePick removeFromSuperview];
        };
        [self.view.window addSubview:_datePick];
    } else if (pickType == 1) {
        //添加类型选择器
        _typePick = [AbsenceTypePickerView typePickView];
        _typePick.frame = CGRectMake(0, SreenHeight - 200, SreenWidth, 200);
        if (row == 2) {
            _typePick.workContent = self.casestatusArray;
        }else if (row == 5){
            _typePick.workContent = self.casetypeArray;
        }
        __weak typeof(self) weakSelf = self;
        _typePick.yesClick = ^(AbsenceTypeEnumModel * str) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (row == 2) {
                strongSelf.inquireData.casestatus = str.parameterValue;
                strongSelf.inquireData.casestatusKey = str.parameterCode;
            }else if (row == 5){
                strongSelf.inquireData.casetype = str.parameterValue;
                strongSelf.inquireData.casetypeKey = str.parameterCode;
            }
            
            [strongSelf.tableView reloadData];
            [strongSelf.bgView removeFromSuperview];
            [strongSelf.typePick removeFromSuperview];
        };
        _typePick.noClick = ^ (AbsenceTypeEnumModel * str) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.bgView removeFromSuperview];
            [strongSelf.typePick removeFromSuperview];
        };
        [self.view.window addSubview:_typePick];
    }
}



@end
