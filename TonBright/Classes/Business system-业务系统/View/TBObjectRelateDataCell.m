//
//  TBObjectRelateDataCell.m
//  TonBright
//
//  Created by jie peng on 2018/3/1.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBObjectRelateDataCell.h"
#import "TBContractDetailData.h"

@interface TBObjectRelateDataCell()
@property (weak, nonatomic) IBOutlet UILabel *vendornmLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandnmLabel;
@property (weak, nonatomic) IBOutlet UILabel *typenmLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactData4sLabel;
@property (weak, nonatomic) IBOutlet UILabel *address4sLabel;
@property (weak, nonatomic) IBOutlet UILabel *platenoLabel;
@property (weak, nonatomic) IBOutlet UILabel *chejianoLabel;
@property (weak, nonatomic) IBOutlet UILabel *enginenoLabel;
@property (weak, nonatomic) IBOutlet UILabel *isgpsinstallLabel;
@property (weak, nonatomic) IBOutlet UILabel *insuranceyearLabel;
@property (weak, nonatomic) IBOutlet UILabel *hasplateLabel;
@property (weak, nonatomic) IBOutlet UILabel *platesideLabel;
@property (weak, nonatomic) IBOutlet UILabel *guidepriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *quotedpriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *gouzhishuiLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuanghuangfeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *baoxianfeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *paizhaorentLabel;
@property (weak, nonatomic) IBOutlet UILabel *baoyangfeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *dabaopriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *paizhaoshouxufeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *obdamountLabel;
@property (weak, nonatomic) IBOutlet UILabel *paizhaotypeLabel;

@end

@implementation TBObjectRelateDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDetailData:(TBContractDetailData *)detailData{
    
    _detailData = detailData;
    
    NSDictionary * isgpsinstallDict = @{@"1":@"不安装",@"2":@"一固一移",@"3":@"一移",@"4":@"四移",@"5":@"二固二移"};
    NSDictionary * insuranceyearDict = @{@"1":@"1年",@"2":@"多年"};
    NSDictionary * hasDict = @{@"1":@"有",@"2":@"无"};
    NSDictionary * platesideDict = @{@"1":@"同辉",@"2":@"4S店"};
    NSDictionary * paizhaotypeDict = @{@"1":@"自有",@"2":@"沪C自有",@"3":@"1个月租赁",@"4":@"3个月租赁",@"5":@"6个月租赁",@"7":@"收取牌租保证金"};
    
    self.vendornmLabel.text = detailData.vendornm;
    self.brandnmLabel.text = detailData.brandnm;
    self.typenmLabel.text = detailData.typenm;
    self.colorLabel.text = [NSString stringWithFormat:@"外:%@ 内:%@",detailData.outercolor,detailData.innercolor];
    self.contactData4sLabel.text = [NSString stringWithFormat:@"4S店联系人姓名:%@\n4S店联系人电话:%@",detailData.contactnm4s,detailData.contactphone4s];
    self.address4sLabel.text = detailData.address4s;
    self.platenoLabel.text = detailData.plateno;
    self.chejianoLabel.text = detailData.chejiano;
    self.enginenoLabel.text = detailData.engineno;
    self.isgpsinstallLabel.text = [isgpsinstallDict objectForKey: detailData.isgpsinstall];
    self.insuranceyearLabel.text = [insuranceyearDict objectForKey: detailData.insuranceyear];
    self.hasplateLabel.text = [hasDict objectForKey: detailData.hasplate];
    self.platesideLabel.text = [platesideDict objectForKey: detailData.plateside];
    self.guidepriceLabel.text = [NSString stringWithFormat:@"¥%@",detailData.guideprice];
    self.quotedpriceLabel.text = [NSString stringWithFormat:@"¥%@",detailData.quotedprice];
    self.gouzhishuiLabel.text = [NSString stringWithFormat:@"¥%@",detailData.gouzhishui];
    if (detailData.gouzhidaiflg.intValue == 1) {//购置税代收代付
    self.gouzhishuiLabel.text = [NSString stringWithFormat:@"¥%@(代收代付)",detailData.gouzhishui];
    }
    self.zhuanghuangfeiLabel.text = [NSString stringWithFormat:@"¥%@",detailData.zhuanghuangfei];
    self.baoxianfeiLabel.text = [NSString stringWithFormat:@"¥%@",detailData.baoxianfei];
    if (detailData.baoxiandaiflg.intValue == 1) {//保险费代收代付
    self.baoxianfeiLabel.text = [NSString stringWithFormat:@"¥%@(代收代付)",detailData.baoxianfei];
    }
    self.paizhaorentLabel.text = [NSString stringWithFormat:@"¥%@",detailData.paizhaorent];
    self.baoyangfeiLabel.text = [NSString stringWithFormat:@"¥%@",detailData.baoyangfei];
    self.dabaopriceLabel.text = [NSString stringWithFormat:@"¥%@",detailData.dabaoprice];
    self.paizhaoshouxufeiLabel.text = [NSString stringWithFormat:@"¥%@",detailData.paizhaoshouxufei];
    self.obdamountLabel.text = [NSString stringWithFormat:@"¥%@",detailData.obdamount];
    self.paizhaotypeLabel.text = [paizhaotypeDict objectForKey: detailData.paizhaotype];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
