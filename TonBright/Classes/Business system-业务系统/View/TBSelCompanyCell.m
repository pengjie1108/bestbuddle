//
//  TBSelCompanyCell.m
//  TonBright
//
//  Created by tonbright on 2018/3/29.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBSelCompanyCell.h"

@implementation TBSelCompanyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSeleComModel:(AbsenceTypeEnumModel *)seleComModel {
    _seleComModel = seleComModel;
    _lbe_company.text = seleComModel.parameterValue;
}

@end
