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
#import "TBHTTPSessionManager.h"
#import "TBCompanyData.h"
#import "HelpObject.h"

@interface TBInquireController ()<TBTimeTypeCellDelegate>

@property (nonatomic,strong) NSArray <NSDictionary *> *itemNameDataArray;
//背景
@property (nonatomic, weak) UIView *bgView;
/** pickerView */
@property (nonatomic,strong)AbsenceDatePickerView *datePick;
@property (nonatomic,strong)AbsenceTypePickerView *typePick;

@property (nonatomic,strong) NSArray *casestatusArray;
@property (nonatomic,strong) NSArray *casetypeArray;
@property (nonatomic,strong) NSArray *companyListArray;

/** 请求管理者 */
@property (nonatomic, weak) TBHTTPSessionManager *manager;

@end

@implementation TBInquireController

static NSString * const TBInquireDefaultCellId = @"TBInquireDefaultCell";
static NSString * const TBTimeTypeCellId = @"TBTimeTypeCell";

//static NSString * const TBCompanyListURL = @"http://192.168.1.65/nbsst/api/api.company.list.php";
static NSString * const TBCompanyListURL = @"http://203.156.252.183:81/nbs/api/api.company.list.php";

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
        NSArray *array = @[@{@"parameterCode":@"",@"parameterValue":@"请选择合同状态"},
                           @{@"parameterCode":@"1",@"parameterValue":@"编辑中"},
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
        NSArray *array = @[@{@"parameterCode":@"",@"parameterValue":@"请选择合同类型"},
                           @{@"parameterCode":@"T",@"parameterValue":@"标准方案"},
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

/** manager属性的懒加载 */
- (TBHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [TBHTTPSessionManager manager];
    }
    return _manager;
}

- (TBInquireData *)inquireData{
    NSString *tmpInqureStr = [[TBAPPSetting shareAppSetting] inquireDataStrFotUserid:[TBAPPSetting shareAppSetting].userid];
    if (!_inquireData) {
        //判断是否有历史数据
        if ([HelpObject isBlankString:tmpInqureStr]) {
            _inquireData = [[TBInquireData alloc] init];
        }else {
            _inquireData = [TBInquireData yy_modelWithJSON:tmpInqureStr];
        }
    }
    return _inquireData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"检索条件";
    self.tableView.separatorColor = [UIColor clearColor];
    [self getData];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(inquire)];
    [rightBtn setTintColor:[UIColor blackColor]];
    [rightBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName,nil] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TBInquireDefaultCell class]) bundle:nil] forCellReuseIdentifier:TBInquireDefaultCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TBTimeTypeCell class]) bundle:nil] forCellReuseIdentifier:TBTimeTypeCellId];
}

- (void)getData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[TBAPPSetting shareAppSetting].userid forKey:@"tokenuserid"];
    [params setObject:[TBAPPSetting shareAppSetting].tokenid forKey:@"tokenid"];
    [params setObject:[TBAPPSetting shareAppSetting].topcompanyid forKey:@"topcompanyid"];
    __weak typeof(self) weakSelf = self;
    [self.manager POST:TBCompanyListURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* _Nullable responseObject) {
        NSString *stat = [NSString stringWithString:responseObject[@"stat"]];
        if ([stat intValue] == 0) {
            NSMutableArray *companyArray = [NSArray yy_modelArrayWithClass:[TBCompanyData class]json:responseObject[@"data"][@"companylist"]].mutableCopy;
            TBCompanyData *tmpData = [TBCompanyData new];
            tmpData.companyid = @"";
            tmpData.companynm = @"请选择出租人公司";
            tmpData.isvalid = @"1";
            [companyArray insertObject:tmpData atIndex:0];
            NSMutableArray *tempArray = [NSMutableArray array];
            for (TBCompanyData *data in companyArray) {
                if (data.isvalid){
                 [tempArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:data.companynm,@"parameterValue",data.companyid,@"parameterCode", nil]];
              }
            }
            weakSelf.companyListArray = [NSArray yy_modelArrayWithClass:[AbsenceTypeEnumModel class] json:tempArray];
            [weakSelf.tableView reloadData];
        }else{
            NSString *errorString = [NSString stringWithFormat:@"%@",responseObject[@"error"]];
            [weakSelf showTextHUDWithMessage:[NSString stringWithFormat:@"登录失败:%@",errorString]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TBLog(@"请求失败 - %@", error);
    }];
}

// MARK: - 查询按钮点击事件---------------------------------
//查询
- (void)inquire{
    
    //存储模型数据--------存储当前用户对应的,防止使用其他账号也能看到相同数据-------------
    NSString *inqureStr = [self.inquireData yy_modelToJSONString];
    [[TBAPPSetting shareAppSetting] setInquireDataStr:[HelpObject changeNull:inqureStr] foruserId:[TBAPPSetting shareAppSetting].userid];
    
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
                [tempDict setValue:timeTypeCell.timeTitleKey forKey:key];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
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
            cell.timeTitle =  [HelpObject isBlankString:self.inquireData.casestatus] ? @"请选择合同状态" : self.inquireData.casestatus;
            cell.timeTitleKey = self.inquireData.casestatusKey;
        }else if(indexPath.row  == 5){
            cell.timeTitle =  [HelpObject isBlankString:self.inquireData.casetype] ? @"请选择合同类型" : self.inquireData.casetype;
            cell.timeTitleKey =  self.inquireData.casetypeKey;
        }else if(indexPath.row  == 8){
            cell.timeTitle = [HelpObject isBlankString:self.inquireData.companynm] ? @"请选择出租人公司" : self.inquireData.companynm;
            cell.timeDetailL.font = [HelpObject isBlankString:self.inquireData.companynm] ?[UIFont systemFontOfSize:14] :[UIFont systemFontOfSize:11];
            cell.timeTitleKey = self.inquireData.companynmKey;
        }
        return cell;
    }else{//日期cell
        TBTimeTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:TBTimeTypeCellId];
        cell.headTitle = [NSString stringWithFormat:@"%@",self.itemNameDateArray[indexPath.row].allValues[0]];
        cell.pickType = 0;
        cell.delegate = self;
        cell.row = indexPath.row;
        if (indexPath.row  == 3) {
            cell.timeTitle = [HelpObject isBlankString:self.inquireData.loanstartdatef] ? @"请选择租赁开始日期from" : self.inquireData.loanstartdatef;
            cell.timeTitleKey = self.inquireData.loanstartdatef;
        }else if(indexPath.row  == 4){
            cell.timeTitle = [HelpObject isBlankString:self.inquireData.loanstartdatet] ? @"请选择租赁开始日期to" :self.inquireData.loanstartdatet;
            cell.timeTitleKey = self.inquireData.loanstartdatet;
        }else if(indexPath.row  == 6){
            cell.timeTitle = [HelpObject isBlankString:self.inquireData.loanconfirmdatef] ? @"请选择起租确认日期from" :self.inquireData.loanconfirmdatef;
            cell.timeTitleKey = self.inquireData.loanconfirmdatef;
        }else if(indexPath.row  == 7){
            cell.timeTitle = [HelpObject isBlankString:self.inquireData.loanconfirmdatet] ? @"请选择起租确认日期to" :self.inquireData.loanconfirmdatet;
            cell.timeTitleKey = self.inquireData.loanconfirmdatet;
        }else if(indexPath.row  == 9){
            cell.timeTitle = [HelpObject isBlankString:self.inquireData.settleamounttimef] ? @"请选择结清日期from" :self.inquireData.settleamounttimef;
            cell.timeTitleKey = self.inquireData.settleamounttimef;
        }else if(indexPath.row  == 10){
            cell.timeTitle = [HelpObject isBlankString:self.inquireData.settleamounttimet] ? @"请选择结清日期to" :self.inquireData.settleamounttimet;
            cell.timeTitleKey = self.inquireData.settleamounttimet;
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
        }else if (row == 8){
            _typePick.workContent = self.companyListArray;
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
            }else if (row == 8){
                strongSelf.inquireData.companynm = str.parameterValue;
                strongSelf.inquireData.companynmKey = str.parameterCode;
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
