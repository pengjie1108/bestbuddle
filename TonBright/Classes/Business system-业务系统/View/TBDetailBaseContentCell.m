//
//  TBDetailBaseContentCell.m
//  TonBright
//
//  Created by jie peng on 2018/2/26.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBDetailBaseContentCell.h"
#import "TBContractDetailData.h"

@implementation TBDetailBaseContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContractDetailData:(TBContractDetailData *)contractDetailData{
    NSDictionary * invoicetypeDict = @{@"1":@"增票",@"2":@"普票"};
    NSDictionary * yesOrNoDict = @{@"1":@"是",@"2":@"否"};
    NSDictionary * customersourceDict = @{ @"1":@"自有客户",
                                           @"2":@"员工用车",
                                           @"3":@"渠道推荐",
                                           @"4":@"公司客户",
                                           @"5":@"授信客户",
                                           @"6":@"大客户"};
    NSDictionary * casetypeDict = @{ @"T":@"标准方案",
                                     @"B":@"二手车方案",
                                     @"C":@"残值方案",
                                     @"D":@"建店融资",
                                     @"E":@"其他方案",
                                     @"Q":@"特快方案",
                                     @"H":@"新车回租",
                                     @"N":@"新标准方案",
                                     @"W":@"网约车方案"
                                     };
    NSDictionary * casestatusDict = @{ @"1":@"编辑中",
                                     @"1.5":@"特批中",
                                     @"2":@"销售总监审批中",
                                     @"3":@"销售总监驳回",
                                     @"4":@"区域经理审批中",
                                     @"5":@"区域经理驳回",
                                     @"6":@"COO审批中",
                                     @"7":@"COO驳回",
                                     @"8":@"信审审批中",
                                     @"9":@"信审驳回",
                                     @"10":@"管理层审批中",
                                     @"11":@"管理层驳回",
                                     @"12":@"董事会审批中",
                                     @"13":@"董事会驳回",
                                     @"14":@"风控终审通过",
                                     @"15":@"已签约",
                                     @"16":@"已起租",
                                     @"20":@"结清财务审核中",
                                     @"21":@"结清风控审核中",
                                     @"22":@"结清风控审核通过",
                                     @"23":@"款项已结清"
                                     };
    NSDictionary * rentinvoicetypeDict = @{@"1":@"全增票",@"2":@"全普票",@"3":@"本普利增",@"4":@"本无利增"};
    _contractDetailData = contractDetailData;
    
    self.applyremarksLabel.text = contractDetailData.applyremarks;
    self.contractnoLabel.text = contractDetailData.contractno;
    self.companynmLabel.text = contractDetailData.companynm;
    self.casetypeLabel.text = [casetypeDict objectForKey:contractDetailData.casetype];
    self.customernmLabel.text = contractDetailData.customernm;
    self.maincontractnoLabel.text = contractDetailData.maincontractno;
    self.customersourceLabel.text = [customersourceDict objectForKey:contractDetailData.customersource];
    self.invoicetypeLabel.text = [invoicetypeDict objectForKey:contractDetailData.invoicetype];
    self.casestatusLabel.text = [casestatusDict objectForKey:[NSString stringWithFormat:@"%ld",(long)contractDetailData.casestatus]];
    self.frontvendornmLabel.text = contractDetailData.frontvendornm;
    self.rentinvoicetypeLabel.text = [rentinvoicetypeDict objectForKey:contractDetailData.rentinvoicetype];
    self.settleinvflgLabel.text = [yesOrNoDict objectForKey:contractDetailData.settleinvflg];

}

@end
