//
//  TBFinancingPlanDataCell.m
//  TonBright
//
//  Created by jie peng on 2018/3/6.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBFinancingPlanDataCell.h"
#import "TBContractDetailData.h"

@interface TBFinancingPlanDataCell()

@property (weak, nonatomic) IBOutlet UILabel *periodsLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodmonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *shoufurateLabel;
@property (weak, nonatomic) IBOutlet UILabel *shoufuamountLabel;
@property (weak, nonatomic) IBOutlet UILabel *baozhengjinrateLabel;
@property (weak, nonatomic) IBOutlet UILabel *baozhengjinamountLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouxufeirateLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouxufeiamountLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainrateLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainamountLabel;
@property (weak, nonatomic) IBOutlet UILabel *agencyfeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhongjiefeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *fanyongapplyamtLabel;
@property (weak, nonatomic) IBOutlet UILabel *fanyongrealamtLabel;
@property (weak, nonatomic) IBOutlet UILabel *keepamountLabel;
@property (weak, nonatomic) IBOutlet UILabel *fanliLabel;
@property (weak, nonatomic) IBOutlet UILabel *youhuiLabel;
@property (weak, nonatomic) IBOutlet UILabel *liugoupriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhengxinfeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *shenqingfeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearrateLabel;
@property (weak, nonatomic) IBOutlet UILabel *xubaoyajinLabel;
@property (weak, nonatomic) IBOutlet UILabel *taxdiffLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouxufeicnmLabel;
@property (weak, nonatomic) IBOutlet UILabel *loanprincipalLabel;
@property (weak, nonatomic) IBOutlet UILabel *irrLabel;
@property (weak, nonatomic) IBOutlet UILabel *signamountLabel;
@property (weak, nonatomic) IBOutlet UILabel *rentamountLabel;
@property (weak, nonatomic) IBOutlet UILabel *signpaymentLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymenttermLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstprincipalLabel;
@property (weak, nonatomic) IBOutlet UILabel *principalLabel;
@property (weak, nonatomic) IBOutlet UILabel *grossprofitLabel;
@property (weak, nonatomic) IBOutlet UILabel *useamountLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *loanstartdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *staticprofitLabel;

@end

@implementation TBFinancingPlanDataCell

- (void)setDetailData:(TBContractDetailData *)detailData{
    
    _detailData = detailData;
    
    self.periodsLabel.text = detailData.periods;
    self.periodmonthLabel.text = detailData.periodmonth;
    self.shoufurateLabel.text = [NSString stringWithFormat:@"%.2f%%",detailData.shoufurate.floatValue];
    self.shoufuamountLabel.text = [NSString stringWithFormat:@"¥%@",detailData.shoufuamount];
    self.baozhengjinrateLabel.text = [NSString stringWithFormat:@"%.2f%%",detailData.baozhengjinrate.floatValue];
    self.baozhengjinamountLabel.text = [NSString stringWithFormat:@"¥%@",detailData.baozhengjinamount];
    self.shouxufeirateLabel.text = [NSString stringWithFormat:@"%.2f%%",detailData.shouxufeirate.floatValue];
    self.shoufuamountLabel.text = [NSString stringWithFormat:@"¥%@",detailData.shoufuamount];
    self.baozhengjinrateLabel.text = [NSString stringWithFormat:@"%.2f%%",detailData.baozhengjinrate.floatValue];
    self.baozhengjinamountLabel.text = [NSString stringWithFormat:@"¥%@",detailData.baozhengjinamount];
    self.shouxufeirateLabel.text = [NSString stringWithFormat:@"%.2f%%",detailData.shouxufeirate.floatValue];
    self.shouxufeiamountLabel.text = [NSString stringWithFormat:@"¥%@",detailData.shouxufeiamount];
    self.remainrateLabel.text = [NSString stringWithFormat:@"%.2f%%",detailData.remainrate.floatValue];
    self.remainamountLabel.text = [NSString stringWithFormat:@"¥%@",detailData.remainamount];
    self.agencyfeiLabel.text = [NSString stringWithFormat:@"¥%@",detailData.agencyfei];
    self.zhongjiefeiLabel.text = [NSString stringWithFormat:@"¥%@",detailData.zhongjiefei];
    self.fanyongapplyamtLabel.text = [NSString stringWithFormat:@"¥%@",detailData.fanyongapplyamt];
    self.fanyongrealamtLabel.text = [NSString stringWithFormat:@"¥%@",detailData.fanyongrealamt];
    self.keepamountLabel.text = [NSString stringWithFormat:@"¥%@",detailData.keepamount];
    self.fanliLabel.text = [NSString stringWithFormat:@"¥%@",detailData.fanli];
    self.youhuiLabel.text = [NSString stringWithFormat:@"¥%@",detailData.youhui];
    self.liugoupriceLabel.text = [NSString stringWithFormat:@"¥%@",detailData.liugouprice];
    self.zhengxinfeiLabel.text = [NSString stringWithFormat:@"¥%@",detailData.zhengxinfei];
    self.shenqingfeiLabel.text = [NSString stringWithFormat:@"¥%@",detailData.shenqingfei];
    self.yearrateLabel.text = [NSString stringWithFormat:@"%.3f%%",detailData.yearrate.floatValue];
    self.xubaoyajinLabel.text = [NSString stringWithFormat:@"¥%@",detailData.xubaoyajin];
    self.taxdiffLabel.text = [NSString stringWithFormat:@"¥%@",detailData.taxdiff];
    self.shouxufeicnmLabel.text = detailData.shouxufeicnm;
    self.loanprincipalLabel.text = [NSString stringWithFormat:@"¥%@",detailData.loanprincipal];
    self.irrLabel.text = [NSString stringWithFormat:@"%@%%",detailData.irr];
    self.signamountLabel.text = [NSString stringWithFormat:@"¥%@",detailData.signamount];
    self.rentamountLabel.text = [NSString stringWithFormat:@"¥%@",detailData.rentamount];
    self.signpaymentLabel.text = [NSString stringWithFormat:@"¥%@",detailData.signpayment];
    self.paymenttermLabel.text = detailData.paymentterm;
    self.firstprincipalLabel.text = [NSString stringWithFormat:@"¥%@",detailData.firstprincipal];
    self.principalLabel.text = [NSString stringWithFormat:@"¥%@",detailData.principal];
    self.grossprofitLabel.text = [NSString stringWithFormat:@"¥%@",detailData.grossprofit];
    self.useamountLabel.text = [NSString stringWithFormat:@"¥%@",detailData.useamount];
    self.paymentdateLabel.text = detailData.paymentdate;
    self.loanstartdateLabel.text = detailData.loanstartdate;
    self.staticprofitLabel.text = [NSString stringWithFormat:@"%.3f%%",detailData.staticprofit.floatValue];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
