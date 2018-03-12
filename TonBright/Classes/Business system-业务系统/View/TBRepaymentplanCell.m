//
//  TBRepaymentplanCell.m
//  TonBright
//
//  Created by jie peng on 2018/3/6.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBRepaymentplanCell.h"
#import <Masonry/Masonry.h>
#import "TBContractDetailData.h"

@interface TBRepaymentplanCell()

/** 还款期数 */
@property (nonatomic,strong) UILabel *paymentplanPeriodLabel;
/** 还款日期 */
@property (nonatomic,strong) UILabel *paymentplanPaymentdateLabel;
/** 还款金额 */
@property (nonatomic,strong) UILabel *paymentplanRentLabel;
/** 本期本金 */
@property (nonatomic,strong) UILabel *paymentplanPrincipalLabel;
/** 本期利息 */
@property (nonatomic,strong) UILabel *paymentplanInterestLabel;
/** 本金余额 */
@property (nonatomic,strong) UILabel *paymentplanBalanceLabel;

@end

@implementation TBRepaymentplanCell

- (UILabel *)paymentplanPeriodLabel{
    if (!_paymentplanPeriodLabel) {
        _paymentplanPeriodLabel = [[UILabel alloc] init];
        _paymentplanPeriodLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_paymentplanPeriodLabel];
    }
    return _paymentplanPeriodLabel;
}

- (UILabel *)paymentplanPaymentdateLabel{
    if (!_paymentplanPaymentdateLabel) {
        _paymentplanPaymentdateLabel = [[UILabel alloc] init];
        _paymentplanPaymentdateLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_paymentplanPaymentdateLabel];
    }
    return _paymentplanPaymentdateLabel;
}

- (UILabel *)paymentplanRentLabel{
    if (!_paymentplanRentLabel) {
        _paymentplanRentLabel = [[UILabel alloc] init];
        _paymentplanRentLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_paymentplanRentLabel];
    }
    return _paymentplanRentLabel;
}

- (UILabel *)paymentplanPrincipalLabel{
    if (!_paymentplanPrincipalLabel) {
        _paymentplanPrincipalLabel = [[UILabel alloc] init];
        _paymentplanPrincipalLabel.font = [UIFont systemFontOfSize:12];
        _paymentplanPrincipalLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_paymentplanPrincipalLabel];
    }
    return _paymentplanPrincipalLabel;
}

- (UILabel *)paymentplanInterestLabel{
    if (!_paymentplanInterestLabel) {
        _paymentplanInterestLabel = [[UILabel alloc] init];
        _paymentplanInterestLabel.font = [UIFont systemFontOfSize:12];
        _paymentplanInterestLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_paymentplanInterestLabel];
    }
    return _paymentplanInterestLabel;
}

- (UILabel *)paymentplanBalanceLabel{
    if (!_paymentplanBalanceLabel) {
        _paymentplanBalanceLabel = [[UILabel alloc] init];
        _paymentplanPeriodLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_paymentplanBalanceLabel];
    }
    return _paymentplanBalanceLabel;
}

- (void)setPlanList:(TBPaymentplanlist *)planList{
    _planList = planList;
    
    self.paymentplanPeriodLabel.text = [NSString stringWithFormat:@"第%02d期",planList.period.intValue];
    self.paymentplanPaymentdateLabel.text = [NSString stringWithFormat:@"%@ ",planList.paymentdate];
    self.paymentplanRentLabel.text = [NSString stringWithFormat:@"¥%@",planList.rent];
    self.paymentplanPrincipalLabel.text = [NSString stringWithFormat:@"含本金¥%@",planList.principal];
    self.paymentplanInterestLabel.text = [NSString stringWithFormat:@"利息¥%@",planList.interest];
    
    [self.paymentplanPeriodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(20);
        make.top.mas_equalTo(self.contentView).with.offset(5);
    }];
    [self.paymentplanPaymentdateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.paymentplanPeriodLabel.mas_right).with.offset(10);
        make.centerY.equalTo(self.paymentplanPeriodLabel);
    }];
    [self.paymentplanRentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).with.offset(-20);
        make.centerY.equalTo(self.paymentplanPaymentdateLabel);
    }];
    [self.paymentplanInterestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.paymentplanRentLabel);
        make.bottom.mas_equalTo(self.contentView).with.offset(-5);
    }];
    [self.paymentplanPrincipalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.paymentplanInterestLabel.mas_left).with.offset(-5);
        make.centerY.equalTo(self.paymentplanInterestLabel);
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

@end

