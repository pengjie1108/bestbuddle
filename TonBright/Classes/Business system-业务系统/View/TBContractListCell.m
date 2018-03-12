//
//  TBContractListCell.m
//  TonBright
//
//  Created by jie peng on 2018/2/12.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBContractListCell.h"
#import "TBContractList.h"

@interface TBContractListCell()

@property (weak, nonatomic) IBOutlet UILabel *contractnoLabel;

@property (weak, nonatomic) IBOutlet UILabel *customernmLabel;

@property (weak, nonatomic) IBOutlet UILabel *casetypenmLabel;

@property (weak, nonatomic) IBOutlet UILabel *casestatusnmLabel;

@property (weak, nonatomic) IBOutlet UILabel *salesusernmLabel;

@property (weak, nonatomic) IBOutlet UILabel *boardpassdateLabel;

@property (weak, nonatomic) IBOutlet UILabel *rentamountLabel;

@property (weak, nonatomic) IBOutlet UILabel *irrLabel;

@end

@implementation TBContractListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContractList:(TBContractList *)contractList{
    
    _contractList = contractList;
    
    self.contractnoLabel.text = contractList.contractno;
    self.customernmLabel.text = contractList.customernm;
    self.casetypenmLabel.text = contractList.casetypenm;
    self.casestatusnmLabel.text = contractList.casestatusnm;
    self.salesusernmLabel.text = contractList.salesusernm;
    self.boardpassdateLabel.text = contractList.boardpassdate;
    self.rentamountLabel.text = [NSString stringWithFormat:@"¥%@",contractList.rentamount];
    self.irrLabel.text = contractList.irr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
